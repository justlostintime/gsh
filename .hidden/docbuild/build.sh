#!/bin/bash
# Rebuild the manual docx and pdf from manual.md (the copy of the wiki Documentation.md).
# The current docx gives the title page, table of contents, styles, header and footer;
# everything from Introduction on is made again from the markdown, then LibreOffice
# updates the table of contents and writes the docx and the pdf.
#
# usage: .hidden/docbuild/build.sh [manual.md]
# needs: python3, LibreOffice (soffice), python3-uno for /usr/bin/python3, zip
set -e
here=$(cd "$(dirname "$0")" && pwd)
repo=$(cd "$here/../.." && pwd)
md=${1:-$repo/manual.md}
docx=$repo/.hidden/Documentation/GambasShell-gsh-1.8.docx
pdf=$repo/.hidden/docs/GambasShell-gsh-1.8.pdf

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
python3 -c "import sys,zipfile; zipfile.ZipFile(sys.argv[1]).extractall(sys.argv[2])" "$docx" "$work/unpacked"
python3 "$here/md2docx.py" "$md" "$work/unpacked"
(cd "$work/unpacked" && zip -qXrD "$work/body.docx" .)
/usr/bin/python3 "$here/export.py" "$work/body.docx" "$work/out.docx" "$work/out.pdf"
cp "$work/out.docx" "$docx"
cp "$work/out.pdf" "$pdf"
echo "pages: $(pdfinfo "$pdf" 2>/dev/null | awk '/^Pages/ {print $2}')"
