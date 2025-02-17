az login --use-device-code

az deployment group create --resource-group 'bicep-iac-tag-2' `
--template-file 'environment-defination/iac-sandbox-advanced/main.bicep' `
--parameters vNetDeployment = $true



az deployment group create --resource-group 'bicep-iac-tag-2' `
--template-file 'environment-defination/iac-test/main.bicep' `
--parameters vNetDeployment = $true

