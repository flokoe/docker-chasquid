#!/bin/bash
#
# Script is used to define startup options for chasquid
#

set -e


CHASQUID_FLAGS=""

# Check if mandatory environment variables exist
[ -z "$SMTP_USER" ] && echo "SMTP_USER is not set" && exit 1
[ -z "$SMTP_USER_PASS" ] && echo "SMTP_USER_PASS is not set" && exit 1

# Create User
# Needs to check if user exists
/usr/local/bin/chasquid-util user-add "$SMTP_USER" --password="$SMTP_USER_PASS"

# Start chasquid
/usr/local/bin/chasquid "$CHASQUID_FLAGS"

