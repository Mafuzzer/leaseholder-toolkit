#!/bin/sh
# Build The Leaseholder's Toolkit from source.
#   deps: pandoc, weasyprint  (brew install pandoc weasyprint)
set -e
cd "$(dirname "$0")"

# Print edition
pandoc src/toolkit.md -s --toc --toc-depth=2 --css=src/toolkit.css -o .build.html
weasyprint .build.html Leaseholders_Toolkit.pdf
rm -f .build.html

# Web edition — self-contained, responsive, light/dark
pandoc src/toolkit.md -s --toc --toc-depth=3 --embed-resources --standalone \
  --css=src/toolkit-web.css --metadata title="The Leaseholder's Toolkit" \
  -o toolkit.html

echo "built: $(pdfinfo Leaseholders_Toolkit.pdf | awk '/^Pages/{print $2}') page PDF + toolkit.html"
