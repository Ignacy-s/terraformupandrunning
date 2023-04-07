#!/bin/bash

# WARNING: SOURCE THIS SCRIPT, DON'T JUST RUN IT.
# example usage: source ./set_aws_credentials.sh

# A script to interactively set the AWS credentials
# 2023-04-06 ~Ignacy

# Saves the hassle of finding the required one-liner in project's
# journal.
# Doesn't leak the credentials to the history.

usage(){
  # Print script's usage.
  cat <<EOF
   Usage:
     source ${0}
   or
     . ${0}
EOF
}

main() {
  # Print out some help if script is run with arguments.
  if [[ $# -gt 0 ]]
  then
    if [[ "${1}" != "-h" ]] && [[ "${1}" != "--help" ]]
    then
      echo \
        "This script doesn't take in arguments, it works interactively."
    fi
    usage
    return 1
  fi

  if [[ "$0" == "$BASH_SOURCE" ]]
  then
    echo "Script was run instead of being sourced."
    echo \
      "Remember to *source* this script instead of just running it."
    usage
    return 1
  fi

  # Get the credentials from user without printing them on the screen.
  read -rs -p "Enter AWS Access Key ID: " aws_access_key_id
  echo
  read -rs -p "Enter AWS Secret Access Key: " aws_secret_access_key
  echo

  export AWS_ACCESS_KEY_ID="$aws_access_key_id"
  export AWS_SECRET_ACCESS_KEY="$aws_secret_access_key"

  unset aws_access_key_id aws_secret_access_key
}

main "${@}"

