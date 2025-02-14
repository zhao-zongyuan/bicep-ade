
param utcvalue string = utcNow('d')

resource applyTags 'Microsoft.Resources/tags@2021-04-01' = {
  name: 'CreationDateTag'
  properties: {
    tags: {
      creationTime: utcvalue
    }
  }
}

output resourceGroupName string = resourceGroup().name
