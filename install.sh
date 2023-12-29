#!/bin/bash

mkdir -p ~/.journaller
cd ~/.journaller

echo 'Downloading files from Git repository...'
git init -q
git pull -q --depth 1 https://github.com/WilliamWFLee/journaller.git > /dev/null

echo 'Running setup script...'
bin/setup
