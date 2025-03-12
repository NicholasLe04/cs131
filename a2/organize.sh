#!/bin/bash

# Check if the user provided a directory argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIR=$(realpath "$1")
MODE="$2"

# Check if the provided directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' does not exist."
    exit 1
fi

# Check if the mode is valid
if [ "$MODE" != "ext" ] && [ "$MODE" != "size" ] && [ "$MODE" != "date" ]; then
    echo "Error: Invalid mode. Choose 'ext', 'size', or 'date'."
    exit 1
fi


image_extensions=("jpg" "jpeg" "png" "gif" "bmp" "tiff" "ico" "webp" "heic" "heif")
video_extensions=("mp4" "avi" "mov")
audio_extensions=("mp3" "wav" "ogg" "m4a" "flac" "aac")
document_extensions=("doc" "docx" "pdf" "txt" "rtf" "odt" "ppt" "pptx" "xls" "xlsx" "csv" "json" "xml" "yaml" "yml" "ini" "cfg" "conf" "log" "md")
code_extensions=("py" "js" "ts" "java" "cpp" "h" "c" "php" "html" "css" "scss" "sass" "less" "sql" "sh" "bash" "zsh")
archive_extensions=("zip" "tar" "gz" "rar" "7z" "iso" "dmg" "pkg" "deb" "msi" "dmg")

get_category_by_extension() {
    local ext="$1"
    if [[ " ${image_extensions[@]} " =~ " $ext " ]]; then
        echo "images"
    elif [[ " ${video_extensions[@]} " =~ " $ext " ]]; then
        echo "videos"
    elif [[ " ${audio_extensions[@]} " =~ " $ext " ]]; then
        echo "audios"
    elif [[ " ${document_extensions[@]} " =~ " $ext " ]]; then
        echo "documents"
    elif [[ " ${code_extensions[@]} " =~ " $ext " ]]; then
        echo "code"
    elif [[ " ${archive_extensions[@]} " =~ " $ext " ]]; then
        echo "archives"
    else
        echo "misc"
    fi
}

get_category_by_date() {
    local file_timestamp="$1"
    local diff_seconds=$(($(date +%s) - file_timestamp))

    if [ "$diff_seconds" -lt 86400 ]; then
        echo "today"
    elif [ "$diff_seconds" -lt 604800 ]; then
        echo "this_week"
    elif [ "$diff_seconds" -lt 2592000 ]; then
        echo "this_month"
    elif [ "$diff_seconds" -lt 31536000 ]; then
        echo "this_year"
    else
        echo "over_a_year_ago"
    fi
}

get_category_by_size() {
    local size_in_bytes="$1"
    
    # small: < 1MB, medium: 1MB-10MB, large: 10MB-100MB, huge: > 100MB
    if [ "$size_in_bytes" -lt 1024 ]; then
        echo "tiny"
    elif [ "$size_in_bytes" -lt 1048576 ]; then
        echo "small"
    elif [ "$size_in_bytes" -lt 10485760 ]; then
        echo "medium"
    elif [ "$size_in_bytes" -lt 104857600 ]; then
        echo "large"
    else
        echo "huge"
    fi
}

# Organize files
for FILE in "$DIR"/*; do
    if [ ! -f "$FILE" ]; then
        continue
    fi

    if [ "$FILE" == "$(realpath "$0")" ]; then
        echo "Skipping self-organizing script."
        continue
    fi

    # Get the category based on the mode
    if [[ "$MODE" == "ext" ]]; then
        if [[ "$FILE" == *.* ]]; then
            EXT="${FILE##*.}"
            EXT=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')
        else
            EXT="unknown"
        fi
        CATEGORY=$(get_category_by_extension "$EXT")
    elif [[ "$MODE" == "size" ]]; then
        SIZE=$(stat -c %s "$FILE")
        CATEGORY=$(get_category_by_size "$SIZE")
    elif [[ "$MODE" == "date" ]]; then
        TIMESTAMP=$(stat -c %Y "$FILE")
        CATEGORY=$(get_category_by_date "$TIMESTAMP")
    fi

    # Move the file to the target directory
    echo "$FILE -> $CATEGORY"
    TARGET_DIR="$DIR/$CATEGORY"
    mkdir -p "$TARGET_DIR"
    mv "$FILE" "$TARGET_DIR"
done

echo "Files organized successfully."