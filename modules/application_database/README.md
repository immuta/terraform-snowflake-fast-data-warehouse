# Application Database

The `application_database` module creates a new database, optionally with a user and waerhouse. For example, if creating a `MY_APP` database, the module would stand up the following resources:

- `MY_APP` database
- `MY_APP` role
- `MY_APP_WH` warehouse (optional)
- `MY_APP_USER` system user (optional)

The `MY_APP` role is granted privileges on other resources in this application.
This role can then be passed onto other roles in your warehouse to grant elevated privileges on the resource.

## Example

A perfect use case for the `application_database` module is for developer databases.

```{terraform}
module developer_dbs {
    for_each = ["USER1", "USER2"]
    source = "./modules/application_database"

    database_name = each.value
    create_application_user = false
    grant_role_to_users = [each.value]
}
```

This would produce 2 separate databases, each only accessible to the respective developer.