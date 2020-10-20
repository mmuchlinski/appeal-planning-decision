# Environments

Infrastructure which the applications are deployed toInfrastructure which is common to the su

## Requirements

| Name | Version |
|------|---------|
| azurerm | ~> 2.31.1 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.31.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| container\_registry\_name | Name of the container registry | `string` | `"pinscommonukscontainersprod"` | no |
| container\_registry\_rg\_name | Name of the registry's resource group | `string` | `"pinscommon-uks-containers-prod"` | no |
| location | Default location for resources | `string` | `"uksouth"` | no |
| mongodb\_failover\_read\_locations | Locations where read failover replicas are created for MongoDB | `list(string)` | `[]` | no |
| mongodb\_max\_throughput | Max throughput of the MongoDB database - set in increments of 1,000 between 4,000 and 1,000,000 | `number` | `4000` | no |
| prefix | Resource prefix | `string` | `"pins"` | no |
| web\_app\_size | Machine size for the web apps | `string` | `"S1"` | no |
| web\_app\_tier | Server tier for the web apps | `string` | `"Standard"` | no |

## Outputs

| Name | Description |
|------|-------------|
| app-name | The application name - used for identifying resource groups |
| appeals\_api\_mongodb\_name | MongoDB name |
| appeals\_api\_mongodb\_primary\_connection\_string | Primary connection string for the MongoDB |
| appeals\_api\_mongodb\_secondary\_connection\_string | Secondary connection string for the MongoDB - to be used when generating new keys |
