---
layout: default
title: Technical Details
nav_order: 4
parent: Insights
collection: insights
---

# BookMe Insights Technical Details

## Data Generation Process

The Insights engine uses the following process to generate availability data:

1. **Initialization**
   - Loads Insights Settings configuration
   - Retrieves advisor and location data
   - Prepares simulation parameters
   - Validates input configuration

2. **Simulation**
   - Runs availability engine simulation
   - Processes 60-day forecast window
   - Generates hourly time ranges for each advisor and meeting type
   - Applies business rules and constraints

3. **Data Processing**
   - Enriches time ranges with reasons
   - Calculates availability metrics
   - Applies location/configuration constraints
   - Applies advisor competence constraints (customer type and meeting theme)

## Data Structure

### Time Range Fields

Date and time related fields are stored using the selected timezone for the insights settings

| Field | Description | Format |
|-------|-------------|---------|
| Start | DateTime component | DateTime|
| StartDate | Date component | Date |
| StartTime | Time component | Time |
| Reason | Availability reason | Enum |
| MeetingType | Meeting format | Enum |
| AdvisorEmail | Advisor identifier | String |
| LocationConfigurationName | Location name | String |
| SettingId | Configuration ID | GUID |
| DayOfWeek | Day of week | Enum |
| HourOfDay | Hour (0-23) | Integer |
| DurationInMinutes | Time range length | Integer |
| NumberOfAvailableMeetings | Available meetings within the time range | Integer |

### Time Range Reasons

#### Availability Status
- **Available**: Advisor is qualified and free for meetings
- **ServiceGroupAvailable**: Available through service group membership

#### Calendar-Related
- **ReservedOrBooked**: Existing BookMe meeting
- **BusyAppointmentInstance**: Single private appointment
- **BusyAppointmentOccurence**: Recurring private appointment
- **BusyEventInstance**: Single shared event
- **BusyEventOccurence**: Recurring shared event

#### Schedule Constraints
- **BankClosingDay**: Official bank holiday/closure
- **Busy**: Default calendar busy status
- **WorkingFromElsewhere**: Remote work status
- **MaxMeetingsPerDay**: Daily meeting limit reached
- **OutsideWorkday**: Outside configured working hours
- **DayOfWeekUnavailable**: Blocked weekday in advisor's schedule
- **MeetingTypeUnavailable**: Meeting type not available for advisor

#### Meeting Processing
- **PreProcessing**: Pre-meeting preparation time
- **PostProcessing**: Post-meeting followup time
- **TravelTime**: Physical meeting travel buffer
- **TimeBetweenMeetings**: Required meeting gap

#### Buffer and Qualification
- **WorkingTimeBuffer**: Working hours buffer
- **CalendarTimeBuffer**: Calendar-based buffer
- **Unqualified**: Missing required qualifications (Customer type and/or meeting theme)
- **Unbookable**: Booking disabled for advisor

#### Other
- **None/Unknown**: Default/unspecified reason

## Technical Implementation

### Data Generation Rules

1. **Time Range Creation**
   - Generated in hourly intervals (configurable)
   - Always starts at interval boundaries
   - Maximum duration of 60 minutes

2. **Availability Calculation**
   - Processes advisor schedules
   - Validates qualifications
   - Applies meeting constraints

3. **Constraint Processing**
   - Evaluates calendar conflicts
   - Applies buffer rules
   - Processes travel requirements
   - Checks service group rules