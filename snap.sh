#!/bin/bash

mkdir -p /ram/imgur /ram/gcloud

DATE=$(date +%Y-%m-%d_%H%M)

raspistill --width 2464 --height 3280 --rotation 270 -o /ram/imgur/$DATE.jpg && ln /ram/imgur/$DATE.jpg /ram/gcloud/$DATE.jpg
