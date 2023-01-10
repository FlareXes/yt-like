#!/bin/bash

# Print text in colored format
log_echo() {
  # $1 is the text to print
  # $2 is the color of the text

  if [ "$2" == "red" ]; then
    # Print the text in red
    echo -e "\033[1;31m$1\033[0m" >&2
    exit 1

  elif [ "$2" == "green" ]; then
    # Print the text in green
    echo -e "\033[1;32m$1\033[0m"

  else
    # If the color is not recognized, print the text in the default color
    echo "$1"
  fi
}

# Make the bin/like script executable
if ! chmod +x ./bin/like; then
  log_echo "Error: Failed to make the ./bin/like executable" "red"
fi

# Create the /opt/yt-like/ directory if it does not exist
if ! [ -d /opt/yt-like/ ]; then
  if ! sudo mkdir -p /opt/yt-like/; then
    log_echo "Error: Failed to create the /opt/yt-like/ directory" "red"
  fi
fi

# Create the /usr/share/licenses/yt-like/ directory if it does not exist
if ! [ -d /usr/share/licenses/yt-like/ ]; then
  if ! sudo mkdir -p /usr/share/licenses/yt-like/; then
    log_echo "Error: Failed to create the /usr/share/licenses/yt-like/ directory" "red"
  fi
fi

# Copy the necessary files and directories to /opt/yt-like/
if ! sudo cp ./like.py ./README.md ./requirements.txt /opt/yt-like/; then
  log_echo "Error: Failed to copy files to /opt/yt-like/" "red"
fi

# Copy the LICENCE to /usr/share/licenses/yt-like/
if ! sudo cp ./LICENCE /usr/share/licenses/yt-like/; then
  log_echo "Error: Failed to copy LICENCE to /usr/share/licenses/yt-like/" "red"
fi

# Copy the like script to /usr/local/bin/like
if ! sudo cp ./bin/like /usr/local/bin/like; then
  log_echo "Error: Failed to copy the ./bin/like script to /usr/local/bin/like" "red"
fi

# Change /opt/yt-like/ directory ownership to current user
if ! sudo chown -R "$(whoami):$(whoami)" /opt/yt-like/; then
  log_echo "Error: Failed to change ownership of /opt/yt-like/" "red"
fi

# Create python virtual environment to install dependencies
if ! python3 -m venv /opt/yt-like/venv; then
  log_echo "Error: Failed to create virtual environment of /opt/yt-like/" "red"
fi

# Activate python virtual environment and install dependencies
source /opt/yt-like/venv/bin/activate
if [ -z "$VIRTUAL_ENV" ]; then
  log_echo "Error: Failed to activate virtual environment" "red"
else
  if ! pip install -r /opt/yt-like/requirements.txt; then
    log_echo "Error: Failed to install the dependencies" "red"
  fi
fi

# Deactivate python virtual environment
deactivate

log_echo "Now you can delete cloned repository" "green"
