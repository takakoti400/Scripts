#!/bin/bash
ffmpeg -i "$1" "${1%.${1##*.}}.$2"
