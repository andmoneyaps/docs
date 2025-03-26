# Tag mapping
Tag mapping is useful for mapping data from salesforce objects to the tags that are used throughout the uploaded templates.
It is possible to map fields and nested fields from Account, Contact, and Event to the tags in templates.

## Tag mapping in Present
To start mapping between tags and SObject fields, go to the Present Lightning app and select the Tags section.
This will lead you to the following page:

![Tag Mapping Overview](tag_mapping_extended.png)

1. Select a tag from the first field. From this input, any tag used in one of the uploaded templates can be selected.
2. Select an SObject. This can be Account, Contact, and Event, or from the built-in custom SObject (Specific).
3. Select a field from the chosen SObject.
4. If the field is a reference type, you can select a nested field from the reference object.
5. Click the 'Create' button.

> In the example above, the tag "dine_jeres" is mapped to `Event → Account → andmoney__AMB_Taxonomy__c → Name`.
>
{style="info"}

If the tag mapping is successfully created, it will now be shown in the list of tag mappings below.
The list also shows which master templates the tags are used within.

A single tag can be used across multiple different templates.

> **How does tag mapping work**
>
> When a slide deck is created on a Salesforce Event, Present will look up the tags that are used in the selected slides, and find the relevant tag mappings.
>
> Each tag in the respective slides is then replaced with the value of the tag mapping's SObject field.
> The values are looked up directly on the Event from which the slide deck is created, and on the Account and Contacts that are related to the Event.
>
> Any tag that has not been mapped to an SObject field, can be populated by the user through input fields, before the creation of the slide deck.
>
{style="note"}

> **Tag mapping maps Salesforce fields 'as-is'**
>
> In Present v1.10 the tag-mapping maps the Salesforce SObject fields 'as-is', meaning the raw data.
> 
> **With some exceptions**:
> - Dates are transformed based on your locale and language in User Settings: An example `Event.enddate` will be in DK date format: `dd.MM.yyyy`
> - If a field is a lookup (an `Id`) for example `Account.OwnerId` the sObject is queried and the `.Name` property is used. In case of the `Account.OwnerId` this will return the Name of the Account Owner.
>
{style="warning"}
