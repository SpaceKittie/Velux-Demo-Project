###################################################################################################
# Terraform Configuration for Snowflake Custom Roles
# -------------------------------------------------------------------------------------------------
# This file defines the custom Snowflake roles used within the VELUX environment.
###################################################################################################

# VELUX Production Administrator Role (VELUX_PROD_ADMIN)
# ------------------------------------------------------
resource "snowflake_role" "prod_admin" {
  name = "VELUX_PROD_ADMIN"
}

# VELUX Developer Role (VELUX_DEV)
# --------------------------------
resource "snowflake_role" "dev" {
  name       = "VELUX_DEV"
  depends_on = [snowflake_role.prod_admin]
}

# VELUX Analyst Role (VELUX_ANALYST)
# ----------------------------------
resource "snowflake_role" "analyst" {
  name       = "VELUX_ANALYST"
  depends_on = [snowflake_role.dev]
}

# Tag Administrator Role (TAG_ADMIN)
# ----------------------------------
resource "snowflake_role" "tag_admin" {
  name = "TAG_ADMIN"
}
