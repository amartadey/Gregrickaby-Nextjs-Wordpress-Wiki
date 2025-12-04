@echo off
REM Main pages (padding-left: 0px)
ren "Overview.md" "1-overview.md"
ren "Getting-Started.md" "2-getting-started.md"
ren "Architecture.md" "3-architecture.md"
ren "Frontend-Application.md" "4-frontend-application.md"
ren "Data-Access-Layer.md" "5-data-access-layer.md"
ren "WordPress-Integration.md" "6-wordpress-integration.md"
ren "Development-Environment.md" "7-development-environment.md"
ren "Testing.md" "8-testing.md"
ren "Build-and-Deployment.md" "9-build-and-deployment.md"
ren "SEO-and-Public-Files.md" "10-seo-and-public-files.md"
ren "Development-Agents.md" "11-development-agents.md"
ren "TypeScript-Configuration.md" "12-typescript-configuration.md"

REM Sub-pages under Getting Started (2.x)
ren "Environment-Configuration.md" "2.1-environment-configuration.md"
ren "Development-Commands.md" "2.2-development-commands.md"

REM Sub-pages under Architecture (3.x)
ren "Type-System.md" "3.1-type-system.md"
ren "Data-Flow.md" "3.2-data-flow.md"
ren "Caching-and-Revalidation.md" "3.3-caching-and-revalidation.md"

REM Sub-pages under Frontend Application (4.x)
ren "Pages-and-Routing.md" "4.1-pages-and-routing.md"
ren "Components.md" "4.2-components.md"
ren "Layouts-and-Metadata.md" "4.3-layouts-and-metadata.md"

REM Sub-pages under Data Access Layer (5.x)
ren "GraphQL-Queries.md" "5.1-graphql-queries.md"
ren "GraphQL-Mutations.md" "5.2-graphql-mutations.md"
ren "fetchGraphQL-Utility.md" "5.3-fetchgraphql-utility.md"
ren "Search-Functionality.md" "5.4-search-functionality.md"

REM Sub-pages under WordPress Integration (6.x)
ren "WordPress-Configuration.md" "6.1-wordpress-configuration.md"
ren "Preview-Mode.md" "6.2-preview-mode.md"
ren "On-Demand-Revalidation.md" "6.3-on-demand-revalidation.md"

REM Sub-pages under Development Environment (7.x)
ren "VS-Code-Configuration.md" "7.1-vs-code-configuration.md"
ren "Code-Quality-Tools.md" "7.2-code-quality-tools.md"
ren "Git-Hooks.md" "7.3-git-hooks.md"

REM Sub-pages under Testing (8.x)
ren "Testing-Infrastructure.md" "8.1-testing-infrastructure.md"
ren "Writing-Tests.md" "8.2-writing-tests.md"
ren "Test-Coverage.md" "8.3-test-coverage.md"

REM Sub-pages under Build and Deployment (9.x)
ren "Build-Process.md" "9.1-build-process.md"
ren "Static-Generation.md" "9.3-static-generation.md"

REM Move CI/CD Pipeline file from CI folder to root and rename
move "CI\CD-Pipeline.md" "9.2-cicd-pipeline.md"

echo File reorganization complete!
pause
