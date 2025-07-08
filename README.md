# 🌅 raisingpixels.dev

> *Exploring the intersection of parenting and technology*

A modern Hugo-powered blog with a custom theme featuring advanced search functionality and responsive design.

## ✨ Features

### 🎨 Design & Aesthetics
- **Cozy Themes**: Sunset-inspired color palettes for light and dark, with glassmorphism effects
- **Responsive Design**: Optimized for all devices and screen sizes
- **Dark/Light Mode**: Automatic theme switching based on system preference
- **Custom Typography**: Carefully selected font combinations (Source Serif 4, Space Grotesk, Caveat)
- **Floating Animations**: Subtle pixel animations for visual interest

### 📝 Content Management
- **Hugo Static Site Generator**: Fast, secure, and SEO-friendly
- **Markdown Support**: Write posts in Markdown with full Hugo features
- **Custom Post Cards**: Reusable post card component for consistent styling
- **Tag System**: Organize content with tags and categories
- **Reading Progress**: Visual progress bar for blog posts
- **Table of Contents**: Auto-generated TOC for long posts

### 🔍 Advanced Search & Filtering
- **Instant Search**: Real-time search as you type
- **Tag Filtering**: Filter posts by tags with interactive chips
- **Smart URL Handling**: Auto-select tags when visiting tag-specific URLs
- **JSON Index**: Efficient search powered by Hugo's JSON output
- **No Results Handling**: Graceful empty states

### 💻 Code Features
- **Syntax Highlighting**: Beautiful code blocks with language detection
- **Copy to Clipboard**: One-click code copying
- **Multiple Themes**: Light and dark syntax highlighting
- **Line Numbers**: Optional line numbering for code blocks
- **Language Labels**: Clear language identification

### 🚀 Performance & SEO
- **Static Generation**: Lightning-fast loading times
- **Optimized CSS**: Organized, minified stylesheets
- **Responsive Images**: Optimized image handling
- **Clean URLs**: SEO-friendly URL structure
- **Meta Tags**: Proper OpenGraph and Twitter Card support

## 🚀 Quick Start

### Prerequisites
- [Hugo Extended](https://gohugo.io/installation/) (v0.100.0+)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/raisingpixels/raisingpixels.github.io.git
   cd raisingpixels.github.io
   ```

2. **Start the development server**
   ```bash
   hugo server -D
   ```

3. **Visit your site**
   Open [http://localhost:1313](http://localhost:1313) in your browser

### Creating Content

1. **Create a new post**
   ```bash
   hugo new posts/my-new-post.md
   ```

2. **Edit the post**
   ```markdown
   ---
   title: "My New Post"
   date: 2024-01-01T12:00:00Z
   tags: ["parenting", "technology"]
   categories: ["blog"]
   summary: "A brief description of your post"
   ---

   Your content here...
   ```

3. **Preview and publish**
   ```bash
   hugo server -D  # Preview with drafts
   hugo            # Build for production
   ```

## 🎨 Customization

### Theme Colors
Edit CSS custom properties in `static/css/style.css`:

```css
:root {
  /* Base theme colors */
  --bg-gradient: linear-gradient(180deg, #ffd89b 0%, #ffc3a0 50%, #ffb7b7 100%);
  --text-primary: #333;
  --text-secondary: #4a5568;
  --card-bg: rgba(255, 255, 255, 0.7);
  --accent-primary: #667eea;
  /* ... more variables */
}
```

### Site Configuration
Update `hugo.yaml`:

```yaml
baseURL: 'https://your-domain.com'
languageCode: 'en-us'
title: 'Your Site Title'
params:
  author: 'Your Name'
  description: 'Your site description'
```

### Navigation & Footer
- Edit `layouts/partials/components/header.html` for navigation
- Edit `layouts/partials/components/footer.html` for footer content

## 🔧 Development

### CSS Organization
The stylesheet is organized into logical sections:
- Variables and base styles
- Layout components
- Search and filtering
- Post and card styles
- Responsive design
- Syntax highlighting

## 📱 Browser Support

- **Modern browsers**: Chrome, Firefox, Safari, Edge (latest versions)
- **Mobile responsive**: iOS Safari, Chrome Mobile
- **Progressive enhancement**: Graceful fallbacks for older browsers
- **Accessibility**: WCAG 2.1 AA compliant

## 🚀 Deployment

### GitHub Pages
1. Push to your GitHub repository
2. Enable GitHub Pages in repository settings
3. Set source to GitHub Actions
4. Hugo will build and deploy automatically

### Other Platforms
- **Netlify**: Connect your repo for automatic deployments
- **Vercel**: Import project for instant deployment
- **Custom server**: Upload the `public/` folder after running `hugo`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*"Raising pixels, one commit at a time"* ✨

<!--
For fellow parent developers:
Remember that perfect code doesn't exist, but good enough code that ships does.
Your kids won't remember if your CSS was pixel-perfect,
but they'll remember the time you spent with them.
Keep building, keep growing!
-->
