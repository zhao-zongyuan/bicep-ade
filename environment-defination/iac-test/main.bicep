// deployments/dev/main.bicep
param location string = 'australiaeast' // Default location

// Call the network module
module networkModule '../../modules/virtual-network/main.bicep' = {
  name: 'network-deployment' // Give the deployment a name
  params: {
    location: location
    addressPrefix: '10.10.0.0/16' // Override parameter if needed
    subnetPrefix: '10.10.1.0/24'
    subnetName: 'internal'
  }
}
output resourceGroupName string = resourceGroup().name
