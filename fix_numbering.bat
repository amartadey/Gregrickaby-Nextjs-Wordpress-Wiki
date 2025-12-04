@echo off
REM Rename files with zero-padded numbers for correct alphabetical sorting

REM Main pages (padding-left: 0px)
ren "1-overview.md" "01-overview.md"
ren "2-getting-started.md" "02-getting-started.md"
ren "3-architecture.md" "03-architecture.md"
ren "4-frontend-application.md" "04-frontend-application.md"
ren "5-data-access-layer.md" "05-data-access-layer.md"
ren "6-wordpress-integration.md" "06-wordpress-integration.md"
ren "7-development-environment.md" "07-development-environment.md"
ren "8-testing.md" "08-testing.md"
ren "9-build-and-deployment.md" "09-build-and-deployment.md"

REM Sub-pages under Getting Started (02.x)
ren "2.1-environment-configuration.md" "02.1-environment-configuration.md"
ren "2.2-development-commands.md" "02.2-development-commands.md"

REM Sub-pages under Architecture (03.x)
ren "3.1-type-system.md" "03.1-type-system.md"
ren "3.2-data-flow.md" "03.2-data-flow.md"
ren "3.3-caching-and-revalidation.md" "03.3-caching-and-revalidation.md"

REM Sub-pages under Frontend Application (04.x)
ren "4.1-pages-and-routing.md" "04.1-pages-and-routing.md"
ren "4.2-components.md" "04.2-components.md"
ren "4.3-layouts-and-metadata.md" "04.3-layouts-and-metadata.md"

REM Sub-pages under Data Access Layer (05.x)
ren "5.1-graphql-queries.md" "05.1-graphql-queries.md"
ren "5.2-graphql-mutations.md" "05.2-graphql-mutations.md"
ren "5.3-fetchgraphql-utility.md" "05.3-fetchgraphql-utility.md"
ren "5.4-search-functionality.md" "05.4-search-functionality.md"

REM Sub-pages under WordPress Integration (06.x)
ren "6.1-wordpress-configuration.md" "06.1-wordpress-configuration.md"
ren "6.2-preview-mode.md" "06.2-preview-mode.md"
ren "6.3-on-demand-revalidation.md" "06.3-on-demand-revalidation.md"

REM Sub-pages under Development Environment (07.x)
ren "7.1-vs-code-configuration.md" "07.1-vs-code-configuration.md"
ren "7.2-code-quality-tools.md" "07.2-code-quality-tools.md"
ren "7.3-git-hooks.md" "07.3-git-hooks.md"

REM Sub-pages under Testing (08.x)
ren "8.1-testing-infrastructure.md" "08.1-testing-infrastructure.md"
ren "8.2-writing-tests.md" "08.2-writing-tests.md"
ren "8.3-test-coverage.md" "08.3-test-coverage.md"

REM Sub-pages under Build and Deployment (09.x)
ren "9.1-build-process.md" "09.1-build-process.md"
ren "9.2-cicd-pipeline.md" "09.2-cicd-pipeline.md"
ren "9.3-static-generation.md" "09.3-static-generation.md"

echo File reorganization complete with zero-padded numbers!
pause
