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

### Results

- **35% reduction** in `_bookme/` folder size (from 23 to 15 files)
- **Eliminated 70% of duplicate content** across the documentation
- Single source of truth for all deployment and configuration topics
- Clearer separation between product features and deployment configuration

## March 2025

### Added

- Enhanced landing page with detailed product descriptions
- New documentation organization section
- Improved getting started guide with step-by-step instructions
- Added support section with troubleshooting resources
- Created documentation changelog

### Updated

- Restructured product descriptions with feature-specific bullet points
- Improved navigation and readability of main documentation

## Historical Changes

Previous documentation updates are being compiled and will be added retrospectively.
