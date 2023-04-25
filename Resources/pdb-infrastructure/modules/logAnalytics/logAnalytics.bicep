@description('Tags that the resources needs')
param tags object

@description('Location of the log Analytics workspace')
param location string

@description('Name of the Log Analytics Workspace')
param logAnalyticsWSName string

@description('log retention in days')
param retentionInDays int = 30

@description('Log analytics SKU')
param sku string = 'PerGB2018'

@allowed([
  'Enabled'
  'Disabled'
])
@description('The network access type for accessing Log Analytics ingestion. Enabled or Disabled')
param publicNetworkAccessForIngestion string = 'Enabled'

@allowed([
  'Enabled'
  'Disabled'
])
@description('The network access type for accessing Log Analytics query. Enabled or Disabled')
param publicNetworkAccessForQuery string = 'Enabled'

resource logAnalyticsWS 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: logAnalyticsWSName
  location: location
  tags: tags
  properties: {
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
    retentionInDays: retentionInDays
    sku: {
      name: sku
    }
  }
}

output logAnalyticsWSName string = logAnalyticsWS.name
output logAnalyticsWSResourceID string = logAnalyticsWS.id
