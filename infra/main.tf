###################################################################################################
# Main Terraform Configuration File
# -------------------------------------------------------------------------------------------------
# Defines primary configurations.
###################################################################################################

# Snowflake Provider Configuration
# --------------------------------
# This block configures the connection to the Snowflake account.

provider "snowflake" {
  user     = var.sf_user       
  account  = var.sf_account    
  role     = "ACCOUNTADMIN"    # Temporary for demonstration purposes (not to use in production)
  password = var.sf_password   
}