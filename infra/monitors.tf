###################################################################################################
# Terraform Configuration for Snowflake Resource Monitors
# -------------------------------------------------------------------------------------------------
# This file defines resource monitors to control credit consumption by Snowflake warehouses.
###################################################################################################

# Resource Monitor for VELUX_DEV_WH
# ---------------------------------
# Purpose: Monitors credit usage for the VELUX_DEV_WH (development warehouse).
# Configuration:
# - name: DEV_WH_MONITOR
# - credit_quota: 500 credits
# - frequency: MONTHLY 
# - start_timestamp: Defines when the monitor starts operating.
# - notify_triggers: Sends notifications at 50% and 90% of the credit quota.
# - suspend_trigger: Suspends the warehouse at 100% of the credit quota.
# - warehouses: Applies this monitor specifically to the VELUX_DEV_WH.

resource "snowflake_resource_monitor" "dev_wh_guardrail" {
  name             = "DEV_WH_MONITOR"
  credit_quota     = 500           
  frequency        = "MONTHLY"     
  notify_triggers  = [50, 90]    
  start_timestamp  = "2025-06-04 13:00"
  suspend_trigger  = 100         
  warehouses       = [snowflake_warehouse.velux_dev_wh.name]
}

# Resource Monitor for VELUX_PROD_WH
# ----------------------------------
# Purpose: Monitors credit usage for the VELUX_PROD_WH (production warehouse).
# Configuration:
# - name: PROD_WH_MONITOR
# - credit_quota: 500 credits
# - frequency: MONTHLY 
# - start_timestamp: Defines when the monitor starts operating.
# - notify_triggers: Notifications at 50% and 90% of credit quota.
# - suspend_trigger: Suspends warehouse at 100% of credit quota.
# - warehouses: Applies to VELUX_PROD_WH.

resource "snowflake_resource_monitor" "prod_wh_guardrail" {
  name             = "PROD_WH_MONITOR"
  credit_quota     = 500           
  frequency        = "MONTHLY"     
  notify_triggers  = [50, 90]    
  start_timestamp  = "2025-06-04 13:00"
  suspend_trigger  = 100         
  warehouses       = [snowflake_warehouse.velux_prod_wh.name]
}

# Resource Monitor for VELUX_ANALYTICS_WH
# ---------------------------------------
# Purpose: Monitors credit usage for the VELUX_ANALYTICS_WH (analytics warehouse).
# Configuration:
# - name: ANALYTICS_WH_MONITOR
# - credit_quota: 1000 credits
# - frequency: MONTHLY 
# - start_timestamp: Defines when the monitor starts operating.
# - notify_triggers: Notifications at 50%, 80%, and 95% of credit quota.
# - suspend_trigger: Suspends warehouse at 100% of credit quota.
# - warehouses: Applies to VELUX_ANALYTICS_WH.

resource "snowflake_resource_monitor" "analytics_wh_guardrail" {
  name             = "ANALYTICS_WH_MONITOR"
  credit_quota     = 1000      
  frequency        = "MONTHLY"  
  notify_triggers  = [50, 80, 95]
  start_timestamp  = "2025-06-04 13:00"
  suspend_trigger  = 100         
  warehouses       = [snowflake_warehouse.velux_analytics_wh.name]
}