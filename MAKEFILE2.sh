#!/bin/bash

source build/SETTINGS

BUILD() {
    DIRECTORY=$1

    # Check if the directory exists
    if [ ! -d "$DIRECTORY" ]; then
        echo "Directory $DIRECTORY does not exist."
        exit 1
    fi

    # Make all non-dot files executable
    for file in "$DIRECTORY"/*; do
        if [ -f "$file" ] && [[ "$(basename "$file")" != .* ]]; then
            chmod +x "$file"
        fi
    done

    # Loop through all files in the directory
    for file in "$DIRECTORY"/*; do
        # Check if the file is executable
        if [ -x "$file" ] && [ -f "$file" ]; then
            echo "Running $file..."
            # Execute the file
            "$file"
            # Check the exit status of the command
            if [ $? -ne 0 ]; then
                echo "Error: $file exited with a non-zero status."
            else
                echo "$file ran successfully."
            fi
        fi
    done
}

# Call the BUILD function, to exclude any file from being executed simply add a dot in it's name (make it hidden)
BUILD $SYS
BUILD $USR
BUILD $ENV
BUILD $APPEARANCE
BUILD $PLUGINS
