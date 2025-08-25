# Astro Nested Route HTML Structure Bug Reproduction

This project demonstrates a bug in Astro where nested dynamic routes generate malformed HTML structure.

## Bug Description

When using identical template structures in nested dynamic routes, one route works correctly while the other generates malformed HTML with missing/corrupted tags.

## Structure

```
src/pages/
├── taux/[date].astro           # ✅ Generates correct HTML
└── en/taux/[date].astro        # ❌ Generates malformed HTML
```

## Expected vs Actual Output

### Expected (French route - working):
```html
<!DOCTYPE html><html lang="fr">
<head>
  <title>Taux du 2025-01-01 : 260 DZD - Site Test Français</title>
</head>
<body>
  <!-- content -->
  <footer>...</footer>
</body>
</html>
```

### Actual (English route - broken):
```html
<!DOCTYPE html><html lang="en">
<head>
  <title>Rate for 2025-01-01</title>: 260 DZD - English Test Site
  <!-- missing </head> and <body> -->
  <!-- content -->
  <footer>...</footer>
</header></div></html>
```

## Reproduction Steps

1. Install dependencies:
   ```bash
   npm install
   ```

2. Build the project:
   ```bash
   npm run build
   ```

3. Compare the generated HTML files:
   ```bash
   # Correct HTML structure
   cat dist/taux/2025-01-01.html | head -5
   cat dist/taux/2025-01-01.html | tail -5
   
   # Malformed HTML structure  
   cat dist/en/taux/2025-01-01.html | head -5
   cat dist/en/taux/2025-01-01.html | tail -5
   ```

4. Or run dev server and inspect:
   ```bash
   npm run dev
   # Visit http://localhost:4321/taux/2025-01-01 (working)
   # Visit http://localhost:4321/en/taux/2025-01-01 (broken)
   ```

## Environment

- **Astro Version**: 5.12.8
- **Node Version**: 22.18.0+
- **Output**: static

## Impact

This bug causes:
- Visual inconsistencies between routes
- SEO issues due to malformed HTML
- Accessibility problems from invalid document structure
- Breaking expectations for international sites

## Files

- `src/pages/taux/[date].astro` - Working French route
- `src/pages/en/taux/[date].astro` - Broken English route (identical structure)
- `src/data.json` - Minimal data for `getStaticPaths()`
- `src/components/` - Minimal Header/Footer components

The templates are intentionally identical except for language-specific content to isolate the structural issue.# astro-bug-repro
