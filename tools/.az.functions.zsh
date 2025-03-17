az_get_outbound_ip(){
    az network public-ip show --ids $1 --query ipAddress -o tsv
}

az_acr_login(){
    TOKEN=$(az acr login -n $1 --expose-token -o tsv --query accessToken)
    podman pull $1.azurecr.io/$2 --creds 00000000-0000-0000-0000-000000000000:$TOKEN
}


az_is_reserved(){
    if [ "$1" = "-help" ]; then
        echo "az_is_reserved <resourceGroupName> <vmssName>"
        return 0
    fi

    resourceGroupName=$1
    vmssName=$2

    # Get the scale set details
    vmss=$(az vmss show --resource-group $resourceGroupName --name $vmssName --query "sku.capacityReservationGroup" --output tsv) 

    # Check if the scale set is using reserved instances
    if [ -z "$vmss" ]; then 
        echo "The scale set is not using reserved instances." 
    else 
        echo "The scale set is using reserved instances: $vmss" 
    fi
}

az_get_subscription_by_name(){
    az account list --query "[].{ID:id, Name:name}" -o table | grep $1 
}

#az aks show -g kubility-shared -n kubility-prod --query "networkProfile.loadBalancerProfile.effectiveOutboundIPs[].id" 