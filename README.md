# rpi-timelapse

Some files I used to take timelapse photos on a Raspberry Pi using the Raspberry Pi camera v2.  

General scheme:
* A cronjob takes a photo every 15 minutes and saves it to /ram, a tmpfs filesystem.  I'm using a tmpfs filesystem to avoid writes to the SD card, because they wear out quickly.
* Another cronjob 10 minutes after that uploads the image to my Google Cloud account.

Originally I also uploaded to imgur, but they downsample the image so the quality isn't that great.  I also eventually had trouble authenticating with Imgur.  I don't know if their API changed, or I was too dumb to figure out how to re-authenticate, or maybe they just got tired of my uploading 100 images/day for a year.  So now instead of uploading to Imgur, I keep the most recent image in a separate Google Cloud Storage bucket that's accessible to the public.

Sorry, I don't have instructions for setting up a Google Cloud Storage account or for installing the Google Cloud Storage client on the Raspberry Pi.

The files in the repo are as follows:
* crontab.txt: my crontab.  You don't need the @reboot line unless you want to use No-IP as a dynamic IP provider.  
* fstab: my /etc/fstab.  Note the tmpfs filesystems.
* gcloud-upload.sh:  a script that uploads every image in the /ram/gcloud directory to Google Cloud Storage using Google's "gsutil" CLI.  It deletes the image files from /ram/gcloud afterward.
* imgur-upload.sh: a script that uploads every image in the /ram/imgur directory to Imgur.  It deletes the image files from /ram/imgur afterward.
* imgurbash2: a script I found somewhere for uploading files to Imgur.  imgur-upload.sh uses this.  As I mentioned above, I no longer use this, so buyer beware.
* snap.sh: a script for taking a photo, saving it to the /ram/imgur directory, and then hard-linking that file in /ram/gcloud.  (You save space by hard-linking rather than copying.)

To save memory/CPU, you don't want the Raspberry Pi to attempt to upload to both Imgur and Google Cloud at same time.  The two upload cronjobs use "flock" to block until a lock file is available.  Whoever has the lock gets to upload.


