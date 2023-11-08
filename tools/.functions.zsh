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

