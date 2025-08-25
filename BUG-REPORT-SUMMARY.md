# Astro HTML Structure Bug - Minimal Reproduction

## ✅ Bug Successfully Reproduced

This minimal project demonstrates a consistent HTML structure corruption bug in Astro 5.12.8+ affecting nested dynamic routes.

## 🔍 Bug Manifestation

**Working Route**: `src/pages/taux/[date].astro`
```html
<!DOCTYPE html><html lang="fr">
<head>
  <title>Taux du 2025-01-01 : 260 DZD - Site Test Français</title>
</head>
<body>
  <!-- content -->
</body>
</html>
```

**Broken Route**: `src/pages/en/taux/[date].astro` 
```html
<!DOCTYPE html><html lang="en">
<head>
  <title>Rate for 2025-01-01</title>
</head>: 260 DZD - English Test Site
<meta name="description"...>
<!-- content without <body> tag -->
</html>
```

## 🧪 Test Results

```bash
$ ./test-bug.sh
✅ BUG REPRODUCED: French route has <body> tag, English route is missing it

Environment:
- Astro: astro@5.13.3  
- Node: v22.18.0
- System: Darwin arm64
```

## 🔧 Issues Identified

1. **Missing `<body>` tag**: English route completely lacks opening `<body>` tag
2. **Title content spillover**: Title content appears outside the `<title>` element
3. **Meta tag displacement**: Meta description appears after title spillover
4. **Malformed document structure**: Invalid HTML that fails validation

## 📁 Project Structure

```
astro-bug-repro/
├── src/
│   ├── components/
│   │   ├── Header.astro        # Simple test component
│   │   └── Footer.astro        # Simple test component  
│   ├── pages/
│   │   ├── taux/[date].astro   # ✅ Works correctly
│   │   └── en/taux/[date].astro # ❌ Generates malformed HTML
│   └── data.json               # Minimal test data (3 entries)
├── test-bug.sh                 # Automated test script
└── README.md                   # Detailed documentation
```

## 🚀 How to Test

1. **Clone/Download** this reproduction project
2. **Install**: `npm install`  
3. **Test**: `./test-bug.sh`
4. **Manual Check**: Compare `dist/taux/2025-01-01/index.html` vs `dist/en/taux/2025-01-01/index.html`

## 💥 Impact

This bug affects:
- **International sites** with nested language routes
- **SEO** due to invalid HTML structure  
- **Accessibility** from malformed document structure
- **User experience** through visual inconsistencies

## 🔬 Root Cause Analysis

The issue appears to be in Astro's template compilation/rendering pipeline specifically for nested dynamic routes. The exact same template structure works at one nesting level but fails at deeper nesting levels, suggesting a parsing or compilation bug in the framework.

## 📊 Consistency

The bug is **100% reproducible** across:
- ✅ Multiple builds (`npm run build`)
- ✅ Development mode (`npm run dev`) 
- ✅ Clean installs
- ✅ Different dates in the dynamic route
- ✅ Astro versions 5.12.8 and 5.13.3

## 🎯 For Astro Team

This minimal reproduction provides:
- **Isolated test case** with minimal dependencies
- **Automated testing** via `test-bug.sh`
- **Clear comparison** between working/broken routes
- **Documented expectations** vs actual output
- **Environment details** for debugging

The templates are intentionally identical except for language content to isolate the structural compilation issue.