###################################################################################################
# Terraform Configuration for Granting Roles to Users
# -------------------------------------------------------------------------------------------------
# This file manages the assignment of specific Snowflake roles to users.
###################################################################################################

# Grant VELUX_DEV Role to Primary Snowflake User
# ----------------------------------------------
# Assigns the VELUX_DEV role to the user specified by `var.sf_user`.
# This allows the user to assume the VELUX_DEV role for development activities.
resource "snowflake_role_grants" "user_dev_role" {
  role_name = snowflake_role.dev.name
  users     = [upper(var.sf_user)]
  depends_on = [snowflake_role.dev]
}

# Grant VELUX_ANALYST Role to Primary Snowflake User
# --------------------------------------------------
# Assigns the VELUX_ANALYST role to the user specified by `var.sf_user`.
# This allows the user to assume the VELUX_ANALYST role for analytical queries and reporting.
resource "snowflake_role_grants" "user_analyst_role" {
  role_name = snowflake_role.analyst.name
  users     = [upper(var.sf_user)]
  depends_on = [snowflake_role.analyst]
}

# Grant VELUX_PROD_ADMIN Role to Primary Snowflake User
# -----------------------------------------------------
# Assigns the VELUX_PROD_ADMIN role to the user specified by `var.sf_user`.
# This allows the user to assume the VELUX_PROD_ADMIN role for production administration tasks.
resource "snowflake_role_grants" "user_prod_admin_role" {
  role_name = snowflake_role.prod_admin.name
  users     = [upper(var.sf_user)]
  depends_on = [snowflake_role.prod_admin]
}
