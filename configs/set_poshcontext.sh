function set_poshcontext(){
     export TAIL=$(tailscale status &>/dev/null; echo $?)
     export VPN_IP=$(ip -o -4 addr show | grep -E 'tailscale' | sed -nr 's/^.+tailscale.+inet\s([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).+/\1/p')
}