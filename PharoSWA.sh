#!/usr/bin/env bash
#
# Copyright (C) 2022 art of coding UG
# MIT License
#

set -o nounset
set -o errexit

if [[ $# != 1 ]]; then
    echo "usage: $0 <Project name>"
    exit 1
fi

PROJECT_NAME="$1"
PHARO_DIR="${HOME}/project/Pharo-${PROJECT_NAME}"
PATH=$(pwd):${PATH}

#
# Check requirements
#

for cmd in PharoDev.sh docker; do
    if ! command -v "${cmd}" >/dev/null; then
        echo "$0: We need ${cmd}!"
        exit 1
    fi
done

#
# Install
#

# Pharo, Moose, Moose-Easy
PharoDev.sh -c -n ${PROJECT_NAME} -f Moose -f MooseEasy -f PlantUMLPharoGizmo -f SoftwareAnalyzer

# Container
docker compose build

# TODO Install simple wrapper to execute analysis (jdt2famix, VerveineJ) in Docker container

exit 0
