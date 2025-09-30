---
layout: default
title: Upload/Deactivate Templates
nav_order: 4
parent: Present
collection: present
---

# How to upload new templates / deactivate old templates 

This article shows you how to upload new templates and deactivate existing templates in the Management UI.

## Before you start

Make sure that:
- The latest Present package is installed in your org
- Make sure all steps are completed in [technical details](../present-technical-details).

## Uploading a new template

1. Go to the Management UI and select Present->Setup.
![Present mgmt ui](../../assets/images/present/present_mgmt_ui_setup.png)

2. Click the Upload button.
![Upload](../../assets/images/present/upload_template_button.png)

3. Click Upload file and select file in the dialogue pop-up.
![Upload file](../../assets/images/present/upload_file_dialog.png)

4. When uploading the file is validated and admin gets an overview of findings.
![Upload finished](../../assets/images/present/upload_validate_results.png)

5. Now select an appropriate customer type and click Upload
![Customer type selection](../../assets/images/present/customer_type_upload.png)


{: .note }
> **Template Upload Progress**
>
> Depending on the size of your template, it takes between 10 - 60 seconds to upload and process the template.
> If the processing takes more than 60 seconds, please contact your Present administrator.

## Deactivate old templates

You can deactivate/archive old templates in the Management UI. This will keep your templates' metadata when deactivating templates used in reporting. This feature allows you to deactivate templates, but keep the metadata of a template you no longer want to use.

Go to the Management UI and select Present->Setup.
1. Choose the template to be deactivated and click the trash-icon.
![Deactivate](../../assets/images/present/deactivate_template.png)

2. Click Delete and the template will be deactivated.
![Delete](../../assets/images/present/delete_template_confirm.png)

3. Deactivated templates can be listed in the Management UI.
![Deactivated templates](../../assets/images/present/list_of_deactivated_templates.png)
