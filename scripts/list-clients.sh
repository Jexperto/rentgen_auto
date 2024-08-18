#!/bin/sh

# Base directory where clients' information is stored
base_dir="/opt/xray/config/clients"

# Check if the base directory exists
if [[ ! -d "$base_dir" ]]; then
  echo "Directory $base_dir does not exist."
  return
fi

# Function to list all clients

echo "Listing all clients:"
echo "--------------------"

# Iterate over each directory under config/clients
for short_id_dir in "$base_dir"/*/; do
  # Check if it's a directory
  if [[ -d "$short_id_dir" ]]; then
    short_id=$(basename "$short_id_dir")

    # Paths to uuid and nickname files
    uuid_file="$short_id_dir/uuid"
    nickname_file="$short_id_dir/nickname"

    # Initialize variables
    uuid=""
    nickname=""

    # Read the uuid file if it exists
    if [[ -f "$uuid_file" ]]; then
      uuid=$(cat "$uuid_file")
    fi

    # Read the nickname file if it exists
    if [[ -f "$nickname_file" ]]; then
      nickname=$(cat "$nickname_file")
    fi

    # Print client information
    echo "Short ID: $short_id"
    echo "UUID: $uuid"
    echo "Nickname: $nickname"
    echo "--------------------"
  fi
done
