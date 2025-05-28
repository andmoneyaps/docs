---
layout: default
title: Slide Recommendations
nav_order: 18
parent: Present
collection: present
---

# Setup Slide Recommendations

Slide recommendations are useful for highlighting specific sections of slides in a template,
that you want to encourage the user to include when creating their slide deck.

Visually, recommendations will be presented to the user as shown in the image below.
When the user selects the specific slides that they want to be included in their slide deck,
they look through the available sections of slides.
The recommended slide sections will have a **star** attached,
and optionally, a text when hovering on the **star** which describes the recommendation of that section.

![Slide recommendation]({{ site.baseurl }}/assets/images/present/present_slide_recommendation.png)

{: .note }
> **Slide Recommendation in your org**
> 
> Slide Recommendation can be used to recommend slides based on
> **Next-Best actions**, **Salgspotentialer**, **Fokusgrupper**,
> etc. Based on what is relevant for your organization. 

### How to create slide recommendations

Slide recommendations are created through apex code, using dependency injection with the `Callable` interface.

The example below shows how a possible implementation of the `Callable` interface for Present Slide Recommendation can be created.

```java
global without sharing class PresentNextBestAction implements Callable {
  Map<Id, String> getRecommendations(Id recordId, List<String> sections) {
    Map<Id, String> recommendations = new Map<Id, String>();

    // Recommend 1 random section a master template
    Integer randomIndex = Integer.valueof((Math.random() * sections.size()));

    recommendations.put(
      sections[randomIndex],
      'Demo: This section is chosen at random' + recordId
    );

    return recommendations;
  }

  public Object call(String action, Map<String, Object> args) {
    switch on action {
      when 'getRecommendations' {
        Map<Id, String> result = this.getRecommendations(
          (Id) args.get('recordId'),
          (List<String>) args.get('sections')
        );
        return result;
      }
      when else {
        throw new NextBestActionMalformedCallException(
          'Called method is not implemented'
        );
      }
    }
  }

  public class NextBestActionMalformedCallException extends Exception {
  }
}
```

{: .warning }
> **RecordId**
>
> The `recordId` given as input depends on which record page your Present Component is displayed. Typically, it is used on the Event record page.
> Then the `recordId` is the `Id` of the Event.

The action `getRecommendations` must be implemented, and included as a case in the `call` implementation.
`getRecommendations` returns a `Map<Id, String>` where the `Id`'s are Id's of `andmoney__Template_Section__c` records that should be recommended,
and the `String` is the tooltip for the recommendation.

Notice in the code example above that `(List<String>) args.get('sections')` is given as input to the method.
This list contains `Id`'s of all `andmoney__Template_Section__c` records in the org.
It is then advised to use these section `Id`'s and the `recordId` to query the specific sections that should be recommended to the user.

The `Map` returned in the implementation will then be used by the Present solution to add the recommendations.

{: .note }
> **How to dependency inject your implementation**
>
> To use your custom implementation for recommendations, create a record of the metadata type **Present Recommendation DI Implementation**
>
> ![Present Recommendation Metadata DI]({{ site.baseurl }}/assets/images/present/present_recommendation_metadata.png)
>
> The `DeveloperName` should be `PresentNextBestAction` and the `Apex Class Name` should be the name of your class.
