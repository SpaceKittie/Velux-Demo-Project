###################################################################################################
# Terraform Configuration for Snowflake Users
# -------------------------------------------------------------------------------------------------
# This file defines the Snowflake users.
###################################################################################################

# User: Iurii Ivanov (II)
# -----------------------
resource "snowflake_user" "user" {
  name         = var.sf_user
  login_name   = var.sf_user
  display_name = "Iurii Ivanov"
  comment      = "User account for Iurii Ivanov."
}