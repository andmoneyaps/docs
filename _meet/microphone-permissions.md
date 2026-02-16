---
layout: default
title: Microphone Permissions
parent: Meet
nav_order: 2
---

# Microphone Permissions

Meet needs access to your microphone to transcribe the meeting. The first time you open Meet, your browser will ask for permission.

**Supported browsers:** Chrome and Edge (recommended). Safari has limited support.

## Allow Microphone (First Time)

1. Open Meet.
2. When the browser asks to use your microphone, click **Allow**.
3. Go back to Meet and confirm you can select a microphone device.

![Chrome/Edge microphone permission prompt]({{ site.baseurl }}/assets/images/meet/microphone/chrome-edge-microphone-permission-prompt.png)

{: .note}
> **macOS prompt**
>
> On macOS, you may also see an operating system prompt asking whether your browser can access the microphone. Click **Allow**.

![macOS microphone prompt (Edge)]({{ site.baseurl }}/assets/images/meet/microphone/macos-edge-microphone-permission-prompt.png)

## Select the Right Microphone in Meet

1. In Meet, open **Settings** (gear icon).
2. Under **Microphone**, choose the device you want to use (for example your headset instead of the laptop microphone).
3. If you have multiple similar devices, unplug/replug your headset and re-open the selector.

![Meet microphone selector]({{ site.baseurl }}/assets/images/meet/microphone/meet-microphone-selector.png)

## If You Clicked "Block" (Chrome/Edge)

If you clicked **Block** earlier, Meet will not be able to access your microphone until you change the site permission.

1. Open Meet.
2. In the browser address bar, click the lock icon (site controls).
3. Open **Site settings** (wording may vary).
4. Set **Microphone** to **Allow** for the Meet site.
5. Reload the page.

## Common Issues

| Symptom | What you can do |
|---|---|
| No microphone prompt appears | Check you didn't previously block microphone access (see the section above). Try Chrome/Edge. If nobody in your organization ever gets the prompt, contact your admin (see below). |
| Microphone list is empty in Meet | Confirm the browser permission is **Allowed**. Reload the page after changing permissions. Unplug/replug your headset and re-select the device in Meet settings. |
| Transcription is poor or intermittent / wrong mic is used | Select your headset microphone explicitly. Avoid duplicate devices (Bluetooth headset + dock + laptop mic) and reconnect the device. |
| Mic works in other apps but not in Meet | Check OS microphone privacy settings (next section). |

## OS Privacy Checks (If Browser Permission Is Correct)

### macOS

1. Open **System Settings**.
2. Go to **Privacy & Security** → **Microphone**.
3. Ensure Chrome/Edge is allowed.

### Windows 11

1. Open **Settings**.
2. Go to **Privacy & security** → **Microphone**.
3. Ensure microphone access is enabled, and that your browser is allowed (if shown).

## Managed Devices (Policies)

If you are on a managed company device, your IT department may lock microphone settings or pre-approve access. If you cannot change the setting, contact IT support.

## When to Contact Your Admin

If nobody in your organization gets a microphone prompt when opening Meet, your admin may need to adjust your organization's settings.

{: .note}
> **If you use Meet in Salesforce**
>
> Your Salesforce admin may need to adjust Salesforce org settings for Meet. Admin reference: [Salesforce Setup]({{ site.baseurl }}/meet/salesforce-setup/)
