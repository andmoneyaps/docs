---
layout: default
title: Customer Type Mapping
nav_order: 8
parent: Present
---

# Customer Type Mapping

Present supports different types of customer classifications and allows for custom mapping of customer types. The Present Lightning Web Component (LWC) operates on an Event record page, using the Event record ID to query the related Account information.

## Integration with BookMe

This functionality is particularly useful when the BookMe Scheduler package is installed in your org, as it introduces:
- A customer-type concept
- A customer category field for each account

> **Note**: Present utilizes the customer types defined in the BookMe Scheduler package for master template uploads.
> The customer type mapping should lookup the user's customer category and pass that to the Present LWC.

## Implementation Example

Here's an example implementation for custom customer types:

```java
public with sharing class PresentCustomerTypeController {
  @AuraEnabled(Cacheable=true)
  public static PresentCustomerTypeDto getCustomerTypeFromEvent(
    String eventId
  ) {
    // Get CustomerTypes
    List<PresentCustomerTypeDto> customerTypes = getCustomerTypes();

    List<Event> events = [
      SELECT AccountId
      FROM Event
      WHERE Id = :eventId
      WITH SECURITY_ENFORCED
    ];

    if (events.size() == 0) {
      return new PresentCustomerTypeDto('Privat3', 'PRIVATE', 'PRIVATE');
    }
    Id accountId = events[0].AccountId;

    string ns = '';
    if (
      !Account.getSobjectType()
        .getDescribe()
        .fields
        .getMap()
        .containsKey(ns + 'AMB_Customer_Category__c')
    ) {
      return new PresentCustomerTypeDto('Private', 'PRIVATE', 'PRIVATE');
    }

    // Get Account's Customer Category
    List<Account> accounts = Database.query(
      'SELECT ' +
        ns +
        'AMB_Customer_Category__c FROM Account WHERE Id = :accountId'
    );

    if (accounts.size() == 0) {
      return new PresentCustomerTypeDto('Private', 'PRIVATE', 'PRIVATE');
    } else {
      String taxonomyId = (String) accounts[0]
        .get(ns + 'AMB_Customer_Category__c');
      // Query Taxonomy__c
      List<SObject> taxonomies = Database.query(
        'SELECT Name, Id, ' +
          ns +
          'BookingId__c FROM ' +
          ns +
          'AMB_Taxonomy__c WHERE id = :taxonomyId'
      );

      if (taxonomies.size() == 0) {
        return new PresentCustomerTypeDto('Private', 'PRIVATE', 'PRIVATE');
      } else {
        return new PresentCustomerTypeDto(
          (String) taxonomies[0].get('Name'),
          (String) taxonomies[0].get('Id'),
          (String) taxonomies[0].get(ns + 'BookingId__c')
        );
      }
    }
  }

  private static List<PresentCustomerTypeDto> getCustomerTypes() {
    String query = '';
    String ns = '';
    List<PresentCustomerTypeDto> customerTypes = new List<PresentCustomerTypeDto>();

    String objectName = ns + 'AMB_Taxonomy__c';
    Schema.SObjectType queriedObjectType = Schema.getGlobalDescribe()
      .get(objectName);

    if (
      queriedObjectType != null &&
      !queriedObjectType.getDescribe().isAccessible()
    ) {
      System.debug('No access to queried object ' + objectName);
    }

    query =
      'SELECT Id, Name, ' +
      ns +
      'BookingId__c FROM ' +
      String.escapeSingleQuotes(ns + 'AMB_Taxonomy__c');
    try {
      List<SObject> result = Database.query(query);
      for (SObject s : result) {
        PresentCustomerTypeDto dto = new PresentCustomerTypeDto(
          (String) s.get('Name'),
          (String) s.get('Id'),
          (String) s.get(ns + 'BookingId__c')
        );
        customerTypes.Add(dto);
      }
    } catch (QueryException e) {
      system.debug(e);
    }

    if (customerTypes.size() == 0) {
      customerTypes.Add(
        new PresentCustomerTypeDto('Private', 'PRIVATE', 'PRIVATE')
      );
      customerTypes.Add(
        new PresentCustomerTypeDto('Erhverv', 'BUSINESS', 'BUSINESS')
      );
      customerTypes.Add(
        new PresentCustomerTypeDto(
          'Private Banking',
          'PRIVATEBANKING',
          'PRIVATEBANKING'
        )
      );
      customerTypes.Add(
        new PresentCustomerTypeDto(
          'Private Banking+',
          'PRIVATEBANKINGPLUS',
          'PRIVATEBANKINGPLUS'
        )
      );
    }

    return customerTypes;
  }
}
```

## Implementation Details

The `getCustomerTypeFromEvent` method:
1. Takes an `eventId` parameter
2. Looks up the related account
3. Checks for the BookMe Scheduler customer category field
4. Returns the customer's type based on the field value
5. Defaults to `PRIVATE` customer type if the field doesn't exist

## Integration Steps

To integrate the custom implementation for customer type mapping:

1. Make the method `AuraEnabled`
2. Call it in your custom wrapper for the Present LWC
3. Handle the returned customer type appropriately in your component

## Default Customer Types

If no custom types are configured, the system provides these defaults:
- Private
- Erhverv (Business)
- Private Banking
- Private Banking+
