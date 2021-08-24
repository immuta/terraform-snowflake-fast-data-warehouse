# Core

The `core` module serves as a "base layer" for the warehouse. It sets up the resources listed below.

- generic users
- generic roles
- generic warehouses

*Generic*, in this sense, means it is not designed to accomplish an isolated
purpose. For example, a `STITCH_USER` would reasonably be expected to operate
only on the `STITCH` database. A `BI_TOOL_USER`, on the other hand, might be
expected to operate on multiple databases.

Please note that this module does not instantiate grants on users or roles.

## Supplying values

Each of the resources created in this module accepts an array of objects
and will use a `lookup` for the object values when creating the resource. For
example, a set of warehouses could be created by passing the following map:

```{terraform}
warehouses = {
    load = {
        name           = "LOADING_WH"
        comment        = "Warehouse for Stitch and custom data loading."
        warehouse_size = "x-small"
    }
    report = {
        name           = "REPORTING_WH"
        comment        = "Warehouse for Immuta, Looker, and ad-hoc user reporting."
        warehouse_size = "x-small"
        auto_suspend   = 180
    }
}
```

## Separating System Users and Employee Users

We separate system and employee users for two reasons:

1. A list of employee users may be updated fairly frequently, whereas system users will likely remain static over time.
2. When separated, all system users can be easily listed as an output variable in the top-level module.

That said, the only built-in difference is that a password is generated for the system users, but not for the employee users.
