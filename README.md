# VELUX Take-Home Case

## Overview

This project aims to build a data product for Velux Take-Home Case, enabling the analysis of IoT home device readings in conjunction with the weather data. 

## Project Structure

The project is organized into the following main directories:

* **`.` (Root Directory)**
* **`.github/workflows/`**: Contains GitHub Actions workflows for CI/CD pipeline.

* **`dbt/`**: Houses the dbt (Data Build Tool) project.data.

* **`infra/`**:
  * Contains Terraform scripts for provisioning and managing the Snowflake infrastructure.
    * This includes definitions for:
      * Databases and Schemas
      * User Roles and Grants
      * Virtual Warehouses
      * Resource Monitors
      * Other Snowflake objects.

* **`presentation/`**: Contains the presentation PDF file.

## Data Sources

*   **Accuweather**: Weather data directly from the Snowflake Marketplace.
*   **IOT Data**: Readings from various IOT home devices. This data is initially provided as CSV files and preprocessed.

## Data Ingestion

1.  **Accuweather Data**: Imported from the Snowflake Marketplace via Imported Priveleges.
2.  **IOT Data**: Loaded directly into the RAW stage of the Velux Snowflake databases (Dev and Prod).

## Data Modelling

The `dbt/` directory contains the dbt project responsible for transforming the raw data from Accuweather and IOT devices into a structured, reliable, and analytics-ready format. This involves:
*   Cleaning and transforming raw data.
*   Creating staging, intermediate, and mart models.
*   Implementing business logic.
*   Data quality tests.

Detailed data lineage and documentation for the dbt models can be found here 🔗 [DBT Docs](https://spacekittie.github.io/velux_demo/)