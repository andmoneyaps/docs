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
