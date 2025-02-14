
targetScope = 'subscription'
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  
  name: 'rg-default'
  location: 'eastus'
  tags: {
    environment: 'dev'
  }
}

output resourceGroupName string = resourceGroup.name
