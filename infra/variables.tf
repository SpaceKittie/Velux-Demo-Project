###################################################################################################
# Terraform Input Variables
# -------------------------------------------------------------------------------------------------
# This file defines the input variables used by the Terraform configuration.
###################################################################################################

# Snowflake Account Identifier
# ----------------------------
# Type: string
variable "sf_account" {
  description = "Snowflake account identifier"
  type        = string
}

# Snowflake Username
# ------------------
# Type: string
variable "sf_user" {
  description = "Snowflake username"
  type        = string
  sensitive   = true
}

# Snowflake Password
# ------------------
# Type: string
variable "sf_password" {
  description = "Password used to access Snowflake"
  type        = string
  sensitive   = true
}

# Target Database Name (Legacy/Example)
# -------------------------------------
# Type: string
variable "database" {
  description = "Name of the database to create"
  type        = string  
  default     = "velux_db"
}

# Environment Name
# ----------------
# Type: string
variable "env_name" {
  description = "Environment name (e.g., DEV, STAGING, PROD)"
  type        = string
  default     = "STAGING"
}

# Data Retention Period for Time Travel
# -------------------------------------
# Type: number
# Default: 30 days
variable "time_travel_in_days" {
  description = "Number of days to retain data for time travel"
  type        = number
  default     = 30
}

# Snowflake Role for Terraform Operations
# ---------------------------------------
# Type: string
# Default: "ACCOUNTADMIN"
variable "snowflake_terraform_user_role" {
  description = "Snowflake role to use for Terraform operations."
  type        = string
  default     = "ACCOUNTADMIN"
}