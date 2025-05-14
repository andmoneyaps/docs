---
layout: default
title: Customer Type Mapping
nav_order: 11
parent: Present
collection: present
---

# Customer Type Mapping

Present can work with different types of customer types, and it is possible to create a custom mapping for customer types.
The Present LWC lives on an Event record page, and the Event record ID can then be used to query the related Account.

This is mostly useful if the &bookme Scheduler package is also installed in the org,
as this package introduces a customer-type concept and adds a customer category field to each account.

> Present will make use of the customer types defined in the &bookme Scheduler package for master template uploads,
so the customer type mapping should look up the user's customer category and pass that to the present LWC.

Below is an example of how an implementation could look for custom customer types.
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
      List<SObject> result = Database.query(query); // OK to loop since it loops over a constant list
      for (SObject s : result) {
        PresentCustomerTypeDto dto = new PresentCustomerTypeDto(
          (String) s.get('Name'),
          (String) s.get('Id'),
          (String) s.get(ns + 'BookingId__c')
        );
        customerTypes.Add(dto);
      }
    } catch (QueryException e) {
      // If the sobject doesn't exist, we try the next one
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
This implementation of `getCustomerTypeFromEvent` takes an `eventId` and looks up the related account.
If this account has the &bookme Scheduler customer category field, the value of that field is returned as the customer's type.

If the field doesn't exist, the default `PRIVATE` customer type is returned.

> **How to integrate the customer type mapping**
>
> To integrate the custom implementation for customer type mapping,
> Simply make the method `AuraEnabled` and call it in the custom wrapper for the Present LWC.
