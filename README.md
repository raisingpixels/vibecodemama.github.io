# raisingpixels website

## ✨ About

A minimal, aesthetic personal webpage. Built with a lofi/vaporwave aesthetic inspired by those golden hour coding sessions when the little one finally naps.

## 🎨 Features

- **Lofi Aesthetic**: Sunset gradient backgrounds with glassmorphism effects
- **Responsive Design**: Looks great on all devices
- **Smart Theme System**:
  - Respects system preference by default
  - Manual toggle: System → Light → Dark → System
  - Uses CSS media queries for true responsiveness
- **Auto-Updating Portfolio**: GitHub Action automatically fetches and displays latest repositories
- **Clean Typography**: JetBrains Mono + Crimson Text pairing
- **Minimal Social Links**: Icon-based GitHub and X/Twitter links

## 🚀 Quick Start

1. **Clone & Setup**
   Click "Use this template" to grab a copy for yourself!

2. **Add Your Profile Image**
   ```bash
   # Add your profile image as profile.jpg in the root directory
   cp your-photo.jpg profile.jpg
   ```
   
3. **Customize Content**
   - Update social links in `index.html`
   - Modify tagline and username styling
   - Adjust color scheme in CSS variables

4. **Deploy**
   - Push to GitHub
   - Enable GitHub Actions
   - Deploy to GitHub Pages, Vercel, or your preferred host

## ⚙️ GitHub Action

The site automatically updates your repository showcase daily using a GitHub Action:

- Runs daily at midnight UTC
- Fetches your latest public repositories
- Filters out forks and archived repos
- Sorts by stars and recent activity
- Shows top 6 repositories

**Required Setup:**

- No additional secrets needed (uses `GITHUB_TOKEN`)
- Action runs automatically on push and daily
- Can be triggered manually from Actions tab

## 🎯 Customization

### Color Scheme

```css
:root {
  --bg-gradient: /* Your sunset gradient */
  --text-primary: /* Main text color */
  --link-color: /* Accent color */
  --accent: /* Secondary accent */
}
```

### Repository Display

- Edit `loadRepositories()` function to change filtering logic
- Modify `.slice(0, 6)` to show more/fewer repos
- Adjust sorting criteria in the sort function

### Typography

- Fonts: JetBrains Mono (code) + Crimson Text (body)
- Easy to swap in CSS imports

## 🛠️ Tech Stack

- **Vanilla HTML/CSS/JavaScript** - No frameworks, fast loading
- **Font Awesome** - Social media icons
- **Google Fonts** - Typography
- **GitHub GraphQL API** - Repository data
- **CSS Grid/Flexbox** - Responsive layouts
- **CSS Variables** - Easy theming

## 📱 Browser Support

- Modern browsers (Chrome, Firefox, Safari, Edge)
- Responsive design works on all screen sizes
- Graceful fallbacks for older browsers
- Progressive enhancement approach

## 🌙 Theme System Details

The theme system is designed to be respectful and smart:

1. **Default**: Respects user’s system preference (`prefers-color-scheme`)
2. **Light Override**: Force light mode regardless of system
3. **Dark Override**: Force dark mode regardless of system
4. **Back to System**: Removes override, returns to system preference

Icons indicate current state:

- ☀️ = Following system preference
- 🌙 = Light mode override
- 💻 = Dark mode override

## 📄 License

MIT License - feel free to use as inspiration for your own site!

-----

*“raising pixels, one commit at a time”* ✨

<!-- 
Secret message for fellow parent coders:
You're doing great. Your kids don't care if your code is perfect.
They care that you're there and trying your best.
Keep building!
-->
