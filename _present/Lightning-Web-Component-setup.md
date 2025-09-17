---
layout: default
title: LWC Setup
nav_order: 13
parent: Present
collection: present
---

# Lightning Web Component Setup

The Present package exposes a Lightning Web Component (LWC) called `fast-slides`. This is the main component of the Present package.

{: .note }
> **Present package namespace**
> 
> The managed Present package has the namespace `andmoney` and
> should be used whenever you reference a component, sObject, class or custom metadata from the package.

## Present wrapper component
In order to use the `fast-slides` LWC component it needs the following inputs:
1. `customerType` - This is the customer type (ID) which is used to match with the master templates' customer type.
2. `recordId` - This is the ID or the event. If the `fast-slides` component is used in a RecordPage other than `Event` you need to implement your own functions to get the `EventId`.
3. `config` - This is the config object for the `fast-slides` component.

### The config object

Currently, the config object in Present contains the following properties:
1. `agenda` - Used to pass in predefined (or autocompleted) agenda text. An example of this is the use of Quick Texts in Salesforce standard text areas.

An example implementation of a LWC wrapping the `fast-slides` component is shown below.
```html
<template>
  <lightning-card>
    <h3 slot="title">
      <lightning-icon
              icon-name="custom:custom62"
              size="small"
              class="slds-m-right_small">
      </lightning-icon>
      Mødepræsentation
    </h3>
    <andmoney-fast-slides
            customer-type-input={customerType}
            record-id={recordId}
            config={config}>
    </andmoney-fast-slides>
  </lightning-card>
</template>
```
<details markdown="1">
<summary>Present LWC Wrapper</summary>

This implementation is very simple and can be modified to match your styling etc.

{: .note }
> **Present LWC wrapper**
> * `lightning-card`: The fast-slides component is wrapped in `lightning-card` with a `h3` title with an `lightning-icon`.
> * `andmoney-fast-slides`: The fast-slides component with `customerType` and `recordId` input.
> * Since we provide a Managed Salesforce package, all components and SObjects include an `andmoney` namespace. Either `andmoney-` instead of `c-` for LWC components or `andmoney__` for SObjects.

<img src="{{ site.baseurl }}/assets/images/present/present_wrapper.png" width="600" alt="Present wrapper component" />

</details>

In order to fetch the customer type passed to the `fast-slides` component we use the sample implementation found [here](../customergroup-mapping).

The Javascript for the PresentWrapper component can be found below. Here we use a wired function:

```javascript
@wire(getCustomerTypeFromEvent, { eventId: "$recordId" })
 async wiredGetCustomerTypeFromEvents(response) {
 ...
 }
```
which fetches the customer type from the event through the account associated with the event.

Full implementation here:
```javascript
import getCustomerTypeFromEvent
    from "@salesforce/apex/[YOUR_IMPLEMENTATION]";
import { LightningElement, api, wire } from "lwc";

export default class PresentWrapper extends LightningElement {
  @api recordId;
  
  // This will pass in the config.agenda to the Present agenda field
  config = {
    agenda: "this\n is\n the \n agenda"
  }

  customerType;
  _getCustomerTypeResponse;

  @wire(getCustomerTypeFromEvent, { eventId: "$recordId" })
  async wiredGetCustomerTypeFromEvents(response) {
    this._getCustomerTypeResponse = response;

    const { data, error } = response;

    if (data) {
      this.customerType = data.value;
    } else if (error) {
      this.customerType = "PRIVATE";
    }
  }
}
```
{collapsible="true"
collapsed-title="present-wrapper.js"
default-state="collapsed"}
