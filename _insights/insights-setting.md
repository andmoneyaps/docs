---
layout: default
title: Insights Settings
nav_order: 3
parent: Insights
collection: insights
---

# Insights Settings Configuration

## Overview

Insights Settings control how the availability simulation runs and what data is generated. These settings determine the scope, granularity, and focus of your availability analysis.

![Insights Settings](../../assets/images/insights/insights-setting.png)

## Configuration Steps

1. Access the Insights menu in the Management UI
2. Select "Create New"
3. Configure the following parameters:

### Basic Settings

| Parameter | Description | Example |
|-----------|-------------|---------|
| Name | Identifier for the setting | "Private" |
| Customer Type | The customer type used for simulation | "Basic Customer" |
| Time Zone | Timezone used for dates of generated data | "Europe/Copenhagen" |


### Meeting configuration

Insights data is calculation using a meeting configuration, typically defined by the customer type and a meeting theme.
A meeting configuration should be selected for an insights setting, or a custom one can be defined.

### Time Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| Time Range Interval | Minutes between data points | 60 |
| Calendar Time Buffer | Minutes before meeting allowed | 120 |
| Working Time Buffer | Required working hours buffer | 60 |
| Time Between Meetings | Required gap between meetings | 15 |

### Meeting Parameters

| Setting | Description |
|---------|-------------|
| Meeting Types | Online/Physical/Phone/Offsite |
| Meeting Duration | Length of meetings in minutes |


## Best Practices

1. **Time Intervals**
   - Match business needs
   - Consider reporting requirements
   - Balance detail vs. volume
   - Align with operating hours

2. **Meeting Configuration**
   - Define realistic durations
   - Include all relevant meeting types
   - Set appropriate buffers
