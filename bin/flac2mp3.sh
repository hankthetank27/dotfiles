#!/bin/bash

# Script to convert FLAC files to 320kbps MP3 with metadata preservation
# Usage: ./convert_flac_to_mp3.sh /path/to/source/directory [/path/to/output/directory]

if [ $# -eq 0 ]; then
    echo "Usage: $0 <source_directory> [output_directory]"
    echo "Example: $0 /home/user/music"
    echo "Example: $0 /home/user/music /home/user/converted"
    exit 1
fi

SOURCE_DIR="$1"
OUTPUT_BASE_DIR="$2"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

if [ $# -gt 1 ] && [ ! -d "$OUTPUT_BASE_DIR" ]; then
    echo "Error: Output base directory '$OUTPUT_BASE_DIR' does not exist."
    exit 1
fi

if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed or not in PATH."
    exit 1
fi

current_folder=$(basename "$SOURCE_DIR")

if [ $# -gt 1 ]; then
    output_dir="$OUTPUT_BASE_DIR/${current_folder} - mp3"
else
    output_dir="$SOURCE_DIR/${current_folder} - mp3"
fi

echo "Converting FLAC files in directory: $SOURCE_DIR"
echo "Output format: MP3 320kbps with metadata preservation"
echo "Output directory: $output_dir"
echo ""

mkdir -p "$output_dir"

converted_count=0

echo "Copying image files..."
image_count=0
while IFS= read -r -d '' image_file; do
    if [ -n "$image_file" ]; then
        image_name=$(basename "$image_file")
        cp "$image_file" "$output_dir/"
        if [ $? -eq 0 ]; then
            echo "✓ Copied: $image_name"
            ((image_count++))
        else
            echo "✗ Failed to copy: $image_name"
        fi
    fi
done < <(find "$SOURCE_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" \) -print0)

if [ $image_count -gt 0 ]; then
    echo "✓ Copied $image_count image file(s)"
else
    echo "No image files found to copy"
fi
echo ""

while IFS= read -r -d '' flac_file; do
    base_name=$(basename "$flac_file" .flac)
    mp3_file="$output_dir/$base_name.mp3"
    
    if [ -f "$mp3_file" ]; then
        echo "Skipping (MP3 exists): $base_name.flac"
        continue
    fi
    
    echo "Converting: $base_name.flac"
    
    ffmpeg -i "$flac_file" \
           -ab 320k \
           -map_metadata 0 \
           -id3v2_version 3 \
           "$mp3_file" \
           -y -loglevel error < /dev/null
    
    if [ $? -eq 0 ]; then
        echo "✓ Successfully converted: $base_name.mp3"
        ((converted_count++))
    else
        echo "✗ Failed to convert: $base_name.flac"
    fi
    
    echo ""
done < <(find "$SOURCE_DIR" -type f -iname "*.flac" -print0)

echo "Conversion complete!"
echo "Total files converted: $converted_count"
echo "Total image files copied: $image_count"
