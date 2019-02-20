# rpi-timelapse

Some files I used to take timelapse photos on a Raspberry Pi using the Raspberry Pi camera v2.

General scheme:
* A cronjob takes a photo every 15 minutes and saves it to /ram, a tmpfs filesystem.  I'm using a tmpfs filesystem to avoid writes to the SD card, because they wear out quickly.
* Another cronjob, 5 minutes later, uploads the image to Imgur.
* Another cronjob 5 minutes after that uploads the image to my Google Cloud account.

Sorry, I don't have instructions for setting up a Google Cloud Storage account or for installing the Google Cloud Storage client on the Raspberry Pi.

The files in the repo are as follows:
* crontab.txt: my crontab.  You don't need the @reboot line unless you want to use No-IP as a dynamic IP provider.  
* fstab: my /etc/fstab.  Note the tmpfs filesystems.
* gcloud-upload.sh:  a script that uploads every image in the /ram/gcloud directory to Google Cloud Storage using Google's "gsutil" CLI.  It deletes the image files from /ram/gcloud afterward.
* imgur-upload.sh: a script that uploads every image in the /ram/imgur directory to Imgur.  It deletes the image files from /ram/imgur afterward.
* imgurbash2: a script I found somewhere for uploading files to Imgur.  imgur-upload.sh uses this.
* snap.sh: a script for taking a photo, saving it to the /ram/imgur directory, and then hard-linking that file in /ram/gcloud.  (You save space by hard-linking rather than copying.)

To save memory/CPU, you don't want the Raspberry Pi to attempt to upload to both Imgur and Google Cloud at same time.  The two upload cronjobs use "flock" to block until a lock file is available.  Whoever has the lock gets to upload.


