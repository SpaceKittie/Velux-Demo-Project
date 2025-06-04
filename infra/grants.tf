# Terraform Configuration for Snowflake Resource Grants
# -----------------------------------------------------
# This file defines the privileges granted to various roles on Snowflake objects
# such as databases, schemas, warehouses, tables, and views. It follows a
# principle of least privilege.
#
# Organization:
# 1. Grant Roles to Snowflake User
# 2. Grants for VELUX_DEV role.
# 3. Grants for VELUX_PROD_ADMIN role.
# 4. Grants for VELUX_ANALYST role.
# 5. Grants for shared/marketplace databases.
###################################################################################################

###################################################################################################
# --- PART 1: Grant Roles to Snowflake User ---
###################################################################################################

resource "snowflake_role_grants" "grant_velux_dev" {
  role_name  = snowflake_role.dev.name
  users      = [var.sf_user]
  depends_on = [snowflake_role.dev]
}

resource "snowflake_role_grants" "grant_velux_prod_admin" {
  role_name  = snowflake_role.prod_admin.name
  users      = [var.sf_user]
  depends_on = [snowflake_role.prod_admin]
}

resource "snowflake_role_grants" "grant_velux_analyst" {
  role_name  = snowflake_role.analyst.name
  users      = [var.sf_user]
  depends_on = [snowflake_role.analyst]
}

resource "snowflake_role_grants" "grant_tag_admin" {
  role_name  = snowflake_role.tag_admin.name
  users      = [var.sf_user]
  depends_on = [snowflake_role.tag_admin]
}

###################################################################################################
# --- PART 2: Privileges for VELUX_DEV Role ---
###################################################################################################

# Privileges on VELUX_DEV Database

resource "snowflake_database_grant" "velux_dev_usage_on_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "USAGE"
  roles         = [snowflake_role.dev.name]
}

resource "snowflake_database_grant" "velux_dev_create_schema_on_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "CREATE SCHEMA"
  roles         = [snowflake_role.dev.name]
}

# Schema grants in VELUX_DEV DB
resource "snowflake_schema_grant" "velux_dev_usage_on_all_schemas_in_velux_dev_db" {
  database_name          = "VELUX_DEV"
  privilege              = "USAGE"
  roles                  = [snowflake_role.dev.name]
  on_all                 = true
}

resource "snowflake_schema_grant" "velux_dev_usage_on_future_schemas_in_velux_dev_db" {
  database_name          = "VELUX_DEV"
  privilege              = "USAGE"
  roles                  = [snowflake_role.dev.name]
  on_future              = true
}

# Object grants in VELUX_DEV DB (ALL PRIVILEGES on current and future objects)
# Tables
resource "snowflake_table_grant" "velux_dev_all_on_all_tables_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_all        = true
}
resource "snowflake_table_grant" "velux_dev_all_on_future_tables_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_future     = true
}
# Views
resource "snowflake_view_grant" "velux_dev_all_on_all_views_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_all        = true
}
resource "snowflake_view_grant" "velux_dev_all_on_future_views_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_future     = true
}
# Stages
resource "snowflake_stage_grant" "velux_dev_all_on_all_stages_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_all        = true
}
resource "snowflake_stage_grant" "velux_dev_all_on_future_stages_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_future     = true
  # database_name = snowflake_database.velux_dev_db.name # If applicable
}
# File Formats
resource "snowflake_file_format_grant" "velux_dev_all_on_all_file_formats_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_all        = true
}
resource "snowflake_file_format_grant" "velux_dev_all_on_future_file_formats_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_future     = true
}
# Functions
resource "snowflake_function_grant" "velux_dev_all_on_all_functions_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_all        = true
}
resource "snowflake_function_grant" "velux_dev_all_on_future_functions_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_future     = true
}
# Procedures
resource "snowflake_procedure_grant" "velux_dev_all_on_all_procedures_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_all        = true
}
resource "snowflake_procedure_grant" "velux_dev_all_on_future_procedures_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_future     = true
}
# Streams
resource "snowflake_stream_grant" "velux_dev_all_on_all_streams_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_all        = true
}
resource "snowflake_stream_grant" "velux_dev_all_on_future_streams_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_future     = true
}
# Tasks
resource "snowflake_task_grant" "velux_dev_all_on_all_tasks_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_all        = true
}
resource "snowflake_task_grant" "velux_dev_all_on_future_tasks_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.dev.name]
  on_future     = true
}

# Read-only Privileges for VELUX_DEV on VELUX_PROD Database

resource "snowflake_database_grant" "velux_dev_usage_on_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "USAGE"
  roles         = [snowflake_role.dev.name]
}

resource "snowflake_schema_grant" "velux_dev_usage_on_all_schemas_in_velux_prod_db" {
  database_name          = "VELUX_PROD"
  privilege              = "USAGE"
  roles                  = [snowflake_role.dev.name]
  on_all                 = true
}
resource "snowflake_schema_grant" "velux_dev_usage_on_future_schemas_in_velux_prod_db" {
  database_name          = "VELUX_PROD"
  privilege              = "USAGE"
  roles                  = [snowflake_role.dev.name]
  on_future              = true
}

resource "snowflake_table_grant" "velux_dev_select_on_all_tables_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "SELECT"
  roles         = [snowflake_role.dev.name]
  on_all        = true
}
resource "snowflake_table_grant" "velux_dev_select_on_future_tables_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "SELECT"
  roles         = [snowflake_role.dev.name]
  on_future     = true
}
resource "snowflake_view_grant" "velux_dev_select_on_all_views_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "SELECT"
  roles         = [snowflake_role.dev.name]
  on_all        = true
}
resource "snowflake_view_grant" "velux_dev_select_on_future_views_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "SELECT"
  roles         = [snowflake_role.dev.name]
  on_future     = true
}

###################################################################################################
# --- PART 3: Privileges for VELUX_PROD_ADMIN Role ---
###################################################################################################

# Privileges on VELUX_DEV Database for VELUX_PROD_ADMIN

resource "snowflake_database_grant" "velux_prod_admin_ownership_on_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "OWNERSHIP"
  roles         = [snowflake_role.prod_admin.name]
}
# Granting ALL after OWNERSHIP.

resource "snowflake_database_grant" "velux_prod_admin_all_on_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  depends_on    = [snowflake_database_grant.velux_prod_admin_ownership_on_velux_dev_db]
}

# Schema grants for VELUX_PROD_ADMIN on VELUX_DEV

resource "snowflake_schema_grant" "velux_prod_admin_all_on_all_schemas_in_velux_dev_db" {
  database_name          = "VELUX_DEV"
  privilege              = "ALL PRIVILEGES"
  roles                  = [snowflake_role.prod_admin.name]
  on_all                 = true
}
resource "snowflake_schema_grant" "velux_prod_admin_all_on_future_schemas_in_velux_dev_db" {
  database_name          = "VELUX_DEV"
  privilege              = "ALL PRIVILEGES"
  roles                  = [snowflake_role.prod_admin.name]
  on_future              = true
}

# Object grants for VELUX_PROD_ADMIN on VELUX_DEV (ALL PRIVILEGES on current and future objects)

# Tables
resource "snowflake_table_grant" "velux_prod_admin_all_on_all_tables_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_table_grant" "velux_prod_admin_all_on_future_tables_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Views
resource "snowflake_view_grant" "velux_prod_admin_all_on_all_views_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_view_grant" "velux_prod_admin_all_on_future_views_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Stages
resource "snowflake_stage_grant" "velux_prod_admin_all_on_all_stages_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_stage_grant" "velux_prod_admin_all_on_future_stages_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# File Formats
resource "snowflake_file_format_grant" "velux_prod_admin_all_on_all_file_formats_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_file_format_grant" "velux_prod_admin_all_on_future_file_formats_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Functions
resource "snowflake_function_grant" "velux_prod_admin_all_on_all_functions_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_function_grant" "velux_prod_admin_all_on_future_functions_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Procedures
resource "snowflake_procedure_grant" "velux_prod_admin_all_on_all_procedures_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_procedure_grant" "velux_prod_admin_all_on_future_procedures_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Streams
resource "snowflake_stream_grant" "velux_prod_admin_all_on_all_streams_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_stream_grant" "velux_prod_admin_all_on_future_streams_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Tasks
resource "snowflake_task_grant" "velux_prod_admin_all_on_all_tasks_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_task_grant" "velux_prod_admin_all_on_future_tasks_in_velux_dev_db" {
  database_name = "VELUX_DEV"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}

# Privileges on VELUX_PROD Database for VELUX_PROD_ADMIN

resource "snowflake_database_grant" "velux_prod_admin_ownership_on_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "OWNERSHIP"
  roles         = [snowflake_role.prod_admin.name]
}
resource "snowflake_database_grant" "velux_prod_admin_all_on_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  depends_on    = [snowflake_database_grant.velux_prod_admin_ownership_on_velux_prod_db]
}

# Schema grants for VELUX_PROD_ADMIN on VELUX_PROD

resource "snowflake_schema_grant" "velux_prod_admin_all_on_all_schemas_in_velux_prod_db" {
  database_name          = "VELUX_PROD"
  privilege              = "ALL PRIVILEGES"
  roles                  = [snowflake_role.prod_admin.name]
  on_all                 = true
}
resource "snowflake_schema_grant" "velux_prod_admin_all_on_future_schemas_in_velux_prod_db" {
  database_name          = "VELUX_PROD"
  privilege              = "ALL PRIVILEGES"
  roles                  = [snowflake_role.prod_admin.name]
  on_future              = true
}

# Object grants for VELUX_PROD_ADMIN on VELUX_PROD (ALL PRIVILEGES on current and future objects)

# Tables
resource "snowflake_table_grant" "velux_prod_admin_all_on_all_tables_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_table_grant" "velux_prod_admin_all_on_future_tables_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Views
resource "snowflake_view_grant" "velux_prod_admin_all_on_all_views_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_view_grant" "velux_prod_admin_all_on_future_views_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Stages
resource "snowflake_stage_grant" "velux_prod_admin_all_on_all_stages_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_stage_grant" "velux_prod_admin_all_on_future_stages_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# File Formats
resource "snowflake_file_format_grant" "velux_prod_admin_all_on_all_file_formats_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_file_format_grant" "velux_prod_admin_all_on_future_file_formats_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Functions
resource "snowflake_function_grant" "velux_prod_admin_all_on_all_functions_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_function_grant" "velux_prod_admin_all_on_future_functions_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Procedures
resource "snowflake_procedure_grant" "velux_prod_admin_all_on_all_procedures_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_procedure_grant" "velux_prod_admin_all_on_future_procedures_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Streams
resource "snowflake_stream_grant" "velux_prod_admin_all_on_all_streams_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_stream_grant" "velux_prod_admin_all_on_future_streams_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}
# Tasks
resource "snowflake_task_grant" "velux_prod_admin_all_on_all_tasks_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_all        = true
}
resource "snowflake_task_grant" "velux_prod_admin_all_on_future_tasks_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "ALL PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
  on_future     = true
}

###################################################################################################
# --- PART 4: Privileges for VELUX_ANALYST Role ---
###################################################################################################

resource "snowflake_database_grant" "velux_analyst_usage_on_velux_prod_db" {
  database_name = "VELUX_PROD"
  privilege     = "USAGE"
  roles         = [snowflake_role.analyst.name]
}

resource "snowflake_schema_grant" "velux_analyst_usage_on_marts_schema_in_velux_prod_db" {
  database_name = "VELUX_PROD"
  schema_name   = "MARTS" # Specific schema
  privilege     = "USAGE"
  roles         = [snowflake_role.analyst.name]
}

resource "snowflake_table_grant" "velux_analyst_select_on_all_tables_in_marts_velux_prod_db" {
  database_name = "VELUX_PROD"
  schema_name   = "MARTS"
  privilege     = "SELECT"
  roles         = [snowflake_role.analyst.name]
  on_all        = true
}
resource "snowflake_table_grant" "velux_analyst_select_on_future_tables_in_marts_velux_prod_db" {
  database_name = "VELUX_PROD"
  schema_name   = "MARTS"
  privilege     = "SELECT"
  roles         = [snowflake_role.analyst.name]
  on_future     = true
}
resource "snowflake_view_grant" "velux_analyst_select_on_all_views_in_marts_velux_prod_db" {
  database_name = "VELUX_PROD"
  schema_name   = "MARTS"
  privilege     = "SELECT"
  roles         = [snowflake_role.analyst.name]
  on_all        = true
}
resource "snowflake_view_grant" "velux_analyst_select_on_future_views_in_marts_velux_prod_db" {
  database_name = "VELUX_PROD"
  schema_name   = "MARTS"
  privilege     = "SELECT"
  roles         = [snowflake_role.analyst.name]
  on_future     = true
}

###################################################################################################
# --- PART 5: Privileges for ACCUWEATHERS_HISTORICAL_WEATHER_DATA (Shared Database) ---
###################################################################################################

# Grant IMPORTED PRIVILEGES on the shared database

resource "snowflake_database_grant" "velux_dev_imported_privileges_on_accuweather" {
  database_name = "SAMPLE_OF_ACCUWEATHERS_HISTORICAL_WEATHER_DATA"
  privilege     = "IMPORTED PRIVILEGES"
  roles         = [snowflake_role.dev.name]
}

resource "snowflake_database_grant" "velux_prod_admin_imported_privileges_on_accuweather" {
  database_name = "SAMPLE_OF_ACCUWEATHERS_HISTORICAL_WEATHER_DATA"
  privilege     = "IMPORTED PRIVILEGES"
  roles         = [snowflake_role.prod_admin.name]
}

###################################################################################################
# --- PART 6: Warehouse Grants ---
###################################################################################################

resource "snowflake_warehouse_grant" "analytics_wh_usage" {
  warehouse_name = snowflake_warehouse.velux_analytics_wh.name
  privilege      = "USAGE"
  roles          = [
    snowflake_role.analyst.name,
    snowflake_role.prod_admin.name
  ]
  depends_on = [
    snowflake_warehouse.velux_analytics_wh,
    snowflake_role.analyst,
    snowflake_role.prod_admin
  ]
}

resource "snowflake_warehouse_grant" "dev_wh_usage" {
  warehouse_name = snowflake_warehouse.velux_dev_wh.name
  privilege      = "USAGE"
  roles          = [
    snowflake_role.dev.name,
    snowflake_role.prod_admin.name
  ]
  depends_on = [
    snowflake_warehouse.velux_dev_wh,
    snowflake_role.dev,
    snowflake_role.prod_admin
  ]
}

resource "snowflake_warehouse_grant" "prod_wh_usage" {
  warehouse_name = snowflake_warehouse.velux_prod_wh.name
  privilege      = "USAGE"
  roles          = [
    snowflake_role.prod_admin.name
  ]
  depends_on = [
    snowflake_warehouse.velux_prod_wh,
    snowflake_role.prod_admin
  ]
}

###################################################################################################
# --- End of Grants ---
###################################################################################################