# #!/bin/bash
#
# # Usage: ./copy_with_filemarkers.sh <directory>
# # Example: ./copy_with_filemarkers.sh src
# #          ./copy_with_filemarkers.sh .
#
# if [ -z "$1" ]; then
#   echo "Usage: $0 <directory>"
#   exit 1
# fi
#
# DIR="$1"
#
# # Check clipboard tool
# if command -v pbcopy &> /dev/null; then
#   CLIP_CMD="pbcopy"
# elif command -v xclip &> /dev/null; then
#   CLIP_CMD="xclip -selection clipboard"
# elif command -v xsel &> /dev/null; then
#   CLIP_CMD="xsel --clipboard --input"
# else
#   echo "No clipboard utility found (pbcopy, xclip or xsel). Install one or modify script."
#   exit 1
# fi
#
# find "$DIR" -type f -print0 | xargs -0 -I {} bash -c '
#   f="{}"
#   # Strip directory prefix for cleaner file headers:
#   # Remove trailing slash from DIR if any, to prevent mismatches
#   base_dir=$(realpath '"$DIR"')
#   file_path=$(realpath "$f")
#   relative_path=${file_path#$base_dir/}
#
#   echo "// start of $relative_path"
#   cat "$f"
#   echo "// end of $relative_path"
# ' | eval $CLIP_CMD
#
# echo "All files from '$DIR' copied to clipboard with file markers."


############################################################

#!/bin/bash

# Usage: ./copy_with_filemarkers.sh <directory>

if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

DIR="$(realpath "$1")"

# Check clipboard tool
if command -v pbcopy &> /dev/null; then
  CLIP_CMD="pbcopy"
elif command -v xclip &> /dev/null; then
  CLIP_CMD="xclip -selection clipboard"
elif command -v xsel &> /dev/null; then
  CLIP_CMD="xsel --clipboard --input"
else
  echo "No clipboard utility found (pbcopy, xclip or xsel)."
  exit 1
fi

export BASE_DIR="$DIR"

find "$DIR" -type f \
  -not -path "*/node_modules/*" \
  -not -path "*/.git/*" \
  -not -path "*/dist/*" \
  -not -path "*/.next/*" \
  -print0 | xargs -0 -I {} bash -c '
  f="$1"
  relative_path="${f#$BASE_DIR/}"
  echo "// start of $relative_path"
  cat "$f"
  echo ""
  echo "// end of $relative_path"
' _ {} | eval "$CLIP_CMD"

echo "All files from '$DIR' copied to clipboard with file markers."

