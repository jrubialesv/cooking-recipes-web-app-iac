@sys.description('The Web App name.')
@minLength(3)
@maxLength(30)
param appServiceAppNameprodb string = 'jrubiales-assignment-be-prod'
@sys.description('The Web App name.')
@minLength(3)
@maxLength(30)
param appServiceAppNameprodf string = 'jrubiales-assignment-fe-prod'
@sys.description('The App Service Plan name.')
@minLength(3)
@maxLength(30)
param appServicePlanNameprod string = 'jrubiales-assignment-prod'
@sys.description('The Web App name.')
@minLength(3)
@maxLength(30)
param appServiceAppNamedevb string = 'jrubiales-assignment-be-dev'
@minLength(3)
@maxLength(30)
param appServiceAppNamedevf string = 'jrubiales-assignment-fe-dev'
@sys.description('The App Service Plan name.')
@minLength(3)
@maxLength(30)
param appServicePlanNamedev string = 'jrubiales-assignment-dev'
@sys.description('The Storage Account name.')
@minLength(3)
@maxLength(30)
param storageAccountName string = 'jrubialesstorage'
@allowed([
  'nonprod'
  'prod'
  ])
param environmentType string = 'nonprod'
param location string = resourceGroup().location

@secure()
param dbhost string
@secure()
param dbuser string
@secure()
param dbpass string
@secure()
param dbname string


var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'  

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
    name: storageAccountName
    location: location
    sku: {
      name: storageAccountSkuName
    }
    kind: 'StorageV2'
    properties: {
      accessTier: 'Hot'
    }
  }

 

module appServiceprodbe 'modules/appStuff.bicep' = if (environmentType == 'prod') {
  name: 'appService1'
  params: { 
    location: location
    appServiceAppName: appServiceAppNameprodb
    appServicePlanName: appServicePlanNameprod
    runtimeStack: 'Python|3.10'
    command: 'pm2 serve /home/site/wwwroot/dist --no-daemon --spa'
    dbhost: dbhost
    dbuser: dbuser
    dbpass: dbpass
    dbname: dbname
  }
}

module appServiceprodfe 'modules/appStuff.bicep' = if (environmentType == 'prod') {
  name: 'appService3'
  params: { 
    location: location
    appServiceAppName: appServiceAppNameprodf
    appServicePlanName: appServicePlanNameprod
    runtimeStack: 'Node|14-lts'
    command: 'pm2 serve /home/site/wwwroot/dist --no-daemon --spa'
    dbhost: dbhost
    dbuser: dbuser
    dbpass: dbpass
    dbname: dbname
    
  }
}

module appServicepdevbe 'modules/appStuff.bicep' = if (environmentType == 'nonprod') {
  name: 'appService2'
  params: { 
    location: location
    appServiceAppName: appServiceAppNamedevb
    appServicePlanName: appServicePlanNamedev
    runtimeStack: 'Python|3.10'
    command: 'pm2 serve /home/site/wwwroot/dist --no-daemon --spa'
    dbhost: dbhost
    dbuser: dbuser
    dbpass: dbpass
    dbname: dbname
  }
}

module appServicedevfe 'modules/appStuff.bicep' = if (environmentType == 'nonprod') {
  name: 'appService4'
  params: { 
    location: location
    appServiceAppName: appServiceAppNamedevf
    appServicePlanName: appServicePlanNamedev
    runtimeStack: 'Node|14-lts'
    command: 'pm2 serve /home/site/wwwroot/dist --no-daemon --spa'
    dbhost: dbhost
    dbuser: dbuser
    dbpass: dbpass
    dbname: dbname
  }
}

output appServiceAppHostNameprod string = (environmentType == 'prod') ? appServiceprodbe.outputs.appServiceAppHostName : appServiceprodfe.outputs.appServiceAppHostName
output appServiceAppHostNamedev string = (environmentType == 'dev') ? appServicepdevbe.outputs.appServiceAppHostName : appServicedevfe.outputs.appServiceAppHostName
