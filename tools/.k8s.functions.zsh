k8s_get_secret(){
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
  for i in $(kubectl api-resources --namespaced --verbs=list -o name | tr "\n" " "); do 
    kubectl get $i --show-kind --ignore-not-found -n $1
  done
}