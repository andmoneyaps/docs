# iCal Generation for Meetings

This guide explains how to generate calendar files (iCal) for your BookMe meetings.

## Overview

You can create iCal files for meetings to allow easy calendar integration. 

## How to Generate an iCal File

To generate an iCal file for a meeting:

1. You'll need the meeting ID
2. Provide a title, description, and location for the meeting
3. Send a request to create the iCal file

The system will return a calendar file that can be opened in most calendar applications like Outlook, Google Calendar, or Apple Calendar.

### What You Need

- Meeting ID: This is the unique identifier for your meeting
- Meeting details:
  - Title: The name/subject of the meeting
  - Description: What the meeting is about
  - Location: Where the meeting will take place (can be physical location or virtual meeting link)

### Common Error Messages

You might see these messages:

- "Access is unauthorized" - Make sure you're properly logged in
- "Access is forbidden" - Check if you have permission to access this meeting
- "Resource not found" - Verify that the meeting ID is correct
- "Server error" - Try again later or contact support if the problem continues

### Technical Details

For developers and technical users:

**Endpoint:** POST `/bookme/meetings/{id}/ical`

**Path Parameters:**
- `id` (required): The ID of the meeting

**Request Body:**
```json
{
    "title": "Meeting Title",
    "description": "Meeting Description",
    "location": "Meeting Location"
}
```

**Successful Response:**
- You'll receive an iCal file (.ics) that can be opened in calendar applications