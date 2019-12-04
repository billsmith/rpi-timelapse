#!/bin/bash

echo remove images from Imgur album
for x in $(./list); do
	./remove "${x}"
done

# only keep the newest 10 images on disk, because we don't want it to fill up
echo "Remove all but the newest 10 images on disk"
(cd /ram/imgur; ls -1t /ram/imgur | tail -n +10 | xargs -r rm)

for x in $(ls -1 /ram/imgur/*|head -5); do
	BASE=$(basename "${x}")
	WHEN=${BASE%.jpg}
	YYYYMMDD=$(echo $WHEN|cut -d _ -f 1)
	HHMM=$(echo $WHEN|cut -d _ -f 2|sed "s/^\(..\)/\1:/")
	DATE=$(date -d "$YYYYMMDD $HHMM")
	echo "Upload ${x} to imgur"
	./imgurbash2 --description "${DATE}" --title "${BASE}" "/ram/imgur/${x}" && rm "/ram/imgur/${x}"
done
