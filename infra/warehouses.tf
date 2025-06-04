###################################################################################################
# Terraform Configuration for Snowflake Warehouses
# -------------------------------------------------------------------------------------------------
# This file defines the virtual warehouses used for compute resources in Snowflake.
# Each warehouse is configured with a specific size, auto-suspend/resume behavior,
# and scaling policy appropriate for its intended workload (e.g., development, production, analytics).
###################################################################################################

# Development Warehouse (VELUX_DEV_WH)
# ------------------------------------
# Configuration:
# - Size: X-SMALL (cost-effective for typical development tasks)
# - Auto-suspend: 5 seconds (quick suspension to save credits when idle)
# - Auto-resume: Enabled (automatically resumes when queries are issued)
resource "snowflake_warehouse" "velux_dev_wh" {
  name           = "VELUX_DEV_WH"
  warehouse_size = "X-SMALL"
  auto_suspend   = 5
  auto_resume    = true
}

# Production Warehouse (VELUX_PROD_WH)
# ------------------------------------
# Configuration:
# - Size: X-SMALL (can be adjusted based on actual production load)
# - Auto-suspend: 5 seconds (quick suspension to save credits)
# - Auto-resume: Enabled
resource "snowflake_warehouse" "velux_prod_wh" {
  name           = "VELUX_PROD_WH"
  warehouse_size = "X-SMALL"
  auto_suspend   = 5
  auto_resume    = true
}

# Analytics Warehouse (VELUX_ANALYTICS_WH)
# ----------------------------------------
# Configuration:
# - Size: MEDIUM (provides more compute power for analytics)
# - Auto-suspend: 10 seconds
# - Auto-resume: Enabled
# - Max Clusters: 10 (allows scaling out for concurrent analytical queries)
# - Min Clusters: 1
# - Scaling Policy: STANDARD (optimizes for concurrency and performance)
resource "snowflake_warehouse" "velux_analytics_wh" {
  name              = "VELUX_ANALYTICS_WH"
  warehouse_size    = "MEDIUM"
  auto_suspend      = 10
  auto_resume       = true
  max_cluster_count = 10
  min_cluster_count = 1
  scaling_policy    = "STANDARD"
}
