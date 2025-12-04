# GitHub Pages Documentation Site

This folder contains a Jekyll-based documentation website for the Next.js WordPress project.

## 🚀 Quick Start

### Option 1: GitHub Pages (Recommended)

1. **Enable GitHub Pages** in your repository:
   - Go to **Settings** → **Pages**
   - Under "Source", select **Deploy from a branch**
   - Choose branch: `main` (or your default branch)
   - Choose folder: `/docs`
   - Click **Save**

2. **Wait for deployment** (usually 1-2 minutes)
   - GitHub will automatically build and deploy your site
   - Visit: `https://[your-username].github.io/[repository-name]/`

3. **Update the URL** in `_config.yml`:
   - Replace `[username]` with your GitHub username
   - The `baseurl` is already set to `/gregrickaby-nextjs-wordpress-DeepWiki`

### Option 2: Local Development

To preview the site locally before deploying:

```bash
# Install Ruby (if not already installed)
# Windows: https://rubyinstaller.org/
# Mac: brew install ruby
# Linux: sudo apt-get install ruby-full

# Navigate to docs folder
cd docs

# Install dependencies
bundle install

# Serve locally
bundle exec jekyll serve

# Visit http://localhost:4000/gregrickaby-nextjs-wordpress-DeepWiki/
```

## 📁 Site Structure

```
docs/
├── _config.yml           # Jekyll configuration
├── Gemfile              # Ruby dependencies
├── index.md             # Homepage
├── 01-overview.md       # Main documentation files
├── 02-getting-started.md
├── 02.1-environment-configuration.md  # Subsections
└── ... (36 total markdown files)
```

## 🎨 Theme

This site uses the **[Just-the-Docs](https://just-the-docs.com/)** theme, which provides:

- **Hierarchical navigation** - Automatic sidebar with parent/child pages
- **Search functionality** - Full-text search across all documentation
- **Mermaid diagrams** - Renders architecture diagrams automatically
- **Dark mode** - Configured by default
- **Responsive design** - Mobile-friendly layout

## 📝 Adding New Pages

To add a new documentation page:

1. Create a new `.md` file in the `docs` folder
2. Add front matter at the top:

```yaml
---
layout: default
title: Your Page Title
parent: Parent Section (optional)
nav_order: 1
---
```

3. Write your content in Markdown
4. Commit and push - GitHub Pages will automatically rebuild

## 🔧 Configuration

Key settings in `_config.yml`:

- `title`: Site title
- `description`: Site description
- `url`: Your GitHub Pages URL
- `baseurl`: Repository name
- `color_scheme`: Theme color (currently `dark`)
- `search_enabled`: Enable/disable search

## 📊 Mermaid Diagrams

Mermaid diagrams are automatically rendered. Example:

\`\`\`mermaid
flowchart TD
    A[Start] --> B[Process]
    B --> C[End]
\`\`\`

## 🎯 Navigation Structure

The navigation is organized hierarchically:

1. **Home** - Welcome page
2. **Overview** - System introduction
3. **Getting Started** (has children)
   - Environment Configuration
   - Development Commands
4. **Architecture** (has children)
   - Type System
   - Data Flow
   - Caching and Revalidation
5. ... (continues for all sections)

## 🐛 Troubleshooting

### Site not updating after push
- Wait 1-2 minutes for GitHub Actions to complete
- Check the **Actions** tab in your repository for build status
- Ensure GitHub Pages is enabled in Settings

### Local build errors
- Run `bundle update` to update dependencies
- Ensure Ruby version is 2.7 or higher: `ruby --version`
- Clear Jekyll cache: `bundle exec jekyll clean`

### Navigation not showing
- Verify front matter is correctly formatted
- Check `nav_order` values are unique within parent groups
- Ensure `parent` names match exactly (case-sensitive)

## 📚 Resources

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [Just-the-Docs Theme](https://just-the-docs.com/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Markdown Guide](https://www.markdownguide.org/)

## ✨ Features

- ✅ 36 documentation pages organized hierarchically
- ✅ Dark mode enabled
- ✅ Full-text search
- ✅ Mermaid diagram support
- ✅ Responsive mobile design
- ✅ Automatic deployment via GitHub Pages
- ✅ No build process required (GitHub handles it)

---

**Note**: The markdown files currently don't have Jekyll front matter. You can either:
1. Use the site as-is (Jekyll will render them with default settings)
2. Run the `add_frontmatter.ps1` script to add proper navigation hierarchy
3. Manually add front matter to files you want in the navigation

To add front matter automatically, run:
```powershell
powershell -ExecutionPolicy Bypass -File add_frontmatter.ps1
```
