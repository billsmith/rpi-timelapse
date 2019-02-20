#!/bin/bash

export PATH=$PATH:/home/pi/google-cloud-sdk/bin 

mkdir -p /ram/gcloud-tmp

for x in $(ls /ram/gcloud/*); do
	rm -r /ram/gcloud-tmp/*
        TMPDIR=/ram/gcloud-tmp gsutil cp "${x}" gs://block71-images && rm "${x}"
done
