#!/bin/bash

mkdir -p ~/.journaller
cd ~/.journaller

echo 'Downloading files from Git repository...'
git init -q

if ! ( \
  git fetch -q --depth 1 https://github.com/WilliamWFLee/journaller.git > /dev/null \
); then
  echo 'Failed to fetch files from Git repository' > /dev/stderr
  exit 1
fi
git reset -q --hard FETCH_HEAD
git clean -q -dfx

echo 'Running setup script...'
bin/setup
