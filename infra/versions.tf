###################################################################################################
# Terraform Version and Provider Requirements
# -------------------------------------------------------------------------------------------------
# This file specifies the versions of Terraform and providers required for this configuration.
###################################################################################################

# Terraform Block
# --------------- 
# Defines Terraform settings, including required provider versions.
terraform {
  required_providers {
    # Snowflake Provider Configuration
    # Specifies the source and version for the Snowflake provider.
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 0.86.0"
    }
  }
}