---
layout: default
title: Approving Engage in Your Microsoft Entra
nav_order: 2
parent: Identity
grand_parent: Foundation
---

# Approving Engage in Your Microsoft Entra

This guide shows you how to approve **Engage** so your colleagues can sign in to it.

It is a **one-time setup** and takes about five minutes.

---

## What is this about?

Engage is the &money web solution your colleagues use in their daily work.

Before they can sign in, an administrator at your organisation has to **approve** Engage. This approval simply tells Microsoft: *"Yes, our staff are allowed to use this application, and it may sign them in with their normal work login."*

{: .note }
> You are **not** installing or building anything. You are only giving your approval. &money has already created and manages the application — approving it just makes it available inside your organisation.

---

## Before you start

You will need:

- A person who is a **Microsoft Entra administrator** at your organisation. This is usually someone in your IT department.
  - The exact role required is *Cloud Application Administrator* or *Application Administrator*. If you are unsure, your IT department will know.
- Your organisation's **Tenant ID** (also called *Directory ID*). This is an identifier for your organisation in Microsoft. Your IT department can find it, or &money can help you locate it.

{: .important }
> A regular user account is **not** enough. The approval can only be given by an administrator.

---

## What you are approving

When you approve Engage, you are allowing it to:

- **Sign your colleagues in** using their normal Microsoft work account — so they don't need a separate username or password.
- **Work with the &money platform on their behalf** while they are signed in, so they can do their tasks in Engage.

{: .note }
> No passwords, secrets or sensitive data are shared with &money during this step. You are only giving permission for staff to sign in.

---

## How to approve Engage

### Step 1 — Prepare your link

Take the link below and replace **`YOUR_TENANT_ID`** with your organisation's Tenant ID:

```
https://login.microsoftonline.com/YOUR_TENANT_ID/adminconsent?client_id=cbac67da-6529-4411-821c-746888abee84
```

### Step 2 — Open the link

Open the prepared link in your web browser. When asked, sign in with your **administrator** account.

### Step 3 — Review and accept

Microsoft will show you a short summary of what Engage is allowed to do. Read it, then click **Accept**.

That's it — Engage is now approved.

{: .warning }
> **You may see an error message — this is normal**
>
> After you click **Accept**, your browser might show a message like *"Sorry, but we're having trouble signing you in."*
>
> You can safely ignore this. The approval has still been completed successfully. The message appears only because the approval link is not a normal sign-in page.

---

## How do I know it worked?

Once you have approved Engage:

- Your colleagues will be able to sign in to Engage with their normal Microsoft work account. &money will give you the web address they should use.
- In the Microsoft Entra admin center, a new entry named **Engage** will appear under **Enterprise applications**. This confirms the approval is in place.

---

## Need help?

If anything is unclear or doesn't work as expected, contact your &money representative. We're happy to walk through these steps with you or your IT department.
