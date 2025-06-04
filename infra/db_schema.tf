###################################################################################################
# Terraform Configuration for Snowflake Databases and Schemas
# -------------------------------------------------------------------------------------------------
# This file defines the Snowflake databases.
###################################################################################################

# Development Database (VELUX_DEV)
# --------------------------------
resource "snowflake_database" "dev" { 
  name = "VELUX_DEV"
  
  lifecycle {
    ignore_changes = all
  }
}

# Production Database (VELUX_PROD)
# --------------------------------
resource "snowflake_database" "prod" { 
  name = "VELUX_PROD"
  
  lifecycle {
    ignore_changes = all
  }
}

# Schemas for VELUX_DEV Database (RAW, STAGING, MARTS)
# ----------------------------------------------------
resource "snowflake_schema" "velux_dev_schemas" {
  for_each = toset(["RAW", "STAGING", "MARTS"])
  database = snowflake_database.dev.name
  name     = each.key
  depends_on = [snowflake_database.dev, snowflake_database_grant.velux_dev_create_schema_on_velux_dev_db]
  
  lifecycle {
    prevent_destroy = true
    ignore_changes = all
  }
}

# Schemas for VELUX_PROD Database (RAW, STAGING, MARTS)
# -----------------------------------------------------
resource "snowflake_schema" "velux_prod_schemas" {
  for_each = toset(["RAW", "STAGING", "MARTS"])
  database = snowflake_database.prod.name
  name     = each.key
  depends_on = [snowflake_database.prod, snowflake_database_grant.velux_prod_admin_ownership_on_velux_prod_db]
  
  lifecycle {
    prevent_destroy = true
    ignore_changes = all
  }
}

