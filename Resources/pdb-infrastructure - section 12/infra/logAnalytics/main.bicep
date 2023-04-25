//tagging information
param owner string
param costCenter string
param application string
param desc string
param repo string

param tags object = {
  owner: owner
  costCenter: costCenter
  application: application
  description: desc
  repository: repo
}

//for constructing the name of the resources
param appShort string
param domainShort string
param environment string
param version string

@description('Location of the log Analytics workspace')
param location string = resourceGroup().location

@description('Name of the Log Analytics Workspace')
param logAnalyticsWSName string = 'lg-${domainShort}-${appShort}-${environment}-${version}'

@description('log retention in days')
param retentionInDays int = 30

@description('Log analytics SKU')
param sku string = 'PerGB2018'

@description('The network access type for accessing Log Analytics ingestion. Enabled or Disabled')
param publicNetworkAccessForIngestion string = 'Enabled'

@description('The network access type for accessing Log Analytics query. Enabled or Disabled')
param publicNetworkAccessForQuery string = 'Enabled'

module logAnalytics '../../modules/logAnalytics/logAnalytics.bicep' = {
  name: '${appShort}-log-analytics-001'
  params: {
    tags: tags
    location: location
    logAnalyticsWSName: logAnalyticsWSName
    retentionInDays: retentionInDays
    sku: sku
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
  }
}
