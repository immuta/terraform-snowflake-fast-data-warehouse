# Bulk Role Grants

The `bulk_role_grants` module simplifies the creation of multiple Snowflake role grants.

## Inputs

The `bulk_role_grants` module accepts a map of resource configurations, along with
default attribute values for those resources that are not more specific.

For each resource, resource attributes are decided in the following order:

1. Attributes specified in the input resource map: e.g., `var.role_grants[key][attribute]`
2. Attribues specified as module inputs: e.g., `var.default_size 
3. Default attribute values for the resource. (For the `role_name` attribute, the map `key` will be used.)

For example, a set of grants could be issued by passing the following map:

```{terraform}
module role_grants {
    source = "./modules/bulk_role_grants

    grants = {
        marketing = {}                  # Grant "marketing" role to defaults
        product   = {}
        sales     = {}
        data_team = {
            role_name = "DATA_TEAM_ROLE
            roles     = []              # override default grant
            users     = ["HARRY"]       # override default user
        }
    }
    default_roles = ["DATA_TEAM]
    default_users = ["HARRY", "RON", "HERMIONE"]
}
```
