change_customer(){
  echo "export CUSTOMER=$1" > "$HOME/.current-customer"
  source ~/.zshrc
  copy-context
  source ~/.zshrc
}

print_colors(){
    for c in {0..255}; do
      printf "\033[48;5;%sm%3d\033[0m " "$c" "$c"
      if (( c == 15 )) || (( c > 15 )) && (( (c-15) % 6 == 0 )); then
          printf "\n";
      fi
    done
}

read_certificate(){
    openssl x509 -in $1 -text -noout
}

access_node(){
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