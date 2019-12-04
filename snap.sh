#!/bin/bash

mkdir -p /ram/imgur /ram/gcloud

DATE=$(date +%Y-%m-%d_%H%M)

FILE="/ram/gcloud/$DATE.jpg"
if ! raspistill --width 2464 --height 3280 --rotation 270 -o ${FILE}; then
    # avoid empty or partial image files
    rm "${FILE}"
fi
