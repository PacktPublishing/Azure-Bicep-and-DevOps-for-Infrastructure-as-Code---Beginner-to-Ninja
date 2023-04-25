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

@description('Standard Name for Resources')
param partName string = '${domainShort}-${appShort}-${environment}-${version}'

@description('Name of the Log Analytics Workspace')
param dataFactoryName string = 'df-${partName}'

@description('Name of the Log Analytics Workspace')
param logAnalyticsWSName string = 'lg-${partName}'

resource logAnalyticsWorkspace 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' existing = {
  name: logAnalyticsWSName
}

var workspaceId = resourceId('Microsoft.OperationalInsights/workspaces', logAnalyticsWorkspace.name)

module dataFactory '../../modules/dataFactory/dataFactory.bicep' = {
  name: '${appShort}-data-factory-001'
  params: {
    tags: tags
    location: location
    dataFactoryName: dataFactoryName
    workspaceId: workspaceId
  }
}
