#!/bin/bash 

export PATH=$PATH:/home/pi/google-cloud-sdk/bin 

# defines IMAGES_BUCKET and RECENT_BUCKET
. /home/pi/vars

mkdir -p /ram/gcloud-tmp
rm -f /ram/last
for x in $(ls /ram/gcloud/*|head -5); do
	rm -r /ram/gcloud-tmp/*
	LAST="${x}"
        cp ${x} /ram/last
        TMPDIR=/ram/gcloud-tmp gsutil cp "${x}" gs://${IMAGES_BUCKET} && rm "${x}"
done

if [[ -f /ram/last ]]; then
    TMPDIR=/ram/gcloud-tmp gsutil \
	-h "Content-Type:image/jpeg" \
	-h "Cache-Control:public, max-age=900" \
    	cp /ram/last gs://${RECENT_BUCKET}/recent.jpg
fi
