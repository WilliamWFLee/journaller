#!/bin/bash

mkdir -p ~/.journaller
cd ~/.journaller

git init
git pull --depth 1 https://github.com/WilliamWFLee/journaller.git

bin/setup
