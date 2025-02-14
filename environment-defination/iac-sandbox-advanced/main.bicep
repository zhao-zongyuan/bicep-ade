@description('Optional Virtual Network')
param vNetDeployment bool = false
@description('Create a resource group with a tag for creation time')
param utcvalue string = utcNow('d')

resource creationTimeTags 'Microsoft.Resources/tags@2021-04-01' =  {
  name: 'default'
  properties: {
    tags: {
      creationTime: utcvalue
    }
  }
}

resource virtualnetwork 'Microsoft.Network/virtualNetworks@2020-11-01' = if(vNetDeployment) {
  name: 'vnet-default'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

output resourceGroupName string = resourceGroup().name
