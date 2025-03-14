#!/bin/bash

# Check if a folder path is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <folder_path>"
    exit 1
fi

# Assign the folder path to a variable
FOLDER="$1"

# Check if the folder exists
if [ ! -d "$FOLDER" ]; then
    echo "Error: Folder '$FOLDER' does not exist."
    exit 1
fi

# Function to convert CRLF to LF
convert_file() {
    local file="$1"
    # Check if the file is a regular file and not binary
    if [ -f "$file" ] && file "$file" | grep -q "text"; then
        echo "Converting: $file"
        # Try dos2unix if available
        if command -v dos2unix >/dev/null 2>&1; then
            dos2unix "$file" 2>/dev/null
        else
            # Fallback to sed if dos2unix is not installed
            sed -i 's/\r$//' "$file"
        fi
    fi
}

# Export the function so it can be used with find
export -f convert_file

# Find all files in the folder and process them
find "$FOLDER" -type f -exec bash -c 'convert_file "$0"' {} \;

echo "Conversion complete!"
