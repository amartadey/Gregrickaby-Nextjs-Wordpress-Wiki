# Complete Guide: Building a Headless WordPress Site with Next.js

## Table of Contents
1. [Introduction](#introduction)
2. [What is Headless WordPress?](#what-is-headless-wordpress)
3. [Architecture Overview](#architecture-overview)
4. [Prerequisites](#prerequisites)
5. [Step-by-Step Implementation](#step-by-step-implementation)
6. [Understanding GraphQL Queries](#understanding-graphql-queries)
7. [Working with ACF Fields](#working-with-acf-fields)
8. [Common Issues and Solutions](#common-issues-and-solutions)
9. [Best Practices](#best-practices)
10. [Next Steps](#next-steps)

---

## Introduction

This guide teaches you how to build a **headless WordPress** site using **Next.js** as the frontend and **GraphQL** for data fetching. By the end, you'll understand how to fetch and display any WordPress content, including Advanced Custom Fields (ACF), in a modern React application.

**What You'll Learn:**
- How to set up WordPress as a headless CMS
- How to configure GraphQL for WordPress
- How to build a Next.js frontend that consumes WordPress data
- How to work with ACF fields in a headless setup
- How to handle images and media files

---

## What is Headless WordPress?

### Traditional WordPress
In a traditional WordPress setup, WordPress handles both:
- **Backend** (content management, database)
- **Frontend** (theme, HTML rendering, display)

```
┌─────────────────────────────────┐
│        WordPress                │
│  ┌──────────┐   ┌──────────┐   │
│  │ Backend  │ → │ Frontend │   │
│  │  (PHP)   │   │ (Theme)  │   │
│  └──────────┘   └──────────┘   │
└─────────────────────────────────┘
         ↓
    User's Browser
```

### Headless WordPress
In a headless setup, WordPress only handles the backend, and a separate application (Next.js) handles the frontend:

```
┌──────────────┐           ┌──────────────┐
│  WordPress   │           │   Next.js    │
│   Backend    │  GraphQL  │   Frontend   │
│   (CMS)      │ ←────────→│   (React)    │
└──────────────┘           └──────────────┘
                                  ↓
                           User's Browser
```

**Benefits:**
- ⚡ **Performance**: Static generation, faster page loads
- 🎨 **Flexibility**: Use any frontend framework (React, Vue, etc.)
- 🔒 **Security**: WordPress admin is separate from public site
- 📱 **Multi-platform**: Same content for web, mobile apps, etc.
- 🚀 **Modern UX**: React-based interactive experiences

---

## Architecture Overview

### The Complete Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    WordPress Backend                        │
│  ┌──────────┐  ┌──────────┐  ┌─────────────────────────┐  │
│  │   ACF    │  │   Posts  │  │      WPGraphQL          │  │
│  │  Fields  │  │   Pages  │  │   (GraphQL Endpoint)    │  │
│  └──────────┘  └──────────┘  └─────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                           ↓
                    GraphQL Query
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                    Next.js Frontend                         │
│  ┌─────────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │  fetchGraphQL() │→ │ Query Files  │→ │ Page.js      │  │
│  │   (Utility)     │  │ (getPage...) │  │ (Component)  │  │
│  └─────────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────────┘
                           ↓
                    Rendered HTML
                           ↓
                    User's Browser
```

### Key Components

1. **WordPress (Backend)**
   - Stores content in database
   - Manages ACF fields
   - Exposes GraphQL API endpoint

2. **WPGraphQL Plugin**
   - Creates GraphQL endpoint at `/graphql`
   - Converts WordPress data to GraphQL schema
   - Handles queries from frontend

3. **Next.js (Frontend)**
   - Fetches data via GraphQL
   - Renders React components
   - Serves optimized pages to users

---

## Prerequisites

### Required Software
- **Node.js** (v18 or higher)
- **npm** (comes with Node.js)
- **WordPress** (v5.0 or higher)
- **Local server** (Laragon, XAMPP, Local, etc.)

### Required WordPress Plugins
1. **WPGraphQL** - Core GraphQL functionality
2. **WPGraphQL for Advanced Custom Fields** - Exposes ACF in GraphQL
3. **Advanced Custom Fields (ACF)** - Custom field management

### Knowledge Requirements
- Basic JavaScript/React understanding
- Basic WordPress knowledge
- Command line basics

---

## Step-by-Step Implementation

### Phase 1: WordPress Backend Setup

#### Step 1.1: Install Required Plugins

**Via WordPress Admin:**

1. Go to **Plugins → Add New**
2. Search for "WPGraphQL"
3. Click **Install Now** → **Activate**
4. Repeat for "WPGraphQL for Advanced Custom Fields"

**Verify Installation:**
- Navigate to: `http://your-wordpress-site.test/graphql`
- You should see the GraphiQL IDE (GraphQL playground)

#### Step 1.2: Create ACF Field Group

1. Go to **WordPress Admin → ACF → Field Groups**
2. Click **Add New**
3. Name it "Home Page Fields"
4. Add fields (examples):

| Field Label | Field Name | Field Type |
|------------|------------|------------|
| Custom Text | custom_text | Text |
| Custom Number | custom_number | Number |
| Custom Email | custom_email | Email |
| Custom Image | custom_image | Image |
| Custom Gallery | custom_gallery | Gallery |

5. **Location Rules**: Set to show on specific pages (e.g., "Home")

#### Step 1.3: Configure GraphQL Settings

**Critical Step:** Enable GraphQL for your field group

1. Scroll to **GraphQL Settings** section
2. Toggle **"Show in GraphQL"** to **ON**
3. Set **"GraphQL Field Name"**: `homePageFields`
4. Click **Update**

**Why This Matters:**
- Without this, ACF fields won't appear in GraphQL
- The field name (`homePageFields`) is how you'll access fields in queries

#### Step 1.4: Add Content to Fields

1. Go to **Pages → Home → Edit**
2. Scroll to your ACF field group
3. Fill in dummy data:
   - Text: "Hello from WordPress!"
   - Number: 42
   - Email: test@example.com
   - Upload an image
   - Add 3-4 images to gallery
4. Click **Update**

#### Step 1.5: Test GraphQL Endpoint

**Open GraphiQL:** `http://your-wordpress-site.test/graphql`

**Run Test Query:**
```graphql
query {
  page(id: "/home/", idType: URI) {
    title
    homePageFields {
      customText
      customNumber
    }
  }
}
```

**Expected Response:**
```json
{
  "data": {
    "page": {
      "title": "Home Page",
      "homePageFields": {
        "customText": "Hello from WordPress!",
        "customNumber": 42
      }
    }
  }
}
```

✅ **If you see data, WordPress backend is ready!**

---

### Phase 2: Next.js Frontend Setup

#### Step 2.1: Create Next.js Project

**Open terminal in your project folder:**

```bash
# Create frontend folder
mkdir frontend
cd frontend

# Initialize Next.js with JavaScript
npx create-next-app@latest . --js --tailwind --app --no-src-dir --import-alias "@/*" --turbopack --no-git
```

**Flags Explained:**
- `--js`: Use JavaScript (not TypeScript)
- `--tailwind`: Include Tailwind CSS
- `--app`: Use App Router (not Pages Router)
- `--no-src-dir`: Don't create src/ folder
- `--import-alias "@/*"`: Enable @ imports
- `--turbopack`: Use faster Turbopack bundler
- `--no-git`: Don't initialize Git

#### Step 2.2: Install GraphQL Dependencies

```bash
npm install graphql @graphql-codegen/cli @graphql-codegen/client-preset
```

**What These Do:**
- `graphql`: Core GraphQL library
- `@graphql-codegen/cli`: Generates TypeScript types (optional)
- `@graphql-codegen/client-preset`: Preset for client-side GraphQL

#### Step 2.3: Create Environment Variables

**Create `.env.local` file in frontend folder:**

```env
NEXT_PUBLIC_WORDPRESS_GRAPHQL_URL=http://your-wordpress-site.test/graphql
NEXT_PUBLIC_WORDPRESS_REST_API_URL=http://your-wordpress-site.test/wp-json/wp/v2
```

**Important Notes:**
- ⚠️ `.env.local` is gitignored - you must create it manually
- ⚠️ Variables must start with `NEXT_PUBLIC_` to work in browser
- ⚠️ Restart dev server after changing env variables

#### Step 2.4: Configure Next.js for WordPress Images

**Edit `next.config.mjs`:**

```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    formats: ['image/avif', 'image/webp'],
    unoptimized: true, // For local development
    remotePatterns: [
      {
        protocol: 'http',
        hostname: 'your-wordpress-site.test',
      },
    ],
  },
};

export default nextConfig;
```

**Why `unoptimized: true`?**
- Next.js image optimization doesn't work well with local domains
- For production, remove this and use proper domain

---

### Phase 3: Create Data Fetching Layer

#### Step 3.1: Create Site Configuration

**Create `lib/config.js`:**

```javascript
const config = {
  siteName: 'My Headless WordPress Site',
  siteDescription: 'Built with Next.js and GraphQL',
  siteUrl: 'http://localhost:3000',
  revalidation: 3600, // Cache for 1 hour
}

export default config
```

#### Step 3.2: Create GraphQL Fetch Utility

**Create `lib/functions.js`:**

```javascript
/**
 * Fetch data from WordPress GraphQL API
 * @param {string} query - GraphQL query string
 * @param {Object} variables - Query variables
 * @returns {Promise<Object|null>} GraphQL response
 */
export async function fetchGraphQL(query, variables = {}) {
  const url = process.env.NEXT_PUBLIC_WORDPRESS_GRAPHQL_URL

  if (!url) {
    console.error('GraphQL URL not configured')
    return null
  }

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ query, variables }),
      next: {
        revalidate: 3600, // Cache for 1 hour
        tags: ['graphql'],
      },
    })

    if (!response.ok) {
      console.error(`GraphQL request failed: ${response.statusText}`)
      return null
    }

    const json = await response.json()

    if (json.errors) {
      console.error('GraphQL errors:', json.errors)
    }

    return json
  } catch (error) {
    console.error('GraphQL fetch error:', error)
    return null
  }
}
```

**Key Features:**
- ✅ Error handling
- ✅ Caching with `next.revalidate`
- ✅ Environment variable validation
- ✅ Detailed logging

#### Step 3.3: Create Query Functions

**Create `lib/queries/getPageBySlug.js`:**

```javascript
import { fetchGraphQL } from '../functions'

export default async function getPageBySlug(slug) {
  const query = `
    query GetPageBySlug($slug: ID!) {
      page(id: $slug, idType: URI) {
        id
        title
        content
        homePageFields {
          customText
          customNumber
          customEmail
          customImage {
            node {
              sourceUrl
              altText
              mediaDetails {
                width
                height
              }
            }
          }
          customGallery {
            nodes {
              sourceUrl
              altText
              mediaDetails {
                width
                height
              }
            }
          }
        }
      }
    }
  `

  const response = await fetchGraphQL(query, { slug: `/${slug}/` })
  
  if (!response?.data?.page) {
    return null
  }

  return response.data.page
}
```

**Important Notes:**
- ACF image fields use `node` structure (not direct access)
- Gallery fields use `nodes` (plural)
- This is specific to WPGraphQL + ACF

---

### Phase 4: Build the Frontend

#### Step 4.1: Create Home Page Component

**Edit `app/page.js`:**

```javascript
import getPageBySlug from '@/lib/queries/getPageBySlug'
import Image from 'next/image'

export default async function HomePage() {
  // Fetch page data from WordPress
  const page = await getPageBySlug('home')

  if (!page) {
    return <div>Page not found</div>
  }

  const acf = page.homePageFields || {}

  return (
    <main className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold mb-4">{page.title}</h1>
      
      {/* Page Content */}
      {page.content && (
        <div dangerouslySetInnerHTML={{ __html: page.content }} />
      )}

      {/* ACF Fields */}
      <div className="mt-8 space-y-6">
        {/* Text Field */}
        {acf.customText && (
          <div>
            <h2 className="text-2xl font-semibold">Custom Text</h2>
            <p>{acf.customText}</p>
          </div>
        )}

        {/* Number Field */}
        {acf.customNumber && (
          <div>
            <h2 className="text-2xl font-semibold">Custom Number</h2>
            <p>{acf.customNumber}</p>
          </div>
        )}

        {/* Image Field */}
        {acf.customImage?.node && (
          <div>
            <h2 className="text-2xl font-semibold">Custom Image</h2>
            <Image
              src={acf.customImage.node.sourceUrl}
              alt={acf.customImage.node.altText || 'Image'}
              width={acf.customImage.node.mediaDetails?.width || 800}
              height={acf.customImage.node.mediaDetails?.height || 600}
              className="rounded-lg"
            />
          </div>
        )}

        {/* Gallery Field */}
        {acf.customGallery?.nodes && (
          <div>
            <h2 className="text-2xl font-semibold">Gallery</h2>
            <div className="grid grid-cols-3 gap-4">
              {acf.customGallery.nodes.map((image, index) => (
                <Image
                  key={index}
                  src={image.sourceUrl}
                  alt={image.altText || `Image ${index + 1}`}
                  width={400}
                  height={300}
                  className="rounded-lg"
                />
              ))}
            </div>
          </div>
        )}
      </div>
    </main>
  )
}
```

#### Step 4.2: Run Development Server

```bash
npm run dev
```

**Open:** http://localhost:3000

✅ **You should see your WordPress content!**

---

## Understanding GraphQL Queries

### Basic Query Structure

```graphql
query QueryName($variable: Type!) {
  resourceType(filter: $variable) {
    field1
    field2
    nestedField {
      subField1
      subField2
    }
  }
}
```

### Real Example: Fetching a Page

```graphql
query GetPageBySlug($slug: ID!) {
  page(id: $slug, idType: URI) {
    title
    content
  }
}
```

**Variables:**
```json
{
  "slug": "/home/"
}
```

### Exploring the Schema

**Use GraphiQL to explore available fields:**

1. Open: `http://your-wordpress-site.test/graphql`
2. Click **"Docs"** panel on the right
3. Search for "Page" type
4. See all available fields

### Common Query Patterns

**Get All Posts:**
```graphql
query {
  posts {
    nodes {
      id
      title
      excerpt
      slug
    }
  }
}
```

**Get Single Post:**
```graphql
query GetPost($slug: ID!) {
  post(id: $slug, idType: SLUG) {
    title
    content
    date
  }
}
```

**Get Posts with Categories:**
```graphql
query {
  posts {
    nodes {
      title
      categories {
        nodes {
          name
        }
      }
    }
  }
}
```

---

## Working with ACF Fields

### Understanding ACF Field Structure in GraphQL

#### Regular WordPress Fields
```graphql
featuredImage {
  node {
    sourceUrl  # Direct access
  }
}
```

#### ACF Fields (Different Structure!)
```graphql
customImage {
  node {      # Must access through 'node'
    sourceUrl
  }
}
```

### ACF Field Type Mapping

| ACF Type | GraphQL Structure | Example |
|----------|------------------|---------|
| Text | Direct string | `customText` |
| Number | Direct number | `customNumber` |
| Image | `node { sourceUrl }` | `customImage { node { sourceUrl } }` |
| Gallery | `nodes [ { sourceUrl } ]` | `customGallery { nodes { sourceUrl } }` |
| File | `node { mediaItemUrl }` | `customFile { node { mediaItemUrl } }` |
| Repeater | Array of objects | `customRepeater { field1, field2 }` |
| Group | Nested object | `customGroup { field1, field2 }` |

### Complete ACF Query Example

```graphql
query {
  page(id: "/home/", idType: URI) {
    homePageFields {
      # Simple fields
      customText
      customNumber
      customEmail
      customUrl
      
      # Choice fields
      customSelect
      customRadioButton
      customCheckbox
      customTrueFalse
      
      # Content fields
      customWysiwygEditor
      
      # Media fields (note the 'node' structure)
      customImage {
        node {
          sourceUrl
          altText
          mediaDetails {
            width
            height
          }
        }
      }
      
      customFile {
        node {
          mediaItemUrl
          title
          fileSize
          mimeType
        }
      }
      
      customGallery {
        nodes {
          sourceUrl
          altText
        }
      }
    }
  }
}
```

### Displaying ACF Fields in React

```javascript
// Text field
{acf.customText && <p>{acf.customText}</p>}

// Number field
{acf.customNumber && <span>{acf.customNumber}</span>}

// Image field (note the .node access)
{acf.customImage?.node && (
  <Image
    src={acf.customImage.node.sourceUrl}
    alt={acf.customImage.node.altText || 'Image'}
    width={800}
    height={600}
  />
)}

// Gallery field (note the .nodes array)
{acf.customGallery?.nodes?.map((image, index) => (
  <Image
    key={index}
    src={image.sourceUrl}
    alt={image.altText || `Image ${index}`}
    width={400}
    height={300}
  />
))}

// File field
{acf.customFile?.node && (
  <a href={acf.customFile.node.mediaItemUrl} download>
    Download {acf.customFile.node.title}
  </a>
)}
```

---

## Common Issues and Solutions

### Issue 1: "Page Not Found" Error

**Symptoms:**
- Frontend shows "Page not found"
- Console: `NEXT_PUBLIC_WORDPRESS_GRAPHQL_URL is not defined`

**Cause:** Missing `.env.local` file

**Solution:**
1. Create `.env.local` in frontend folder
2. Add environment variables
3. Restart dev server (`Ctrl+C`, then `npm run dev`)

---

### Issue 2: ACF Fields Not Showing in GraphQL

**Symptoms:**
- GraphQL query returns `null` for ACF fields
- Fields don't appear in GraphiQL schema

**Cause:** ACF field group not configured for GraphQL

**Solution:**
1. Go to ACF field group settings
2. Enable **"Show in GraphQL"**
3. Set **"GraphQL Field Name"**
4. Save and refresh GraphiQL

---

### Issue 3: Images Not Displaying (400 Errors)

**Symptoms:**
- Console shows 400 errors for images
- Images don't load on frontend

**Cause:** Next.js image optimization failing for local domain

**Solution:**
Add `unoptimized: true` to `next.config.mjs`:

```javascript
const nextConfig = {
  images: {
    unoptimized: true, // Add this for local development
    remotePatterns: [
      {
        protocol: 'http',
        hostname: 'your-site.test',
      },
    ],
  },
};
```

---

### Issue 4: GraphQL Errors for Media Fields

**Symptoms:**
```
Cannot query field "sourceUrl" on type "AcfMediaItemConnectionEdge"
```

**Cause:** Incorrect query structure for ACF media fields

**Solution:**
Use `node` for single images, `nodes` for galleries:

```graphql
# ❌ Wrong
customImage {
  sourceUrl
}

# ✅ Correct
customImage {
  node {
    sourceUrl
  }
}

# ❌ Wrong
customGallery {
  sourceUrl
}

# ✅ Correct
customGallery {
  nodes {
    sourceUrl
  }
}
```

---

### Issue 5: CORS Errors

**Symptoms:**
- Console: `Access-Control-Allow-Origin` error
- Requests blocked by browser

**Solution:**
Add to WordPress `wp-config.php`:

```php
header('Access-Control-Allow-Origin: http://localhost:3000');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
```

---

### Issue 6: WordPress Changes Not Appearing on Frontend

**Symptoms:**
- Update ACF fields in WordPress
- Changes don't appear on Next.js frontend immediately
- Have to wait a long time or hard refresh to see updates

**Cause:** Next.js is caching GraphQL responses

**Explanation:**
By default, the `fetchGraphQL` function caches responses for 1 hour (3600 seconds):

```javascript
next: {
  revalidate: 3600, // Cache for 1 hour
  tags: ['graphql'],
}
```

This is great for production (faster page loads, less server load) but annoying during development.

**Solution for Development:**

Edit `lib/functions.js` and change `revalidate` to `0`:

```javascript
export async function fetchGraphQL(query, variables = {}) {
  // ...
  const response = await fetch(url, {
    // ...
    next: {
      revalidate: 0, // Disable cache for development
      tags: ['graphql'],
    },
  })
}
```

**Solution for Production:**

Use environment-based caching:

```javascript
next: {
  revalidate: process.env.NODE_ENV === 'production' ? 3600 : 0,
  tags: ['graphql'],
}
```

This way:
- **Development**: No cache (see changes immediately)
- **Production**: 1-hour cache (better performance)

**After changing:**
1. Restart dev server (`Ctrl+C`, then `npm run dev`)
2. Update WordPress content
3. Refresh frontend → Changes appear immediately!

**Alternative Solutions:**

1. **Shorter cache duration:**
   ```javascript
   revalidate: 60, // Cache for 1 minute
   ```

2. **Hard refresh in browser:**
   - Windows/Linux: `Ctrl + Shift + R`
   - Mac: `Cmd + Shift + R`

3. **Clear Next.js cache:**
   ```bash
   rm -rf .next
   npm run dev
   ```

---

## Best Practices

### 1. Query Optimization

**❌ Don't fetch unnecessary data:**
```graphql
query {
  posts {
    nodes {
      id
      title
      content  # Large field, only fetch if needed
      excerpt
      # ... 20 more fields
    }
  }
}
```

**✅ Fetch only what you need:**
```graphql
query {
  posts {
    nodes {
      id
      title
      excerpt  # Lighter than full content
    }
  }
}
```

### 2. Error Handling

**Always handle null/undefined:**

```javascript
// ❌ Will crash if data is missing
const title = page.homePageFields.customText

// ✅ Safe access with optional chaining
const title = page?.homePageFields?.customText || 'Default'
```

### 3. Environment Variables

**Use different configs for dev/production:**

```env
# .env.local (development)
NEXT_PUBLIC_WORDPRESS_GRAPHQL_URL=http://localhost:8000/graphql

# .env.production (production)
NEXT_PUBLIC_WORDPRESS_GRAPHQL_URL=https://api.yoursite.com/graphql
```

### 4. Caching Strategy

**Use Next.js revalidation:**

```javascript
export async function fetchGraphQL(query, variables) {
  const response = await fetch(url, {
    // ...
    next: {
      revalidate: 3600, // Revalidate every hour
      tags: ['graphql'], // For on-demand revalidation
    },
  })
}
```

### 5. Image Optimization

**For production, use proper domains:**

```javascript
// next.config.mjs
const nextConfig = {
  images: {
    unoptimized: false, // Enable optimization in production
    remotePatterns: [
      {
        protocol: 'https', // Use HTTPS in production
        hostname: 'cdn.yoursite.com',
      },
    ],
  },
};
```

---

## Next Steps

### 1. Add More Pages

**Create a blog listing page:**

```javascript
// app/blog/page.js
import getAllPosts from '@/lib/queries/getAllPosts'

export default async function BlogPage() {
  const posts = await getAllPosts()
  
  return (
    <div>
      {posts.map(post => (
        <article key={post.id}>
          <h2>{post.title}</h2>
          <div dangerouslySetInnerHTML={{ __html: post.excerpt }} />
        </article>
      ))}
    </div>
  )
}
```

### 2. Dynamic Routes

**Create single post pages:**

```javascript
// app/blog/[slug]/page.js
import getPostBySlug from '@/lib/queries/getPostBySlug'

export default async function PostPage({ params }) {
  const post = await getPostBySlug(params.slug)
  
  return (
    <article>
      <h1>{post.title}</h1>
      <div dangerouslySetInnerHTML={{ __html: post.content }} />
    </article>
  )
}
```

### 3. Add Search Functionality

**Use WordPress REST API for search:**

```javascript
export async function searchPosts(query) {
  const url = `${process.env.NEXT_PUBLIC_WORDPRESS_REST_API_URL}/posts?search=${query}`
  const response = await fetch(url)
  return response.json()
}
```

### 4. Implement ISR (Incremental Static Regeneration)

```javascript
export const revalidate = 3600 // Revalidate every hour

export default async function Page() {
  // Page will be statically generated and revalidated
}
```

### 5. Add More ACF Field Types

**Repeater Fields:**
```graphql
customRepeater {
  title
  description
  image {
    node {
      sourceUrl
    }
  }
}
```

**Flexible Content:**
```graphql
customFlexible {
  ... on Page_Homefields_CustomFlexible_TextBlock {
    fieldGroupName
    text
  }
  ... on Page_Homefields_CustomFlexible_ImageBlock {
    fieldGroupName
    image {
      node {
        sourceUrl
      }
    }
  }
}
```

---

## Summary

You've learned how to:

✅ Set up WordPress as a headless CMS  
✅ Configure WPGraphQL and ACF  
✅ Build a Next.js frontend with JavaScript  
✅ Fetch data using GraphQL  
✅ Display ACF fields of all types  
✅ Handle images and media files  
✅ Troubleshoot common issues  

**Key Takeaways:**

1. **Headless WordPress** separates content management from presentation
2. **GraphQL** provides efficient, flexible data fetching
3. **ACF fields** use `node`/`nodes` structure in GraphQL
4. **Next.js** enables modern, performant frontends
5. **Environment variables** must start with `NEXT_PUBLIC_` for browser access

**Your headless WordPress site is now ready for production!** 🚀

---

## Additional Resources

- **WPGraphQL Docs:** https://www.wpgraphql.com/docs
- **ACF + WPGraphQL:** https://www.wpgraphql.com/acf
- **Next.js Documentation:** https://nextjs.org/docs
- **GraphQL Learning:** https://graphql.org/learn
- **Next.js Image Optimization:** https://nextjs.org/docs/app/building-your-application/optimizing/images
