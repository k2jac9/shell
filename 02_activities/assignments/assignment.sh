#!/bin/bash
set -x

############################################
# DSI CONSULTING INC. Project setup script #
############################################
# This script creates analysis and output directories for a new project. 
# It also creates a README file with the project name and a brief description of the project.
# Then it unzips the raw data provided by the client.

# Define directories as variables for easier maintenance
RAW_DATA_DIR="./data/raw"
PROCESSED_DATA_DIR="./data/processed"
SERVER_LOG_DIR="$PROCESSED_DATA_DIR/server_logs"
USER_LOG_DIR="$PROCESSED_DATA_DIR/user_logs"
EVENT_LOG_DIR="$PROCESSED_DATA_DIR/event_logs"

# Create required directories
mkdir -p analysis output

# Create README file
touch README.md
echo "# Project Name: DSI Consulting Inc." > README.md

# Create main.py
touch analysis/main.py

# Download client data
echo "Downloading raw data..."
curl -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
unzip rawdata.zip

###########################################
# Complete assignment here

# 1. Create a directory named data
echo "Creating data directory..."
mkdir -p data

# 2. Move the ./rawdata directory to ./data/raw
echo "Moving raw data to $RAW_DATA_DIR..."
mv ./rawdata "$RAW_DATA_DIR"

# 3. List the contents of the ./data/raw directory
echo "Listing contents of $RAW_DATA_DIR..."
ls "$RAW_DATA_DIR"

# 4. In ./data/processed, create the following directories: server_logs, user_logs, and event_logs
echo "Creating subdirectories for processed data..."
mkdir -p "$SERVER_LOG_DIR" "$USER_LOG_DIR" "$EVENT_LOG_DIR"

# 5. Copy all server log files (files with "server" in the name AND a .log extension) from ./data/raw to ./data/processed/server_logs
echo "Copying server log files..."
cp "$RAW_DATA_DIR"/server*.log "$SERVER_LOG_DIR"

# 6. Repeat the above step for user logs and event logs
echo "Copying user log files..."
cp "$RAW_DATA_DIR"/user*.log "$USER_LOG_DIR"

echo "Copying event log files..."
cp "$RAW_DATA_DIR"/event*.log "$EVENT_LOG_DIR"

# 7. For user privacy, remove all files containing IP addresses (files with "ipaddr" in the filename) from ./data/raw and ./data/processed/user_logs
echo "Removing files containing IP addresses..."
rm -f "$RAW_DATA_DIR"/*ipaddr* "$USER_LOG_DIR"/*ipaddr*

# 8. Create a file named ./data/inventory.txt that lists all the files in the subfolders of ./data/processed
echo "Creating inventory file..."
mkdir -p "$PROCESSED_DATA_DIR"  # Ensure the directory exists
find "$PROCESSED_DATA_DIR" -type f > "data/inventory.txt"

########################################### 

echo "Project setup is complete!"
