# Application Database

The `application_database` module creates a new database, optionally with a user and waerhouse.
For example, if creating a `MY_APP` database, the module would stand up the following resources:

- `MY_APP` database
- `MY_APP` role
- `MY_APP_WH` warehouse (optional)
- `MY_APP_USER` system user (optional)

The `MY_APP` role is granted all privileges on the resources in this application.
This role can then be granted to other roles or users in your platform to 
simplify derivative resource reation and management.

## Example

A perfect use case for the `application_database` module is for developer databases.

```{terraform}
locals {
    developer_list = ["USER1", "USER2"]
}

module developer_dbs {
    for_each = local.developer_list
    source = "./modules/application_database"

    database_name       = each.value
    grant_admin_to_users = [each.value]
}
```

This would produce 2 separate databases, each only accessible to the respective developer.