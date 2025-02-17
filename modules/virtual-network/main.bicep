// modules/network/main.bicep
param location string
param addressPrefix string
param subnetPrefix string
param subnetName string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'vnet-${location}' // Append environment for uniqueness
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}

output virtualNetworkId string = virtualNetwork.id
output subnetId string = virtualNetwork.properties.subnets[0].id
