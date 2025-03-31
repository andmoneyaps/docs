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

## Configuration Steps

1. Access the Insights menu in the Management UI
2. Select "New Insights Setting"
3. Configure the following parameters:

### Basic Settings

| Parameter | Description | Example |
|-----------|-------------|---------|
| Name | Identifier for the setting | "Branch A Availability" |
| Description | Purpose of this configuration | "Daily advisor availability analysis" |
| Time Zone | Analysis time zone | "Europe/Copenhagen" |
| Enabled | Setting activation status | Yes/No |

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
| Meeting Theme | Theme/topic for analysis |
| Customer Category | Target customer segment |
| Meeting Types | Online/Physical/Phone/Offsite |
| Meeting Duration | Length of meetings in minutes |

## Advanced Configuration

### Location Settings
- Select specific branches
- Configure room requirements
- Set travel time parameters
- Define working hours

### Calendar Integration
- Enable/disable calendar sync
- Set calendar buffer excludes
- Configure weekend handling
- Define processing times

### Data Generation
- Set simulation frequency
- Configure forecast window
- Define data granularity
- Set update parameters

## Best Practices

1. **Time Intervals**
   - Match business needs
   - Consider reporting requirements
   - Balance detail vs. volume
   - Align with operating hours

2. **Meeting Configuration**
   - Define realistic durations
   - Include all relevant types
   - Consider travel requirements
   - Set appropriate buffers

3. **Performance Optimization**
   - Limit unnecessary data
   - Focus on key metrics
   - Configure efficient intervals
   - Monitor data volume

## Troubleshooting

### Common Issues

1. **No Data Generated**
   - Verify setting is enabled
   - Check time zone configuration
   - Confirm advisor assignments
   - Review location settings

2. **Incomplete Data**
   - Check interval settings
   - Verify meeting configurations
   - Review buffer settings
   - Confirm calendar integration

3. **Integration Problems**
   - Verify CRM connections
   - Check data permissions
   - Confirm API access
   - Review sync settings

## Validation

After configuration:
1. Monitor initial data generation
2. Review availability patterns
3. Verify constraint reasons
4. Check data completeness
5. Validate integration points

## Support

For configuration assistance:
- Contact technical support
- Review documentation
- Check knowledge base
- Submit support tickets
