@description('Location for all resources.')
param location string = resourceGroup().location

@description('VNet name.')
param virtualNetworkName string = 'vNet'

var subnetName = 'backendSubnet'


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

output location string = location
output resourceGroupName string = resourceGroup().name
