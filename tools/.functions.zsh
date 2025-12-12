commands(){
  echo -e "\033[1;34mAvailable commands:\033[0m"
  echo -e "  \033[1;32mchange_customer <customer_name>\033[0m - \033[0;33mChange the current customer context and reload the shell.\033[0m"
  echo -e "  \033[1;32mprint_colors\033[0m - \033[0;33mPrint all 256 terminal colors with their corresponding codes.\033[0m"
  echo -e "  \033[1;32mread_certificate <certificate_file>\033[0m - \033[0;33mRead and display details of an X.509 certificate.\033[0m"
  echo -e "  \033[1;32mload_config_tools\033[0m - \033[0;33mLoad configuration files for tools like Hyper and Git from the linux-setup repository to the home directory.\033[0m"
  echo -e "  \033[1;32msave_config_tools\033[0m - \033[0;33mSave configuration files for tools like Hyper and Git from the home directory to the linux-setup repository.\033[0m"
  echo -e "  \033[1;32maz_commands\033[0m - \033[0;33mList available Azure-related custom commands.\033[0m"
  echo -e "  \033[1;32mk8s_commands\033[0m - \033[0;33mList available Kubernetes-related custom commands.\033[0m"
  echo -e "  \033[1;32mgit_commands\033[0m - \033[0;33mList available Git-related custom commands.\033[0m"
  echo -e "  \033[1;32mdocumentation <doc_type>\033[0m - \033[0;33mOpen documentation for specified tool (e.g. filebeat).\033[0m"
}

custom_envs(){
  echo -e "\033[1;34mMain env variables:\033[0m"
  while IFS='=' read -r key value; do
    echo -e "  \033[1;32m$key\033[0m=\033[0;33m$value\033[0m"
  done < "$HOME/.custom.envs"
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

load_config_tools(){
  cp $HOME/$MAIN_FOLDER/linux-setup/tools/.hyper.js $HOME/
  cp $HOME/$MAIN_FOLDER/linux-setup/tools/.gitconfig* $HOME/
}



save_config_tools(){
  cp $HOME/.hyper.js  $LINUX_SETUP_HOME/tools/
  cp $HOME/.gitconfig* $LINUX_SETUP_HOME/tools/
}

documentation(){
  readonly doc=$1
  if [ -z "$doc" ]; then
    echo "Usage: documentation <doc_type>"
    echo "Available docs: filebeat, mimir, elasticsearch, prometheus, open-telemetry (otel)"
    return 1
  fi
  case $doc in
    "filebeat")
      google-chrome https://www.elastic.co/docs/reference/beats/filebeat
      ;;
    "mimir")
      google-chrome https://grafana.com/docs/mimir/latest/
      ;;
    "elasticsearch")
      google-chrome https://www.elastic.co/docs/reference/elasticsearch
      ;;
    "prometheus")
      google-chrome https://prometheus.io/docs/
      ;;
    "open-telemetry" | "otel")
      google-chrome https://opentelemetry.io/docs/
      ;;
    *)
      echo "Documentation not found for: $doc"
      echo "Available docs: filebeat, mimir, elasticsearch, prometheus, open-telemetry (otel)"
      ;;
  esac
}

source $LINUX_SETUP_HOME/tools/.az.functions.zsh
source $LINUX_SETUP_HOME/tools/.k8s.functions.zsh
source $LINUX_SETUP_HOME/tools/.git.functions.zsh