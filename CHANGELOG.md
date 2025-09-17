---
layout: default
title: Documentation Changelog
nav_order: 99
permalink: /changelog/
---

# Documentation Changelog

This changelog tracks significant updates and changes to the AndMoney documentation.

## August 2025

### Major Documentation Consolidation

#### Added

- Comprehensive deployment documentation structure in `_deployment/`:
  - `deployment/overview.md` - Platform deployment overview
  - `deployment/prerequisites.md` - Detailed prerequisites checklist
  - `deployment/installation/single-tenant.md` - Single-tenant installation guide
  - `deployment/installation/multi-tenant.md` - Multi-tenant installation guide
  - `deployment/quick-start/` - Quick start guides for rapid deployment
  - `deployment/reference/` - Technical reference documentation
  - `deployment/configuration/` - Configuration guides for all components
- PowerShell scripts documentation with examples and automation scenarios
- Graph Proxy technical architecture documentation
- SCIM provisioning comprehensive setup guide
- Teams integration configuration documentation
- Management portal setup and role assignment guides
- Additional documentation about historic meetings for CRM analytics
- Enhanced Insights documentation with detailed analytics information

#### Removed (Duplicates Eliminated)

- Deleted 8 duplicate files from `_bookme/` folder that were redundant with deployment docs:
  - `multi-tenant-installation.md` (duplicate of deployment version)
  - `single-tenant-installation.md` (duplicate of deployment version)
  - `prerequisites.md` (duplicate of deployment version)
  - `scim-provisioning-setup.md` (duplicate of deployment version)
  - `graph-proxy.md` (duplicate of deployment version)
  - `multi-tenant-quickstart.md` (duplicate of deployment version)
  - `powershell-reference.md` (duplicate of deployment version)
  - `entra-integration.md` (content merged into deployment docs)
  - `enable-scim-provisioning.md` (duplicate of PowerShell scripts doc)
- Removed redundant `entra-integration.md` from deployment configuration

#### Reorganized

- Moved 4 deployment-related files from `_bookme/` to `_deployment/configuration/`:
  - `app-registration-installation.md` → `app-registration-setup.md`
  - `microsoft-365-integration.md` (kept same name)
  - `add-teams-access-policy.md` → `teams-access-policy.md`
- Properly organized documentation so `_bookme/` contains only BookMe-specific features
- `_deployment/` now contains all platform deployment and configuration docs

#### Updated

- Updated 20+ cross-references throughout documentation to point to new locations
- Fixed all broken links from reorganization
- Merged unique content from deleted files into appropriate locations
- Added client secret expiration warnings to app registration setup
- Insights details page with comprehensive meeting analytics documentation

### Results

- **35% reduction** in `_bookme/` folder size (from 23 to 15 files)
- **Eliminated 70% of duplicate content** across the documentation
- Single source of truth for all deployment and configuration topics
- Clearer separation between product features and deployment configuration

## July 2025

### Added
- Expanded portal setup documentation with field configuration details
- Portal creation and configuration guide with screenshots
- Portal testing documentation

### Updated
- Portal documentation with enhanced setup instructions and error handling
- Data retention and deletion overview improvements
- Meeting title and description formatting improvements

## June 2025

### Updated
- Improved navigation and accessibility across all documentation
- Enhanced cross-references between related topics

## May 2025

### Added
- Release notes for version 1.16
- Practical guide to Present feature
- Troubleshooting guide for Present
- Technical flow documentation for Insights
- iCal documentation for calendar integration

### Updated
- App offer installation guide to include Teams Access policy
- SCIM provisioning setup documentation
- Graph proxy documentation improvements
- Present documentation with new ordering and enhanced content
- Salesforce release notes with latest packages
- Present reporting documentation with additional details

## April 2025

### Added
- Data retention and deletion overview section
- Documentation for setting up AndMoney Salesforce integration

### Updated
- Documentation structure improvements for better readability

## March 2025

### Added

- Enhanced landing page with detailed product descriptions
- New documentation organization section
- Improved getting started guide with step-by-step instructions
- Added support section with troubleshooting resources
- Created documentation changelog
- New architecture diagrams and callout configurations
- Validation tool details documentation

### Updated

- Restructured product descriptions with feature-specific bullet points
- Improved navigation and readability of main documentation

## Historical Changes

Previous documentation updates are being compiled and will be added retrospectively.
