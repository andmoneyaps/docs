---
layout: default
title: Customer Onboarding
nav_order: 14
parent: Present
collection: present
---

# Onboarding of new customer

This article describes how we handle a new customer for Present. It describes which credentials needs to be exchanged
and how to verify that a customer is set up correctly and ready to use Present.

{: .note }
> Typically, when onboarding a new customer their Salesforce org will be a Sandbox

<procedure title="Onboarding of a new customer involves three main tasks" id="secrets">
  <p>A lot of secrets and configs needs to be exchanged between the new customer and the &money team.
The most important steps are the following:</p>
  <step>Generate Private Key and a Self-Signed Certificate</step>
  <step>Retrieve the ConnectedApp ClientId and ClientSecret from the customer</step>
  <step>Retrieve Salesforce admin username (integration user) from customer</step>
  <step>Handover App Registration ClientId and ClientSecret and Certificate to customer</step>
  <p>These are the steps needed to successfully onboard a new customer of Present.</p>
</procedure>

## Generate Self-Signed Certificate
In order for the Salesforce org to communicate with the Present Backend we need to generate a Private Key and a Self-Signed certificate.

We want to produce two files:
* server.key - The private key. We use this to verify that the communication actually is coming from a customer.
* server.crt - The digital certificate. The customer uploads this file when they create the required connected-app.

To generate a Private Key run the following two commands:
```shell
openssl genpkey -des3 -algorithm RSA -pass pass:SomePassword -out server.pass.key -pkeyopt rsa_keygen_bits:2048
```

{: .hint }
> Replace 'SomePassword' with a strong password. A good password generator can be found [here](https://www.lastpass.com/features/password-generator).

```shell
openssl rsa -passin pass:SomePassword -in server.pass.key -out server.key
```

You should now have the Private Key 'server.key'.

Now create a signing request with the following command:

```shell
openssl req -new -key server.key -out server.csr
```

Now you can create the Self-Signed certificate:

```shell
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
```

Find more information [here][sfssc].

## Retrieve the secrets and admin username from customer
For the customer to communicate with the Present Backend through API management, we need a number of secrets and parameters from the customer:

1. We need the Connected Apps Username, Consumer Key and Secret from the customer's org.

This information should be placed in the `Infrastructure-Kubernetes` repository as a new `yaml` file:
* `/apps/dev/secrets/present-credentials-<bankname>-secret.yaml` for dev
* `/apps/test/secrets/present-credentials-<bankname>-secret.yaml` for test
* `/apps/prod/secrets/present-credentials-<bankname>-secret.yaml` for prod

Where `<bankname>` is the shorthand name of the new customer.

```yaml
apiVersion: v1
data:
    tenantId: <TenantIdFromB2CAppRegistration>
    oauthEndpoint: <SalesforceTokenEndpoint> (https://test.salesforce.com/services/oauth2/token for sandbox orgs and https://login.salesforce.com/services/oauth2/token scratch orgs
    clientId: <ConnectedAppConsumerKey>
    clientSecret: <ConnectedAppConsumerSecret>
    adminUsername: <UsernameOfConnectedAppUser>
    certPass: <CertificatePassword>
    orgLoginUrl: <OrgLoginUrl> (https://test.salesforce.com/ for sandbox orgs and https://login.salesforce.com/ scratch orgs)
    privateKey: <PrivateKey> (without start/end)
    packageNamespace: null
kind: Secret
metadata:
    name: present-credentials-<bankname>-secret
    namespace: booking
```

This enables the backend to communicate with the customers' Salesforce org.

## Handover App Registration secrets and Certificates to the customer

The customer needs the generated certificates, the clientId and clientSecret from the App Registration in the B2C org.
These secrets can be found in the License management app in our Partner Business org

1. Go to Licenses
2. Select the relevant License
3. Click 'Related' to see related objects to the License
4. Now click on the first LicenseDetails object
5. Here you will find the License details such as **ClientId** and **ClientSecret**

Send the **ClientId**, **ClientSecret** and the generated **Certificate** in an email to the customer.

[sfssc]: https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_auth_key_and_cert.htm
