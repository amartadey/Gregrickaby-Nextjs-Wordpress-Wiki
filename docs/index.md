---
layout: default
title: Home
nav_order: 1
description: "Comprehensive documentation for the Next.js WordPress headless application"
permalink: /
---

# Next.js WordPress Documentation
{: .fs-9 }

A production-ready headless WordPress frontend built with Next.js 16, featuring server-side rendering, static site generation, and type-safe development.
{: .fs-6 .fw-300 }

[Get Started](02-getting-started.html){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }
[View on GitHub](https://github.com/gregrickaby/nextjs-wordpress){: .btn .fs-5 .mb-4 .mb-md-0 }

---

## What This System Does

This is a production-ready headless WordPress frontend built with Next.js 16. The application separates content management (WordPress) from content presentation (Next.js), enabling:

- **Server-side rendering** of WordPress content via GraphQL
- **Static site generation** with on-demand revalidation
- **Type-safe development** through auto-generated TypeScript definitions
- **Modern React patterns** using Server Components and the App Router

The system fetches content from a WordPress backend via the WPGraphQL plugin, renders it using React 19 Server Components, and serves optimized static pages with incremental regeneration.

---

## Quick Navigation

### Getting Started
Start here to set up your development environment and learn the basic commands.

- [Getting Started](02-getting-started.html)
- [Environment Configuration](02.1-environment-configuration.html)
- [Development Commands](02.2-development-commands.html)

### Core Concepts

- [Architecture](03-architecture.html) - System design and data flow
- [Frontend Application](04-frontend-application.html) - Pages, components, and routing
- [Data Access Layer](05-data-access-layer.html) - GraphQL queries and mutations
- [WordPress Integration](06-wordpress-integration.html) - Backend configuration

### Development

- [Development Environment](07-development-environment.html) - VS Code, linting, and git hooks
- [Testing](08-testing.html) - Unit tests, integration tests, and coverage
- [Build and Deployment](09-build-and-deployment.html) - CI/CD pipeline and static generation

---

## Technology Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| Next.js | 16.0.6 | App Router, React Compiler, Turbopack bundler |
| React | 19.2.0 | Server Components, client-side interactivity |
| TypeScript | 5.9.3 | Type safety across the codebase |
| Tailwind CSS | 4.1.17 | Utility-first styling framework |
| WordPress | N/A | Headless CMS via WPGraphQL |
| GraphQL Code Generator | 6.1.0 | Auto-generate TypeScript types |
| Vitest | 4.0.14 | Unit and integration testing |

---

## About This Documentation

This documentation provides a comprehensive guide to understanding and working with the Next.js WordPress headless application. Each section includes:

- Detailed explanations of system components
- Code examples with type annotations
- Architecture diagrams using Mermaid
- Links to relevant source files
- Best practices and design decisions

Navigate using the sidebar menu or use the search function to find specific topics.
