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

load_config(){
  cp $HOME/$MAIN_FOLDER/linux-setup/tools/.hyper.js $HOME/
  cp $HOME/$MAIN_FOLDER/linux-setup/tools/.gitconfig* $HOME/
}

configs_copy(){
  cp $HOME/.hyper.js  $LINUX_SETUP_HOME/tools/
  cp $HOME/.gitconfig* $LINUX_SETUP_HOME/tools/
  dconf dump /org/cinnamon/desktop/keybindings/ > $LINUX_SETUP_HOME/configs/conf-settings.conf 
}


source $LINUX_SETUP_HOME/tools/.az.functions.zsh
source $LINUX_SETUP_HOME/tools/.k8s.functions.zsh