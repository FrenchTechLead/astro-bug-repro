#!/bin/bash

echo "=== Astro Nested Route HTML Structure Bug Test ==="
echo ""

# Build the project
echo "Building project..."
npm run build

echo ""
echo "=== FRENCH ROUTE (WORKING) ==="
echo "File: dist/taux/2025-01-01/index.html"
echo "First 100 characters:"
head -c 100 dist/taux/2025-01-01/index.html
echo ""
echo "Last 100 characters:"
tail -c 100 dist/taux/2025-01-01/index.html
echo ""

echo "=== ENGLISH ROUTE (BROKEN) ==="
echo "File: dist/en/taux/2025-01-01/index.html"
echo "First 100 characters:"
head -c 100 dist/en/taux/2025-01-01/index.html
echo ""
echo "Last 100 characters:"
tail -c 100 dist/en/taux/2025-01-01/index.html
echo ""

echo "=== STRUCTURAL ANALYSIS ==="
echo "French route structure:"
echo "- Has proper </head> and <body> tags: $(grep -c '</head>' dist/taux/2025-01-01/index.html) </head>, $(grep -c '<body>' dist/taux/2025-01-01/index.html) <body>"
echo "- Ends with: $(tail -c 20 dist/taux/2025-01-01/index.html)"

echo ""
echo "English route structure:"
echo "- Has proper </head> and <body> tags: $(grep -c '</head>' dist/en/taux/2025-01-01/index.html) </head>, $(grep -c '<body>' dist/en/taux/2025-01-01/index.html) <body>"  
echo "- Ends with: $(tail -c 20 dist/en/taux/2025-01-01/index.html)"

echo ""
echo "=== BUG CONFIRMATION ==="
if [ $(grep -c '<body>' dist/taux/2025-01-01/index.html) -eq 1 ] && [ $(grep -c '<body>' dist/en/taux/2025-01-01/index.html) -eq 0 ]; then
    echo "✅ BUG REPRODUCED: French route has <body> tag, English route is missing it"
else
    echo "❌ Bug not reproduced in this environment"
fi

echo ""
echo "Environment:"
echo "- Astro: $(npm list astro --depth=0 | grep astro)"
echo "- Node: $(node --version)"
echo "- System: $(uname -s) $(uname -m)"