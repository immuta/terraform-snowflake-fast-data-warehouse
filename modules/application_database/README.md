# App Database Module

The `app_database` module creates a new database, optionally with a user and waerhouse. For example, if creating a `COOLAPP` database, the module would stand up the following resources:

- `COOLAPP` role
- `COOLAPP` database
- `COOLAPP_WH` warehouse (optional)
- `COOLAPP_USER` system user (optional)

The `COOLAPP` role is granted privileges on other resources in this application. This role can then be passed onto other roles in your warehouse to grant elevated privileges on the resource.

## Example

A perfect use case for the `app_database` module is for developer databases.

```{terraform}
module "developer_dbs" {
    for_each = ["USER1", "USER2"]
    source = "./modules/app_database"

    db_name = each.value
    create_user = false
    grant_role_to_users = [each.value]
}
```

This would produce 2 separate databases, each only accessible to the respective developer.