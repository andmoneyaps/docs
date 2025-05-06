---
layout: default
title: Technical flow
nav_order: 6
parent: Insights
collection: insights
---

# BookMe Insights Technical Documentation

## Process Overview

The insights generation process starts with the InsightsDataGeneratorWorker  which runs as a background job in the Calendar service. Here's how it works:

## Brief overview of Insights data generation 

There are two workers that run nightly. One worker handles forecast of advisoravailability and the other handles recently created meetings, enrices them with data and writes them to the HistoricMeetings table in the insights database.

The InsightsDataGenerator is also scheduled nightly and is run for each insights setting. Insight settings describes under which configuration the forecast should be run. Typically a customer type is selected, a time zone for the generated data, as well as a meeting configuration. The meeting configuration can be customized. It describes the different buffers between meetings, Pre and post processing times, meeting length, how many meetings per day are allowed etc.
Another factor in the advisors' availabilities are whether they have the necessary competences to be available for meetings. This is controlled either through competence setup in the CRM system (AdvisorSkills) or it can be configured through competence groups in the management ui.  
The availability is partitioned into TimeRangeWIthReason of 1 hour interval per meeting type per advisor, and describes for each period why the advisor is or isnt available for meetings.
This data is generated daily and written to the insights database.


Nightly, a worker schedules a hangfire job that is executed and generates forecast data and ingests historic meetings. 
This is done by the InsightsService and CRMInsightsService in the calendar service. After data generation the data is pushed to the CRM system through the CRMIntegration service.
Timerange with reason is generated using the standard availability engine in the calendar service, and then split into smaller chunks. 
The calculation and insertion to the database is done in batches through masstransit commands to be done in parallel and spread between calendar pods.
The current integration to Salesforce uses the External Data API, uploaded gzipped data using External Data Parts.
This allows the bank to access the generated data in the CRM Analytics platform.