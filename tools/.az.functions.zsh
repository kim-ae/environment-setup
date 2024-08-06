az_get_outbound_ip(){
    az network public-ip show --ids $1 --query ipAddress -o tsv
}