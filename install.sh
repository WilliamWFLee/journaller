#!/bin/bash

. "$(dirname $0)/lib/logging"

log_info "Checking dependencies..."
dpkg -s gpg pandoc vim > /dev/null 2>&1

if [[ $? -ne 0 ]]; then
  log_info "Installing missing dependencies..."
  sudo apt install gpg pandoc vim -y --no-install-recommends

  if [[ $? -ne 0 ]]; then
    log_error "Dependencies could not installed. Check output."
    exit 1
  fi
else
  log_info "Dependencies already satisfied"
fi

if [[ ! -f ~/.journalrc ]]; then
  log_info "Generating ~/.journalrc"
  echo 'JOURNAL_DIR=$HOME/journal' > ~/.journalrc
else
  log_info "~/.journalrc already exists"
fi

log_info "Installation done."
