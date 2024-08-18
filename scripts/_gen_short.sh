#!/bin/sh

# Generate 4 random bytes from /dev/urandom and convert to hexadecimal
HEX_STRING=$(head -c4 /dev/urandom | xxd -p | tr -d '\n')

# Ensure the result is exactly 8 characters
HEX_STRING=$(echo $HEX_STRING | cut -c1-8)

# Output the 8-character hexadecimal string
echo $HEX_STRING
