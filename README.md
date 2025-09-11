# AndMoney Public Documentation

This repository contains the public documentation for AndMoney products and services. The documentation is built using [Jekyll](https://jekyllrb.com/) and hosted on GitHub Pages with the [Just the Docs](https://just-the-docs.github.io/just-the-docs/) theme.

## Local Development

### Prerequisites

- Ruby (version 2.7.0 or higher)
- Bundler gem

### Setup

1. Clone the repository
2. Navigate to the docs directory:
```bash
cd Docs
```

3. Install dependencies:
```bash
bundle install
```

4. Start the local server:
```bash
bundle exec jekyll serve
```

The site will be available at [http://localhost:4000/docs/](http://localhost:4000/docs/).

## Documentation Structure

```
docs/
├── index.md                 # Home page
├── _bookme/                # BookMe documentation
├── _present/               # Present documentation
└── _insights/             # Insights documentation
```

## Contributing

1. Create a new branch for your changes
2. Add or modify markdown files in the appropriate directory
3. Test your changes locally
4. Create a pull request

## Writing Guidelines

- Use markdown for all documentation files
- Include a front matter block at the top of each file:
  ```yaml
  ---
  layout: default
  title: Your Page Title
  nav_order: 1
  parent: Parent Section (if applicable)
  ---
  ```
- Add descriptive alt text to images
- Use proper heading hierarchy (h1 for title, h2 for sections, etc.)
- Include code examples where relevant

### Referencing images
- Store images in the `assets/images/` directory
- Reference images using relative paths:
```markdown 
![Alt text]({{ site.baseurl }}/assets/images/your-image.png)
```

Alternatively you can use the `<img>` tag:
```html
<img src="{{ site.baseurl }}/assets/images/your-image.png" alt="Alt text" width="500">
```

#### Examples of image references
Example of use from: https://andmoneyaps.github.io/docs/deployment/configuration/microsoft-365-integration/

```markdown
![Map users/groups to roles]({{ site.baseurl }}/assets/images/booking-platform-api-role-mappings.png)
```

And from https://andmoneyaps.github.io/docs/present/How-to-upload-new-templates/
```html
<img alt="Deactivate template" src="{{ site.baseurl }}/assets/images/present/deactivate.png" width="300"/>
```

### Links
- Use relative links for internal documentation:

```markdown
[Link text](../path/to/page)
```

Note, no .md suffix is needed for internal links.

#### Example

Example of use from: https://andmoneyaps.github.io/docs/deployment/configuration/microsoft-365-integration/ 
To: https://andmoneyaps.github.io/docs/deployment/configuration/app-registration-setup/

```markdown
For detailed steps, refer to the [App Registration Setup Guide](../app-registration-setup)
```

