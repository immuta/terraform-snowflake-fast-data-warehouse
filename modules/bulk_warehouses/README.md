# Bulk Warehouses

The `bulk_warehouses` module simplifies the creation of multiple Snowflake warehouses.

Please note that this module does not handle any resource grants.

## Inputs

The `bulk_warehouses` module accepts a map of resource configurations, along with
default attribute values for those resources that are not more specific.

For each resource, resource attributes are decided in the following order:

1. Attributes specified in the input resource map: e.g., `var.warehouses[key][attribute]`
2. Attribues specified as module inputs: e.g., `var.default_size 
3. Default attribute values for the resource. (For the `name` attribute, the map `key` will be used.)

For example, a set of warehouses could be created by passing the following map:

```{terraform}
module warehouses {
    source = "./modules/bulk_warehouses

    warehouses = {
        loading_wh = {}
        reporting = {
            name           = "REPORT_WH"
            comment        = "Warehouse for end user reporting."
            size           = "x-small"
            auto_suspend   = 180
        }
    }
    default_size = "medium"
    default_comment = "Managed by Terraform"
}
```
