###################################################################################################
# Terraform Configuration for Snowflake Network Policies
# -------------------------------------------------------------------------------------------------
# This file defines the Snowflake network policies.
###################################################################################################

# Network Policy: ALLOW_ALL_IPS_POLICY
# ------------------------------------
# Allows connections from any IP address.
resource "snowflake_network_policy" "allow_all_ips" {
  name              = "ALLOW_ALL_IPS_POLICY"
  allowed_ip_list   = ["0.0.0.0/0"]
  comment           = "Network policy that allows connections from all IP addresses." # Temporary for demonstration purposes (not to use in production)
}

# Attachment: Assign ALLOW_ALL_IPS_POLICY to Snowflake User
# --------------------------------------------------
resource "snowflake_network_policy_attachment" "allow_all_to_user" {
  network_policy_name = snowflake_network_policy.allow_all_ips.name
  users               = [snowflake_user.user.name]
}
