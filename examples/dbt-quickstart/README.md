# Fishtown Analyltics Quick-Start

Instantiating the above module will create a set of resources mostly aligned
with those outined in [this great Fishtown Analytics blog post](https://blog.getdbt.com/how-we-configure-snowflake/).


Below is a summary of the resources created:

1. Two "employee users", each with their own isolated development databases and access to _only_ read-only assets in the _ANALYTICS_ database.

2. Three "raw" storage application databases - STITCH, FIVETRAN, and MELTANO - with system users that have administrative access.

3. Two databases accessible only by the `DBT_CLOUD` role: `ANALYTICS_STAGING` and `ANALYTICS_PROD`.

4. A couple of general roles:
- `ANALYST` should be able to read _only_ from the production `ANALYTICS_PROD` database.
- The `READER` role with read-only access to all databases.
- `SYSADMIN` should have admin access to all the created database resources.
- `DBT_CLOUD` should have admin access to the dev and staging analytics databases, and read-only access to other databases.


##  Additional resources

Some great content from dbt Labs, whether you use Terraform or not.

- dbt Blog: [How we configure Snowflake](https://blog.getdbt.com/how-we-configure-snowflake/)
- dbt Discourse: [Setting up Snowflake - the exact grant statements we run](https://discourse.getdbt.com/t/setting-up-snowflake-the-exact-grant-statements-we-run/439)
- dbt Blog: [Five principles that will keep your data warehouse organized](https://blog.getdbt.com/five-principles-that-will-keep-your-data-warehouse-organized/)
