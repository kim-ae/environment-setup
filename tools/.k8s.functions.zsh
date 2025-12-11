k8s_commands(){
  echo "Available k8s commands:"
  echo "  k8s_get_secret <secret_name> <namespace> <secret_field> - Get and decode a specific field from a Kubernetes secret."
  echo "  k8s_access_node <node_name> - Access the filesystem of a specific Kubernetes node via a temporary pod."
  echo "  k8s_list_all_resources_for <namespace> - List all resources in a specified namespace."
  echo "  k8s_list_selected_resources_for <namespace> <label_selector> - List resources in a namespace filtered by a label selector."
  echo "  k8s_remove_finalizer <resource_type> <resource_name> <namespace> - Remove finalizers from a specified resource."
  echo "  k8s_force_remove <resource_type> <resource_name> <namespace> - Force delete a resource by removing its finalizers first."
  echo "  k8s_ctx - Interactively switch between Kubernetes contexts using kubectx."
  echo "  k8s_ns - Interactively switch between namespaces in the current context."
  echo "  k8s_suspend_kustomize <name> [namespace] - Suspend a Flux Kustomization in the specified or default namespace."
  echo "  k8s_create_sealed_secret <namespace> <secret_name> <key=value,...> <output_file> [controller_namespace] - Create a sealed secret for use with Sealed Secrets."
  echo "  k8s_debug <namespace> <pod> <container> - Debug a specific container in a pod by attaching a temporary BusyBox container."
}

k8s_get_secret(){
  if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: k8s_get_secret <secret_name> <namespace> <secret_field>"
    return 1
  fi
  kubectl get secret $1 -n $2 -o jsonpath="{.data.$3}" | base64 -d
}


k8s_access_node(){
  export NODE_NAME=$1
  export POD_NAME="hostpath-volume-pod"

  cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: Pod
    metadata:
      name: ${POD_NAME}
    spec:
      nodeName: ${NODE_NAME}
      volumes:
      - name: host-var
        hostPath:
          path: /var
      - name: host-root
        hostPath:
          path: /
      containers:
      - name: hostpath-volume-container
        image: debian:trixie-slim
        command:
          - "/bin/sh"
          - "-c"
          - "while true; do echo Hello from the host path volume; sleep 10; done;"
        volumeMounts:
        - name: host-var
          mountPath: /var
          readOnly: true
        - name: host-root
          mountPath: /mnt/host
          readOnly: true
EOF

  kubectl get pods "${POD_NAME}" &> /dev/null
  while [ $? = 1  ] ; do
    sleep 1
    echo "trying to connect"
    kubectl get pods ${POD_NAME} &> /dev/null
  done

  kubectl exec "${POD_NAME}" -- /bin/sh

  kubectl delete pod "${POD_NAME}"  &> /dev/null
}

k8s_list_all_resources_for(){
  if [ -z "$1" ]; then
    echo "Usage: k8s_list_all_resources_for <namespace>"
    echo "Example: k8s_list_all_resources_for default"
    return 1
  fi
  for i in $(kubectl api-resources --namespaced --verbs=list -o name | tr "\n" " "); do 
    output="$(kubectl get $i --show-kind --ignore-not-found -n $1)"
    if [ ! -z "$output" ]; then
      echo "--- $i ---"
      echo "$output"
      echo "---------------------------------------------"
    fi
  done
}

k8s_list_selected_resources_for(){
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: k8s_list_selected_resources_for <namespace> <label_selector>"
    echo "Example: k8s_list_selected_resources_for default 'app=my-app'"
    return 1
  fi
  for i in $(kubectl api-resources --namespaced --verbs=list -o name | tr "\n" " "); do 
    output="$(kubectl get $i --show-kind --ignore-not-found -n $1 -l $2)"
    if [ ! -z "$output" ]; then
      echo "--- $i ---"
      echo "$output"
      echo "---------------------------------------------"
    fi
  done
}

k8s_remove_finalizer(){
  if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: k8s_remove_finalizer <resource_type> <resource_name> <namespace>"
    echo "Example: k8s_remove_finalizer pod my-pod default"
    return 1
  fi
  kubectl patch $1 $2 -n $3 -p '{"metadata":{"finalizers":[]}, "spec":{"patchID":1}}' --type=merge
}

k8s_force_remove(){
   k8s_remove_finalizer $1 $2 $3  &&  kubectl delete $1 $2 -n $3
}

k8s_ctx(){
  select ctx in $(kubectx)
  do 
    kubectx $ctx
    break
  done
}

k8s_ns(){
  select ns in $(k get ns -o jsonpath="{range .items[*]}{@.metadata.name}{\"\n\"}{end}")
  do 
    k config set-context --current --namespace=$ns
    break
  done
}

k8s_suspend_kustomize(){
  readonly name=$1
  declare ns=$2
  if [ -z "${ns}" ]
  then
    ns=$name
  fi
  
  flux suspend kustomization $name -n $ns
}


k8s_create_sealed_secret(){
  readonly namespace=$1
  readonly secret_name=$2
  readonly values=$3
  readonly output_file=$4
  declare controller_namespace=${5:-kube-system}

  if [ -z "${namespace}" ] || [ -z "${secret_name}" ] || [ -z "${values}" ] || [ -z "${output_file}" ]; then
    echo "Usage: create_sealed_secret <namespace> <secret-name> <key=value,...> <output-file> [controller-namespace]"
    echo "Example: create_sealed_secret myapp default db-creds 'password=123,key=456' sealed-secret.yaml"
    return 1
  fi

  # Convert comma-separated key=value pairs to --from-literal arguments
  literal_args=""
  pairs=(${(s:,:)values})
  for pair in "${pairs[@]}"; do
    literal_args+="--from-literal=$pair "
  done

  # Wrap literal_args in quotes to preserve all arguments
  eval "kubectl create secret generic $secret_name \
    --namespace $namespace \
    ${literal_args} \
    --dry-run=client -o yaml | \
    kubeseal --controller-namespace=$controller_namespace --format=yaml > $output_file"
}

k8s_debug(){
  readonly namespace=$1
  readonly pod=$2
  readonly container=$3
  readonly image=${4:-busybox}
  if [ -z "$namespace" ] || [ -z "$pod" ] || [ -z "$container" ]; then
    echo "Usage: k8s_debug <namespace> <pod> <container> [image]"
    echo "Example: k8s_debug default my-pod my-container busybox"
    return 1
  fi
  kubectl debug -n $namespace -it $pod --image=$image --target=$container
}