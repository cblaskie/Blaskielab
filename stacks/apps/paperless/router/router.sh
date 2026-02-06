#!/bin/bash
set -e

echo "📥 Paperless Router started"
echo "Watching /drop → /consume"

inotifywait -m -e close_write --format '%f' /drop | while read FILE; do
  SRC="/drop/$FILE"
  EXT="${FILE##*.}"
  BASE="${FILE%.*}"

  EXT_LOWER=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')

  case "$EXT_LOWER" in
    heic)
      echo "🖼 HEIC → PDF: $FILE"
      magick "$SRC" -density 300 "/consume/$BASE.pdf" \
        && rm "$SRC" || mv "$SRC" /failed/
      ;;
    jpg|jpeg|png|tiff)
      echo "🖼 Image → PDF: $FILE"
      magick "$SRC" -density 300 "/consume/$BASE.pdf" \
        && rm "$SRC" || mv "$SRC" /failed/
      ;;
    pdf)
      echo "📄 PDF passthrough: $FILE"
      mv "$SRC" /consume/
      ;;
    *)
      echo "❌ Unsupported: $FILE"
      mv "$SRC" /failed/
      ;;
  esac
done
