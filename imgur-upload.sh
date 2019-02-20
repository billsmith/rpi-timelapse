#!/bin/bash

for x in $(./list); do
	./remove "${x}"
done

for x in $(ls /ram/imgur/*); do
	BASE=$(basename "${x}")
	WHEN=${BASE%.jpg}
	YYYYMMDD=$(echo $WHEN|cut -d _ -f 1)
	HHMM=$(echo $WHEN|cut -d _ -f 2|sed "s/^\(..\)/\1:/")
	DATE=$(date -d "$YYYYMMDD $HHMM")
	./imgurbash2 --description "${DATE}" --title "${BASE}" "${x}" && rm "${x}"
done
