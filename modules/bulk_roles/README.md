# Bulk Roles

The `bulk_roles` module simplifies the creation of multiple Snowflake roles.

Please note that this module does not handle any resource grants.

## Inputs

The `bulk_roles` module accepts a map of resource configurations, along with
default attribute values for those resources that are not more specific.

For each resource, resource attributes are decided in the following order:

1. Attributes specified in the input resource map: e.g., `var.roles[key][attribute]`
2. Attribues specified as module inputs: e.g., `var.default_size 
3. Default attribute values for the resource. (For the `name` attribute, the map `key` will be used.)

For example, a set of roles could be created by passing the following map:

```{terraform}
module roles {
    source = "./modules/bulk_roles

    roles = {
        marketing = {}
        product   = {}
        sales     = {}
        data_team = {
            comment = "They're just so cool.
        }
    }

    default_comment = "Organization roles managed by Terraform"
}
```
