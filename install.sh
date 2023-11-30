#!/bin/bash

. "$(dirname $0)/lib/logging"

echo -e "$INFO Checking dependencies..."

type 'gpg' > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
  echo -e "$INFO Installing gpg"
  sudo apt install gpg -y --no-install-recommends
else
  echo -e "$INFO gpg already installed"
fi

type 'pandoc' > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
  echo -e "$INFO Installing pandoc"
  sudo apt install pandoc -y --no-install-recommends
else
  echo -e "$INFO pandoc already installed"
fi

if [[ ! -f ~/.journalrc ]]; then
  echo -e "$INFO Generating ~/.journalrc"
  echo 'JOURNAL_DIR=$HOME/journal' > ~/.journalrc
else
  echo -e "$INFO Found ~/.journalrc"
fi

echo -e "$INFO Installation done."
