#!/bin/bash

DEBUG_LOG="./debug.log"  # Path to the debug log file

# Clear old logs
echo > $DEBUG_LOG

while true; do
    # Get the window ID of the currently active window
    ACTIVE_WINDOW_ID=$(xdotool getactivewindow)
    echo "ACTIVE_WINDOW_ID: $ACTIVE_WINDOW_ID" >> "$DEBUG_LOG"

    ACTIVE_WINDOW_NAME=$(xdotool getwindowname $ACTIVE_WINDOW_ID)
    echo "ACTIVE_WINDOW_NAME: $ACTIVE_WINDOW_NAME" >> "$DEBUG_LOG"

    # Get a list of all visible windows
    VISIBLE_WINDOWS=$(xdotool search --onlyvisible --class '')
    echo "VISIBLE_WINDOWS: $VISIBLE_WINDOWS" >> "$DEBUG_LOG"

    WINDOW_IGNORE=`echo $ACTIVE_WINDOW_NAME | grep -i -e save -e open`
    if [[ "$WINDOW_IGNORE" == *"Save"* || "$WINDOW_IGNORE" == *"Open"* ]]; then
	WINDOW_IGNORE="Ignore"
    else
    	echo "Starting iteration..." >> "$DEBUG_LOG"	
    fi

    # Loop through each visible window
    for WINDOW_ID in $VISIBLE_WINDOWS; do
        # Get the window title
        WINDOW_TITLE=$(xdotool getwindowname "$WINDOW_ID")
        echo "WINDOW_ID: $WINDOW_ID, WINDOW_TITLE: $WINDOW_TITLE" >> "$DEBUG_LOG"

        # Check if the window is not the active window and is not already minimized
        if [ "$WINDOW_ID" != "$ACTIVE_WINDOW_ID" ]; then # && [ "$(xdotool windowminimize "$WINDOW_ID" && echo true)" != true ]; then
            # Check if the window title indicates an open dialog window
            if [ "$WINDOW_IGNORE" != "Ignore" ]; then
		# Log that the window is being minimized to debug.log
            	echo "Minimizing window..." >> "$DEBUG_LOG"

		# Minimize the window
                xdotool windowminimize "$WINDOW_ID"
            fi
        fi
    done

    # Log the end of each iteration to debug.log
    echo "End of iteration." >> "$DEBUG_LOG"

    # Activate the active window
    xdotool windowactivate "$ACTIVE_WINDOW_ID"

    # Sleep for a specified duration before repeating the loop
    sleep 3  # Adjust the duration as needed
done
