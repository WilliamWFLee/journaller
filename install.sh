#!/bin/bash

. "$(dirname $0)/lib/logging"
. "$(dirname $0)/lib/commands/config"

_journal_config_new
_journal_config_dir_set

log_info "Checking dependencies..."
dpkg -s gpg pandoc vim > /dev/null 2>&1

if [[ $? -ne 0 ]]; then
  log_info "Installing missing dependencies using apt..."
  sudo apt install gpg pandoc vim -y --no-install-recommends

  if [[ $? -ne 0 ]]; then
    log_error "Dependencies could not be installed; check output"
    exit 1
  fi
else
  log_info "Dependencies already satisfied"
fi

log_info "Installation done."
