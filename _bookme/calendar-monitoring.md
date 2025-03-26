---
layout: default
title: Monitoring Guide
nav_order: 3
parent: Calendar Management
grand_parent: BookMe
---

# Calendar Service Monitoring

## Health Metrics

### Endpoints
- **GET** `/api/v1/health/connectors`: Connector health metrics
```json
{
    "activeConnectors": "5",
    "connectorsCreated": "10",
    "connectorsDisposed": "5",
    "status": "Healthy"
}
```

## Metrics

### Connector Metrics
- `m365.connector.creation.count`: Number of connectors created
- `m365.connector.dispose.count`: Number of connectors disposed
- `m365.connector.active.count`: Current number of active connectors
- `threadpool.threads`: Current thread pool thread count

## Alert Configuration

### Azure Monitor Alert Rules

1. **High Active Connector Count**
```json
{
    "name": "HighActiveConnectorCount",
    "metric": "m365.connector.active.count",
    "threshold": 100,
    "timeWindow": "5m",
    "frequency": "1m",
    "severity": 2,
    "description": "Too many active connectors may indicate resource leaks"
}
```

2. **Connector Disposal Rate**
```json
{
    "name": "LowConnectorDisposalRate",
    "query": "m365.connector.creation.count - m365.connector.dispose.count > 50",
    "timeWindow": "1h",
    "frequency": "5m",
    "severity": 2,
    "description": "Large difference between created and disposed connectors indicates potential leaks"
}
```

3. **Thread Pool Exhaustion**
```json
{
    "name": "ThreadPoolExhaustion",
    "metric": "threadpool.threads",
    "threshold": 200,
    "timeWindow": "5m",
    "frequency": "1m",
    "severity": 1,
    "description": "High thread count indicates potential thread pool exhaustion"
}
```

4. **Memory Growth Rate**
```json
{
    "name": "HighMemoryGrowthRate",
    "query": "avg(process.memory.workingset) by (instance) > 2GB",
    "timeWindow": "6h",
    "frequency": "5m",
    "severity": 2,
    "description": "Memory usage growing too quickly"
}
```

### Grafana Dashboard Configuration

```json
{
    "title": "Calendar Service Health",
    "panels": [
        {
            "title": "Active Connectors",
            "type": "gauge",
            "query": "m365.connector.active.count",
            "thresholds": [
                { "value": 50, "color": "green" },
                { "value": 75, "color": "yellow" },
                { "value": 100, "color": "red" }
            ]
        },
        {
            "title": "Connector Lifecycle",
            "type": "graph",
            "queries": [
                "m365.connector.creation.count",
                "m365.connector.dispose.count"
            ]
        },
        {
            "title": "Thread Pool Usage",
            "type": "graph",
            "query": "threadpool.threads",
            "alert": {
                "condition": "> 200",
                "frequency": "1m"
            }
        }
    ]
}
```

## Response Plan

### High Active Connector Count
1. Check the health endpoint for connector metrics
2. Review logs for any stuck sync operations
3. Check for errors in sync operations
4. Consider restarting the service if count continues to grow

### Thread Pool Exhaustion
1. Review active operations in Application Insights
2. Check for long-running sync operations
3. Verify connection timeouts are properly configured
4. Consider scaling out the service

### Memory Growth
1. Take memory dump for analysis
2. Review active connector count
3. Check for stuck sync operations
4. Verify resource cleanup in error scenarios

## Regular Monitoring Tasks

### Daily
- Review active connector count trend
- Check thread pool utilization
- Verify memory usage patterns
- Review error rates

### Weekly
- Analyze connector lifecycle patterns
- Review long-running operations
- Check resource utilization trends
- Verify alert thresholds

### Monthly
- Review alert history
- Analyze performance trends
- Update thresholds if needed
- Review scaling requirements

## Common Issues

### High Connector Count
**Symptoms**:
- Active connector count growing
- Memory usage increasing
- Thread pool pressure

**Resolution**:
1. Check for stuck sync operations
2. Verify error handling is working
3. Review connector disposal patterns
4. Consider service restart if needed

### Thread Pool Exhaustion
**Symptoms**:
- High thread count
- Slow response times
- Operation timeouts

**Resolution**:
1. Review active operations
2. Check for connection leaks
3. Verify timeout configurations
4. Consider increasing thread pool limits

## Logging

### Critical Events to Monitor
- Connector creation/disposal
- Sync operation failures
- Thread pool exhaustion
- Memory pressure alerts

### Log Queries

#### Find Stuck Sync Operations
```kusto
traces
| where operation_Name == "PerformAdvisorSync"
| where duration > timespan(5m)
| project timestamp, advisorId, bankId, duration
```

#### Monitor Connector Lifecycle
```kusto
traces
| where customDimensions.EventType in ("ConnectorCreated", "ConnectorDisposed")
| summarize count() by bin(timestamp, 1h), EventType
