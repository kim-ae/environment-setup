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
}

custom_envs(){
  echo -e "\033[1;34mMain env variables:\033[0m"
  echo -e "  \033[1;32mMAIN_FOLDER\033[0m=\033[0;33m$MAIN_FOLDER\033[0m"
  echo -e "  \033[1;32mLINUX_SETUP_HOME\033[0m=\033[0;33m$LINUX_SETUP_HOME\033[0m"
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


source $LINUX_SETUP_HOME/tools/.az.functions.zsh
source $LINUX_SETUP_HOME/tools/.k8s.functions.zsh
source $LINUX_SETUP_HOME/tools/.git.functions.zsh