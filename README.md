# terraform-snowflake-fast-data-warehouse
Quickly set up a basic data warehouse with Terraform's Snowflake provider

This repo contains the Terraform for standing up Immuta's Snowflake data warehouse. It leverages the [Terraform Snowflake provider](https://github.com/chanzuckerberg/terraform-provider-snowflake).

## Strategy

The Terraform provided here has three layers:

- `core`: These are the core employee usres, system users and warehouses that you want to create.
- `database`: These are the applications, such as loaders or developer databases, that you want to create.
- `integration`: This is the association between users and specific roles you want to leverage.

We have created database modules for the `core` and `database` layers to increase consistency between applications and ease the management burden, especially around role management.

### A word on GRANT resources

There is a trick to using the Snowflake Teraform provider rooted in the way `grant` resources work. the primary key for a grant resource is `object | privilege | with_grant` and accepts a list of roles and users. If attmpting to add multiple layers of grants, the resources will conflict and constantly overwrite.

To address this, the only grants to applications that are allowed are pushed into the module.

- `core`: all users have the `public` role as their default role. No other grants made.
- `database`: An application database, role, user (optional) and warehouse (optional) are created. A list of roles and users who should have access to application resources is provided. No other assignments may be made on this role (although its reosurcse _may_ be used later on.)
- `integration`: this layer should be used for additional resources and grants between `core` resources and othre objets, including `core` warehouses and individual application users.

### Setting up the TERRAFORM role

The user running Terraform will need elevated permissions to create users, databases, and other resources. Here is a snippet you can run to grant the resources required for this module.

```{terraform}
//set up role and user
create role terraform;
grant role terraform to user terraform_user;

// account privileges
grant create user on account to role terraform;
grant create database on account to role terraform;
grant create integration on account to role terraform;
grant create role on account to role terraform;
grant create warehouse on account to role terraform;
grant manage grants on account to role terraform;
```

You will want to create and protect these permissions very carefully, as they allow the user to set up your warehouse -- and tear it down!
