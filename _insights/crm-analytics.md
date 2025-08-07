---
layout: default
title: CRM Analytics Integration
nav_order: 5
parent: Insights
collection: insights
---

# CRM Analytics Integration

## Overview

BookMe Insights integrates seamlessly with Salesforce CRM Analytics through an automated data pipeline. This integration enables real-time analytics, custom reporting, and comprehensive business intelligence capabilities.
The CRM analytics integration is done using the External Data API from salesforce to push data to the organization.

## Integration Architecture

### Data Flow
1. **Data Generation**
   - Nightly availability simulations
   - Historic meeting data processing
   - Time range with reason calculations
   - Location-specific analytics

2. **Data Processing**
   - Automatic data chunking (≤10 MB parts)
   - GZIP compression for efficient transfer
   - Metadata enrichment
   - Integrity validation

3. **CRM Analytics Upload**
   - External Data API integration
   - Metadata object creation
   - Batched data upload
   - Dataset management

## Data Types

### Time Range Data
- Hourly availability snapshots
- Advisor availability status
- Meeting type capabilities

### Historic Meeting Data
Historic Meeting Data provides comprehensive analytics on completed meetings, enabling detailed analysis of booking patterns, resource utilization, and service delivery performance. This data includes:

- **Meeting Records**: Complete details of all past meetings including timing, duration, and participants
- **Booking Analytics**: Analysis of booking patterns, lead times, and booking sources
- **Resource Utilization**: Advisor workload distribution and room usage patterns
- **Service Metrics**: Performance analysis by service type, customer category, and meeting format
- **Duration Analysis**: Comparison of actual vs. configured meeting durations for efficiency insights

For detailed field descriptions and data structure information, see [Technical Details - Historic Meeting Fields](../insights-details#historic-meeting-fields).

#### Data Processing and Upload

**Data Collection Process**
- Historic meeting data is automatically ingested from your BookMe system on a nightly basis
- The system processes all completed meetings and updates existing records when modifications occur
- Data is collected for organizations with the Insights feature enabled

**Upload Process**
- Data is processed in configurable batches (default: 100,000 records per batch)
- Each batch is compressed using GZIP for efficient transfer
- Data is uploaded to Salesforce CRM Analytics using the External Data API
- Upload process includes automatic retry mechanisms for reliability

**Data Scope and Retention**
- Includes all completed meetings from your BookMe system
- Historical data is preserved and continuously updated
- New meetings are added during each nightly processing cycle
- Modified meetings are updated to reflect the latest information

#### Data Characteristics
- **Update Frequency**: Historic meeting data is processed and uploaded nightly at 23:30 UTC
- **Time Zone**: All timestamps are provided in UTC format for consistent global analysis
- **Data Quality**: Automatically enriched with theme hierarchies, customer categories, and room information
- **Batch Processing**: Data is uploaded in manageable chunks with automatic compression
- **Feature Dependency**: Only available for organizations with the Insights feature enabled

## Implementation Details

### Data Generation Process
1. **Nightly Simulation**
   - Runs configured Insights Settings
   - Processes each location
   - Calculates advisor availability
   - Generates 60-day forecasts

2. **Data Preparation**
   - Chunks data into manageable parts
   - Compresses using GZIP
   - Validates data integrity
   - Prepares upload metadata

3. **Upload Process**
   - Creates External Data object
   - Defines dataset properties
   - Uploads compressed parts
   - Links parts to metadata