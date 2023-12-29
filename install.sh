#!/bin/bash

. "$(dirname $0)/lib/logging"
. "$(dirname $0)/lib/commands/config"

if [[ -f ~/.journalrc ]]; then
  . ~/.journalrc
else
  _journal_config_new
fi

current_dir=$(_journal_config_dir_get)
if [[ -n "${current_dir}"  ]]; then
  log_warn 'JOURNAL_DIR already defined'
  read -p 'Do you want to overwrite JOURNAL_DIR (Y/N)? ' confirm

  if [[ "${confirm,,}" == "y"* ]]; then
    _journal_config_dir_set
  else
    log_info 'JOURNAL_DIR not overwritten'
  fi
else 
  log_info 'Setting JOURNAL_DIR...'
  _journal_config_dir_set
fi

log_info "Checking dependencies..."
type gpg pandoc vim > /dev/null 2>&1

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
