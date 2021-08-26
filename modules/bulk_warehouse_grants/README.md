# Bulk Warehouse Grants

The `bulk_warehouse_grants` module simplifies the creation of multiple Snowflake warehouse grants.

## Inputs

The `bulk_warehouse_grants` module accepts a map of resource configurations, along with
default attribute values for those resources that are not more specific.

For each resource, resource attributes are decided in the following order:

1. Attributes specified in the input resource map: e.g., `var.warehouse_grants[key][attribute]`
2. Attribues specified as module inputs: e.g., `var.default_size 
3. Default attribute values for the resource. (For the `warehouse_name` attribute, the map `key` will be used.)

For example, a set of grants could be issued by passing the following map:

```{terraform}
module warehouse_grants {
    source = "./modules/bulk_warehouse_grants

    grants = {
        loading_wh        = {}
        transforming_wh   = {}
        reporting_wh      = {
            roles = ["LOOKER_ROLE", "PUBLIC"]
        }
    }
    default_privilege = "USAGE"
    default_roles = ["DATA_TEAM_ROLE"]
}
```
