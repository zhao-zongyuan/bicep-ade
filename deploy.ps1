az login --use-device-code

az deployment group create --resource-group 'tst-jz-terraform' --template-file 'environment-defination/iac-sandbox-advanced/main.bicep' 




