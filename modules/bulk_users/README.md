# Bulk Users

The `bulk_users` module simplifies the creation of multiple Snowflake users.

Please note that this module does not handle any resource grants.

## Inputs

The `bulk_users` module accepts a map of resource configurations, along with
default attribute values for those resources that are not more specific.

For each resource, resource attributes are decided in the following order:

1. Attributes specified in the input resource map: e.g., `var.users[key][attribute]`
2. Attribues specified as module inputs: e.g., `var.default_comment`
3. Default attribute values for the resource. (For the `name` attribute, the map `key` will be used.)

For example, a set of warehouses could be created by passing the following map:

```{terraform}
module employees {
    source = "./modules/bulk_users

    warehouses = {
        harry    = {}
        hermione = {}
        ron      = {
            first_name = "Ronald"
            login_name = "Ron"
        }
    }

    default_must_change_password = true
    default_comment              = "Employee user managed by Terraform"
}
```

This module can simplify the creation of generic system users
that may need read-only access to parts of your system. Note that need privileged
access to an isolated database may be best handled by the `application_database`
module.
