---
layout: default
title: Architecture
nav_order: 10
parent: Present
collection: present
---

# Present Architecture

## Overall architecture

```mermaid
flowchart LR
    subgraph Azure [" "]
        direction LR
        AAD[("Azure\nActive Directory")]
        BLOB[("Blob Storage")]
        APIM["API\nManagement"]
    end

    subgraph K8S ["Kubernetes Cluster"]
        direction LR
        subgraph BE ["Present Backend"]
            Pod1[("Pod")]
            Pod2[("Pod")]
            Pod3[("Pod")]
        end
        
        subgraph FE ["Front End"]
            ING["Ingress"]
        end
    end

    Present["Present"]

    APIM --"HTTP/ASYNC"--> AAD
    Present --"HTTP/ASYNC"--> APIM
    APIM --"HTTP/ASYNC"--> ING
    ING --"HTTP/ASYNC"--> Pod3
    Pod3 --> BLOB

    classDef azure fill:#0072C6,stroke:#fff,stroke-width:2px,color:#fff
    classDef k8s fill:#326CE5,stroke:#fff,stroke-width:2px,color:#fff
    
    class AAD,BLOB,APIM azure
    class Pod1,Pod2,Pod3,ING k8s
```

## Present Salesforce Objects

![Present Salesforce Objects](/assets/images/present/Present-architecture.png)

## Present Sequence Diagrams

### Upload Template Flow

```mermaid
sequenceDiagram
    autonumber
    actor A as Present Admin
    participant S as Salesforce
    participant APIM as APIM
    participant P as Present Backend
    participant B as Blob Storage

    A ->> S: Upload template (LWC)
    S ->> S: Upload template to SF user library
    S ->> APIM: Get token via named credentials
    APIM ->> S: Token response
    S ->> P: Upload(ContentVersionId and OwnerId)
    P ->> S: Get ContentVersion content
    S ->> P: ContentVersion content
    P ->> B: Create new blob
    B ->> P: Blob created
    P ->> S: Template uploaded response
    S ->> A: List templates (LWC)
```

### Generate Presentation Flow

```mermaid
sequenceDiagram
    autonumber
    actor A as Advisor
    participant S as Salesforce
    participant APIM as APIM
    participant P as Present Backend
    participant B as Blob Storage

    A ->> S: Generate presentation (LWC)
    S ->> APIM: Get token via named credentials
    APIM ->> S: Token response
    S ->> P: PPTX Generation request (Tag Mappings, Slides)
    P ->> B: Get templates
    B ->> P: Template content
    P ->> P: Generate presentation from template and tags
    P ->> S: Upload presentation to Salesforce
    S ->> A: Generation complete!
