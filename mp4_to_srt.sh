#!/bin/bash

# Get all MP4 files in the current directory
mp4_files=$(find . -maxdepth 1 -type f -name "*.MP4")

# Set the total number of MP4 files
total_files=$(echo "$mp4_files" | wc -l)

# Initialize a counter
counter=1

# Loop through each MP4 file
for file in $mp4_files; do
    # Get the filename without extension
    filename=$(basename "$file" .mp4)

    # Display the progress bar
    echo "Processing file $counter of $total_files:"
    echo "$file" | pv -p -s $total_files > /dev/null

    # Run ffmpeg command to add subtitles
    ffmpeg -i "$file" "${filename}.srt"

    # Increment the counter
    counter=$((counter + 1))

    # Move to the next line after the progress bar
    echo
done

