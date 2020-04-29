# aerosharp
Aerosharp inverter interface software. I didn't create this software but have modified it. I originally downloaded it from http://www.ozzicomp.com/aerosharp/ 
This site has since disappeared so I have put a copy on github as a backup.
This software extracts data from an aero sharp inverter and stores this in Tobi Oetiker database, the create_rrd_graph.sh script extracts the data from the databases and generates a series of image files that can be included in a web page.
The crtontab.txt file contains the command that can go into the crontab file to stop the app running at night, it locks up if you leave the app running when the inverter has shut down.
Modify this file: /etc/udev/rules.d/50-usbserial.rules
and add:
SUBSYSTEMS=="usb", ATTRS{manufacturer}=="Prolific Technology Inc.", ATTRS{product}=="USB-Serial Controller", KERNELS=="1-1.2" SYMLINK+="aerosharp", ACTION=="add", MODE="0666"

Get a good quality serial to usb device because this one spews out a big string of garbage from time to time locking up the software, hence the check and restart script in cron
