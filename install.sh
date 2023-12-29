#!/bin/bash

. "$(dirname $0)/lib/logging"
. "$(dirname $0)/lib/commands/config"

# Dependencies

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

# ~/.journalrc

if [[ -f ~/.journalrc ]]; then
  log_info '~/.journalrc already exists'
  . ~/.journalrc
else
  _journal_config_new
fi

# JOURNAL_DIR

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

# Setting up PATH

log_info 'Checking ~/.bashrc...'

SOURCE_COMMAND='. "$HOME/.journal/bin/journal"'
if [[ "$(cat ~/.bashrc)" == *"${SOURCE_COMMAND}"* ]]; then
  log_info '~/.bashrc already set up'
else
  log_info "Adding journal function to ~/.bashrc"
  echo $SOURCE_COMMAND >> ~/.bashrc
fi

log_info 'Installation done.'
