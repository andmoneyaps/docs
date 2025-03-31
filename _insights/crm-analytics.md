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
- Past meeting records
- Booking patterns
- Resource utilization
- Service delivery metrics

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