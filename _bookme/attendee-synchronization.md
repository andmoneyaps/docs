# Attendee Synchronization

## Overview

The attendee synchronization feature ensures that attendee data remains consistent between different systems in the BookMe platform, specifically:

- Booking Backend
- Salesforce environment
- Microsoft 365 Calendar

## How It Works

When an attendee is updated in an employee's Outlook calendar, the system automatically triggers a synchronization process to ensure the changes are reflected across all integrated systems. This process is managed by dedicated event handlers that listen for calendar updates and propagate the changes accordingly.

### Key Components

- **Calendar Integration**: Monitors changes in Microsoft 365 calendars
- **Event Handling**: Processes attendee updates through the `AttendeesUpdatedEvent`
- **CRM Synchronization**: Updates corresponding attendee information in Salesforce

### Benefits

1. **Data Consistency**: Ensures attendee information is uniform across all systems
2. **Automated Updates**: No manual intervention required when attendee details change
3. **Real-time Synchronization**: Changes are propagated quickly to maintain accuracy

## Technical Implementation

The synchronization process is implemented through an event-driven architecture:

1. An attendee update is detected in the Outlook calendar
2. The system triggers an `AttendeesUpdatedEvent`
3. The `AttendeesUpdatedEventHandler` processes the event
4. Updates are propagated to connected systems (Salesforce)

This automated process ensures that all systems maintain consistent attendee information without requiring manual updates or reconciliation.
