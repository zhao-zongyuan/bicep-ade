
param utcvalue string = utcNow('d')

resource creationTimeTags 'Microsoft.Resources/tags@2021-04-01' = {
  name: 'default'
  properties: {
    tags: {
      creationTime: utcvalue
    }
  }
}

output resourceGroupName string = resourceGroup().name
