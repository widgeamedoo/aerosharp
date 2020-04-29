#!/bin/sh
TZ='Australia/Melbourne'; export TZ
#------------------------------------------ Here sre the 4 energy graph creation commands --------------------

#  Create daily energy generation graph  60 x 60 x 24 = 86400 secs
cd /home/pi/aerosharp
/usr/bin/rrdtool graph /tmp/energy_daily.png \
-w 785 -h 120 -a PNG \
--start -86400 --end now \
--vertical-label "kWh" \
--font DEFAULT:7: \
--title "Aerosharp Inverter kWh Output" \
--lower-limit 0 \
--x-grid MINUTE:30:MINUTE:30:MINUTE:60:0:%H:%M \
--alt-y-grid --rigid \
DEF:energy_today=aerosharp_energy_today.rrd:energy_today:AVERAGE \
LINE1:energy_today#0000FF:"kWh" \
GPRINT:energy_today:LAST:"Cur\: %5.2lf" \
GPRINT:energy_today:AVERAGE:"Avg\: %5.2lf" \
GPRINT:energy_today:MAX:"Max\: %5.2lf" \
GPRINT:energy_today:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Weekly energy generation graph  60 x 60 x 24 x 7

/usr/bin/rrdtool graph /tmp/energy_weekly.png \
-w 785 -h 120 -a PNG \
--start -604800 --end now \
--vertical-label "kWh" \
--font DEFAULT:7: \
--title "Aerosharp Inverter kWh Output" \
--lower-limit 0 \
--x-grid MINUTE:120:MINUTE:720:MINUTE:1440:0:%a:%d:%m:%Y \
DEF:energy_today=aerosharp_energy_today.rrd:energy_today:AVERAGE \
LINE2:energy_today#0000FF:"kWh" \
GPRINT:energy_today:LAST:"Cur\: %5.2lf" \
GPRINT:energy_today:AVERAGE:"Avg\: %5.2lf" \
GPRINT:energy_today:MAX:"Max\: %5.2lf" \
GPRINT:energy_today:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Monthly energy generation graph  60 x 60 x 24 x 30 = 2592000

/usr/bin/rrdtool graph /tmp/energy_monthly.png \
-w 785 -h 120 -a PNG \
--start -2592000 --end now \
--vertical-label "kWh" \
--font DEFAULT:7: \
--title "Aerosharp Inverter kWh Output" \
--lower-limit 0 \
--x-grid MINUTE:1440:MINUTE:720:MINUTE:1440:0:%d \
DEF:energy_today=aerosharp_energy_today.rrd:energy_today:MAX \
LINE2:energy_today#0000FF:"kWh" \
GPRINT:energy_today:LAST:"Cur\: %5.2lf" \
GPRINT:energy_today:AVERAGE:"Avg\: %5.2lf" \
GPRINT:energy_today:MAX:"Max\: %5.2lf" \
GPRINT:energy_today:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Yearly energy generation graph  60 x 60 x 24 x 30 x 12 = 31104000

/usr/bin/rrdtool graph /tmp/energy_yearly.png \
-w 785 -h 120 -a PNG \
--start -31104000 --end now \
--vertical-label "kWh" \
--font DEFAULT:7: \
--title "Aerosharp Inverter kWh Output" \
--lower-limit 0 \
--x-grid MINUTE:43200:MINUTE:10080:MINUTE:43200:0:%b-%y \
DEF:energy_today=aerosharp_energy_today.rrd:energy_today:AVERAGE \
LINE2:energy_today#0000FF:"kWh" \
GPRINT:energy_today:LAST:"Cur\: %5.2lf" \
GPRINT:energy_today:AVERAGE:"Avg\: %5.2lf" \
GPRINT:energy_today:MAX:"Max\: %5.2lf" \
GPRINT:energy_today:MIN:"Min\: %5.2lf\t\t\t" \

#------------------------------------------ Here are the 4 temperature graph creation commands --------------------

/usr/bin/rrdtool graph /tmp/temp_daily.png \
-w 785 -h 120 -a PNG \
--start -86400 --end now \
--vertical-label "Deg C" \
--font DEFAULT:7: \
--title "Aerosharp Inverter Temp (C)" \
--lower-limit 0 \
--x-grid MINUTE:30:MINUTE:30:MINUTE:60:0:%H:%M \
--alt-y-grid --rigid \
DEF:temp=aerosharp_temp.rrd:temp:AVERAGE \
LINE1:temp#0000FF:"Temp" \
GPRINT:temp:LAST:"Cur\: %5.2lf" \
GPRINT:temp:AVERAGE:"Avg\: %5.2lf" \
GPRINT:temp:MAX:"Max\: %5.2lf" \
GPRINT:temp:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Weekly temp  graph  60 x 60 x 24 x 7

/usr/bin/rrdtool graph /tmp/temp_weekly.png \
-w 785 -h 120 -a PNG \
--start -604800 --end now \
--vertical-label "Deg C" \
--font DEFAULT:7: \
--title "Aerosharp Inverter Temp (C)" \
--lower-limit 0 \
--x-grid MINUTE:120:MINUTE:720:MINUTE:1440:0:%a:%d:%m:%Y \
DEF:temp=aerosharp_temp.rrd:temp:AVERAGE \
LINE1:temp#0000FF:"Temp" \
GPRINT:temp:LAST:"Cur\: %5.2lf" \
GPRINT:temp:AVERAGE:"Avg\: %5.2lf" \
GPRINT:temp:MAX:"Max\: %5.2lf" \
GPRINT:temp:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Monthly temp graph  60 x 60 x 24 x 30 = 2592000

/usr/bin/rrdtool graph /tmp/temp_monthly.png \
-w 785 -h 120 -a PNG \
--start -2592000 --end now \
--vertical-label "Deg C" \
--font DEFAULT:7: \
--title "Aerosharp Inverter Temp (C)" \
--lower-limit 0 \
--x-grid MINUTE:1440:MINUTE:720:MINUTE:1440:0:%d \
DEF:temp=aerosharp_temp.rrd:temp:AVERAGE \
LINE1:temp#0000FF:"Temp" \
GPRINT:temp:LAST:"Cur\: %5.2lf" \
GPRINT:temp:AVERAGE:"Avg\: %5.2lf" \
GPRINT:temp:MAX:"Max\: %5.2lf" \
GPRINT:temp:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Yearly temp graph  60 x 60 x 24 x 30 x 12 = 31104000

/usr/bin/rrdtool graph /tmp/temp_yearly.png \
-w 785 -h 120 -a PNG \
--start -31104000 --end now \
--vertical-label "Deg C" \
--font DEFAULT:7: \
--title "Aerosharp Inverter Temp (C)" \
--lower-limit 0 \
--x-grid MINUTE:43200:MINUTE:10080:MINUTE:43200:0:%b-%y \
DEF:temp=aerosharp_temp.rrd:temp:AVERAGE \
LINE1:temp#0000FF:"Temp" \
GPRINT:temp:LAST:"Cur\: %5.2lf" \
GPRINT:temp:AVERAGE:"Avg\: %5.2lf" \
GPRINT:temp:MAX:"Max\: %5.2lf" \
GPRINT:temp:MIN:"Min\: %5.2lf\t\t\t" \

#------------------------------------------ Here are the 4 Grid Frequency graph creation commands --------------------

/usr/bin/rrdtool graph /tmp/grid_frequency_daily.png \
-w 785 -h 120 -a PNG \
--start -86400 --end now \
--vertical-label "Hz" \
--font DEFAULT:7: \
--title "Grid Frequency (Hz)" \
--lower-limit 49 \
--x-grid MINUTE:30:MINUTE:30:MINUTE:60:0:%H:%M \
--alt-y-grid --rigid \
DEF:grid_frequency=aerosharp_grid_frequency.rrd:grid_frequency:AVERAGE \
LINE1:grid_frequency#0000FF:"Grid Freq" \
GPRINT:grid_frequency:LAST:"Cur\: %5.2lf" \
GPRINT:grid_frequency:AVERAGE:"Avg\: %5.2lf" \
GPRINT:grid_frequency:MAX:"Max\: %5.2lf" \
GPRINT:grid_frequency:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Weekly Grid Frequency graph  60 x 60 x 24 x 7

/usr/bin/rrdtool graph /tmp/grid_frequency_weekly.png \
-w 785 -h 120 -a PNG \
--start -604800 --end now \
--vertical-label "Hz" \
--font DEFAULT:7: \
--title "Grid Frequency (Hz)" \
--lower-limit 45 \
--x-grid MINUTE:120:MINUTE:720:MINUTE:1440:0:%a:%d:%m:%Y \
--alt-y-grid --rigid \
DEF:grid_frequency=aerosharp_grid_frequency.rrd:grid_frequency:AVERAGE \
LINE1:grid_frequency#0000FF:"Grid Freq" \
GPRINT:grid_frequency:LAST:"Cur\: %5.2lf" \
GPRINT:grid_frequency:AVERAGE:"Avg\: %5.2lf" \
GPRINT:grid_frequency:MAX:"Max\: %5.2lf" \
GPRINT:grid_frequency:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Monthly Grid Frequency graph  60 x 60 x 24 x 30 = 2592000

/usr/bin/rrdtool graph /tmp/grid_frequency_monthly.png \
-w 785 -h 120 -a PNG \
--start -2592000 --end now \
--vertical-label "Hz" \
--font DEFAULT:7: \
--title "Grid Frequency (Hz)" \
--lower-limit 45 \
--x-grid MINUTE:1440:MINUTE:720:MINUTE:1440:0:%d \
--alt-y-grid --rigid \
DEF:grid_frequency=aerosharp_grid_frequency.rrd:grid_frequency:AVERAGE \
LINE1:grid_frequency#0000FF:"Grid Freq" \
GPRINT:grid_frequency:LAST:"Cur\: %5.2lf" \
GPRINT:grid_frequency:AVERAGE:"Avg\: %5.2lf" \
GPRINT:grid_frequency:MAX:"Max\: %5.2lf" \
GPRINT:grid_frequency:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Yearly Grid Frequency graph  60 x 60 x 24 x 30 x 12 = 31104000

/usr/bin/rrdtool graph /tmp/grid_frequency_yearly.png \
-w 785 -h 120 -a PNG \
--start -31104000 --end now \
--vertical-label "Hz" \
--font DEFAULT:7: \
--title "Grid Frequency (Hz)" \
--lower-limit 45 \
--x-grid MINUTE:43200:MINUTE:10080:MINUTE:43200:0:%b-%y \
--alt-y-grid --rigid \
DEF:grid_frequency=aerosharp_grid_frequency.rrd:grid_frequency:AVERAGE \
LINE1:grid_frequency#0000FF:"Grid Freq" \
GPRINT:grid_frequency:LAST:"Cur\: %5.2lf" \
GPRINT:grid_frequency:AVERAGE:"Avg\: %5.2lf" \
GPRINT:grid_frequency:MAX:"Max\: %5.2lf" \
GPRINT:grid_frequency:MIN:"Min\: %5.2lf\t\t\t" \

#------------------------------------------ Here are the 4 Grid Voltage graph creation commands --------------------

/usr/bin/rrdtool graph /tmp/grid_voltage_daily.png \
-w 785 -h 120 -a PNG \
--start -86400 --end now \
--vertical-label "V" \
--font DEFAULT:7: \
--title "Grid Voltage (V)" \
--lower-limit 210 \
--x-grid MINUTE:30:MINUTE:30:MINUTE:60:0:%H:%M \
--alt-y-grid --rigid \
DEF:grid_voltage=aerosharp_grid_voltage.rrd:grid_voltage:AVERAGE \
LINE1:grid_voltage#0000FF:"Grid Voltage" \
GPRINT:grid_voltage:LAST:"Cur\: %5.2lf" \
GPRINT:grid_voltage:AVERAGE:"Avg\: %5.2lf" \
GPRINT:grid_voltage:MAX:"Max\: %5.2lf" \
GPRINT:grid_voltage:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Weekly Grid Voltage graph  60 x 60 x 24 x 7

/usr/bin/rrdtool graph /tmp/grid_voltage_weekly.png \
-w 785 -h 120 -a PNG \
--start -604800 --end now \
--vertical-label "V" \
--font DEFAULT:7: \
--title "Grid Voltage" \
--lower-limit 210 \
--x-grid MINUTE:120:MINUTE:720:MINUTE:1440:0:%a:%d:%m:%Y \
--alt-y-grid --rigid \
DEF:grid_voltage=aerosharp_grid_voltage.rrd:grid_voltage:AVERAGE \
LINE1:grid_voltage#0000FF:"Grid Voltage" \
GPRINT:grid_voltage:LAST:"Cur\: %5.2lf" \
GPRINT:grid_voltage:AVERAGE:"Avg\: %5.2lf" \
GPRINT:grid_voltage:MAX:"Max\: %5.2lf" \
GPRINT:grid_voltage:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Monthly Grid Voltage graph  60 x 60 x 24 x 30 = 2592000

/usr/bin/rrdtool graph /tmp/grid_voltage_monthly.png \
-w 785 -h 120 -a PNG \
--start -2592000 --end now \
--vertical-label "V" \
--font DEFAULT:7: \
--title "Grid Voltage" \
--lower-limit 210 \
--x-grid MINUTE:1440:MINUTE:720:MINUTE:1440:0:%d \
DEF:grid_voltage=aerosharp_grid_voltage.rrd:grid_voltage:AVERAGE \
LINE1:grid_voltage#0000FF:"Grid Voltage" \
GPRINT:grid_voltage:LAST:"Cur\: %5.2lf" \
GPRINT:grid_voltage:AVERAGE:"Avg\: %5.2lf" \
GPRINT:grid_voltage:MAX:"Max\: %5.2lf" \
GPRINT:grid_voltage:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Yearly Grid Voltage graph  60 x 60 x 24 x 30 x 12 = 31104000

/usr/bin/rrdtool graph /tmp/grid_voltage_yearly.png \
-w 785 -h 120 -a PNG \
--start -31104000 --end now \
--vertical-label "V" \
--font DEFAULT:7: \
--title "Grid Voltage (V)" \
--lower-limit 210 \
--x-grid MINUTE:43200:MINUTE:10080:MINUTE:43200:0:%b-%y \
DEF:grid_voltage=aerosharp_grid_voltage.rrd:grid_voltage:AVERAGE \
LINE1:grid_voltage#0000FF:"Grid Voltage" \
GPRINT:grid_voltage:LAST:"Cur\: %5.2lf" \
GPRINT:grid_voltage:AVERAGE:"Avg\: %5.2lf" \
GPRINT:grid_voltage:MAX:"Max\: %5.2lf" \
GPRINT:grid_voltage:MIN:"Min\: %5.2lf\t\t\t" \

#------------------------------------------ Here are the 4 AC Amps graph creation commands --------------------

/usr/bin/rrdtool graph /tmp/ac_amps_daily.png \
-w 785 -h 120 -a PNG \
--start -86400 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "AC Amps" \
--lower-limit 0 \
--x-grid MINUTE:30:MINUTE:30:MINUTE:60:0:%H:%M \
--alt-y-grid --rigid \
DEF:ac_amps=aerosharp_ac_amps.rrd:ac_amps:AVERAGE \
LINE1:ac_amps#0000FF:"AC Amps" \
GPRINT:ac_amps:LAST:"Cur\: %5.2lf" \
GPRINT:ac_amps:AVERAGE:"Avg\: %5.2lf" \
GPRINT:ac_amps:MAX:"Max\: %5.2lf" \
GPRINT:ac_amps:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Weekly AC Amps graph  60 x 60 x 24 x 7

/usr/bin/rrdtool graph /tmp/ac_amps_weekly.png \
-w 785 -h 120 -a PNG \
--start -604800 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "AC Amps" \
--lower-limit 0 \
--x-grid MINUTE:120:MINUTE:720:MINUTE:1440:0:%a:%d:%m:%Y \
DEF:ac_amps=aerosharp_ac_amps.rrd:ac_amps:AVERAGE \
LINE1:ac_amps#0000FF:"AC Amps" \
GPRINT:ac_amps:LAST:"Cur\: %5.2lf" \
GPRINT:ac_amps:AVERAGE:"Avg\: %5.2lf" \
GPRINT:ac_amps:MAX:"Max\: %5.2lf" \
GPRINT:ac_amps:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Monthly AC Amps graph  60 x 60 x 24 x 30 = 2592000

/usr/bin/rrdtool graph /tmp/ac_amps_monthly.png \
-w 785 -h 120 -a PNG \
--start -2592000 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "AC Amps" \
--lower-limit 0 \
--x-grid MINUTE:1440:MINUTE:720:MINUTE:1440:0:%d \
DEF:ac_amps=aerosharp_ac_amps.rrd:ac_amps:AVERAGE \
LINE1:ac_amps#0000FF:"AC Amps" \
GPRINT:ac_amps:LAST:"Cur\: %5.2lf" \
GPRINT:ac_amps:AVERAGE:"Avg\: %5.2lf" \
GPRINT:ac_amps:MAX:"Max\: %5.2lf" \
GPRINT:ac_amps:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Yearly AC Amps graph  60 x 60 x 24 x 30 x 12 = 31104000

/usr/bin/rrdtool graph /tmp/ac_amps_yearly.png \
-w 785 -h 120 -a PNG \
--start -31104000 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "AC Amps" \
--lower-limit 0 \
--x-grid MINUTE:43200:MINUTE:10080:MINUTE:43200:0:%b-%y \
DEF:ac_amps=aerosharp_ac_amps.rrd:ac_amps:AVERAGE \
LINE1:ac_amps#0000FF:"AC Amps" \
GPRINT:ac_amps:LAST:"Cur\: %5.2lf" \
GPRINT:ac_amps:AVERAGE:"Avg\: %5.2lf" \
GPRINT:ac_amps:MAX:"Max\: %5.2lf" \
GPRINT:ac_amps:MIN:"Min\: %5.2lf\t\t\t" \

#------------------------------------------ Here are the 4 AC Power / Watts graph creation commands --------------------

/usr/bin/rrdtool graph /tmp/ac_watts_daily.png \
-w 785 -h 120 -a PNG \
--start -86400 --end now \
--vertical-label "Watts" \
--font DEFAULT:7: \
--title "AC Watts" \
--lower-limit 0 \
--x-grid MINUTE:30:MINUTE:30:MINUTE:60:0:%H:%M \
--alt-y-grid --rigid \
DEF:ac_watts=aerosharp_ac_watts.rrd:ac_watts:AVERAGE \
LINE1:ac_watts#0000FF:"AC Watts" \
GPRINT:ac_watts:LAST:"Cur\: %5.2lf" \
GPRINT:ac_watts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:ac_watts:MAX:"Max\: %5.2lf" \
GPRINT:ac_watts:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Weekly AC Watts graph  60 x 60 x 24 x 7

/usr/bin/rrdtool graph /tmp/ac_watts_weekly.png \
-w 785 -h 120 -a PNG \
--start -604800 --end now \
--vertical-label "Watts" \
--font DEFAULT:7: \
--title "AC Watts" \
--lower-limit 0 \
--x-grid MINUTE:120:MINUTE:720:MINUTE:1440:0:%a:%d:%m:%Y \
DEF:ac_watts=aerosharp_ac_watts.rrd:ac_watts:AVERAGE \
LINE1:ac_watts#0000FF:"AC Watts" \
GPRINT:ac_watts:LAST:"Cur\: %5.2lf" \
GPRINT:ac_watts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:ac_watts:MAX:"Max\: %5.2lf" \
GPRINT:ac_watts:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Monthly AC Watts graph  60 x 60 x 24 x 30 = 2592000

/usr/bin/rrdtool graph /tmp/ac_watts_monthly.png \
-w 785 -h 120 -a PNG \
--start -2592000 --end now \
--vertical-label "Watts" \
--font DEFAULT:7: \
--title "AC Watts" \
--lower-limit 0 \
--x-grid MINUTE:1440:MINUTE:720:MINUTE:1440:0:%d \
DEF:ac_watts=aerosharp_ac_watts.rrd:ac_watts:AVERAGE \
LINE1:ac_watts#0000FF:"AC Watts" \
GPRINT:ac_watts:LAST:"Cur\: %5.2lf" \
GPRINT:ac_watts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:ac_watts:MAX:"Max\: %5.2lf" \
GPRINT:ac_watts:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Yearly AC Watts graph  60 x 60 x 24 x 30 x 12 = 31104000

/usr/bin/rrdtool graph /tmp/ac_watts_yearly.png \
-w 785 -h 120 -a PNG \
--start -31104000 --end now \
--vertical-label "Watts" \
--font DEFAULT:7: \
--title "AC Watts" \
--lower-limit 0 \
--x-grid MINUTE:43200:MINUTE:10080:MINUTE:43200:0:%b-%y \
DEF:ac_watts=aerosharp_ac_watts.rrd:ac_watts:AVERAGE \
LINE1:ac_watts#0000FF:"AC Watts" \
GPRINT:ac_watts:LAST:"Cur\: %5.2lf" \
GPRINT:ac_watts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:ac_watts:MAX:"Max\: %5.2lf" \
GPRINT:ac_watts:MIN:"Min\: %5.2lf\t\t\t" \

#------------------------------------------ Here are the 4 PV1 Volts graph creation commands --------------------

/usr/bin/rrdtool graph /tmp/pv1_volts_daily.png \
-w 785 -h 120 -a PNG \
--start -86400 --end now \
--vertical-label "Volts" \
--font DEFAULT:7: \
--title "PV1 Volts" \
--lower-limit 0 \
--x-grid MINUTE:30:MINUTE:30:MINUTE:60:0:%H:%M \
--alt-y-grid --rigid \
DEF:pv1_volts=aerosharp_pv1_volts.rrd:pv1_volts:AVERAGE \
LINE1:pv1_volts#0000FF:"PV1 Volts" \
GPRINT:pv1_volts:LAST:"Cur\: %5.2lf" \
GPRINT:pv1_volts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv1_volts:MAX:"Max\: %5.2lf" \
GPRINT:pv1_volts:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Weekly PV1 Volts graph  60 x 60 x 24 x 7

/usr/bin/rrdtool graph /tmp/pv1_volts_weekly.png \
-w 785 -h 120 -a PNG \
--start -604800 --end now \
--vertical-label "Volts" \
--font DEFAULT:7: \
--title "PV1 Volts" \
--lower-limit 0 \
--x-grid MINUTE:120:MINUTE:720:MINUTE:1440:0:%a:%d:%m:%Y \
DEF:pv1_volts=aerosharp_pv1_volts.rrd:pv1_volts:AVERAGE \
LINE1:pv1_volts#0000FF:"PV1 Volts" \
GPRINT:pv1_volts:LAST:"Cur\: %5.2lf" \
GPRINT:pv1_volts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv1_volts:MAX:"Max\: %5.2lf" \
GPRINT:pv1_volts:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Monthly PV1 Volts graph  60 x 60 x 24 x 30 = 2592000

/usr/bin/rrdtool graph /tmp/pv1_volts_monthly.png \
-w 785 -h 120 -a PNG \
--start -2592000 --end now \
--vertical-label "Volts" \
--font DEFAULT:7: \
--title "PV1 Volts" \
--lower-limit 0 \
--x-grid MINUTE:1440:MINUTE:720:MINUTE:1440:0:%d \
DEF:pv1_volts=aerosharp_pv1_volts.rrd:pv1_volts:AVERAGE \
LINE1:pv1_volts#0000FF:"PV1 Volts" \
GPRINT:pv1_volts:LAST:"Cur\: %5.2lf" \
GPRINT:pv1_volts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv1_volts:MAX:"Max\: %5.2lf" \
GPRINT:pv1_volts:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Yearly PV1 Volts graph  60 x 60 x 24 x 30 x 12 = 31104000

/usr/bin/rrdtool graph /tmp/pv1_volts_yearly.png \
-w 785 -h 120 -a PNG \
--start -31104000 --end now \
--vertical-label "Volts" \
--font DEFAULT:7: \
--title "PV1 Volts" \
--lower-limit 0 \
--x-grid MINUTE:43200:MINUTE:10080:MINUTE:43200:0:%b-%y \
DEF:pv1_volts=aerosharp_pv1_volts.rrd:pv1_volts:AVERAGE \
LINE1:pv1_volts#0000FF:"PV1 Volts" \
GPRINT:pv1_volts:LAST:"Cur\: %5.2lf" \
GPRINT:pv1_volts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv1_volts:MAX:"Max\: %5.2lf" \
GPRINT:pv1_volts:MIN:"Min\: %5.2lf\t\t\t" \

#------------------------------------------ Here are the 4 PV2 Volts graph creation commands --------------------

/usr/bin/rrdtool graph /tmp/pv2_volts_daily.png \
-w 785 -h 120 -a PNG \
--start -86400 --end now \
--vertical-label "Volts" \
--font DEFAULT:7: \
--title "PV2 Volts" \
--lower-limit 0 \
--x-grid MINUTE:30:MINUTE:30:MINUTE:60:0:%H:%M \
--alt-y-grid --rigid \
DEF:pv2_volts=aerosharp_pv2_volts.rrd:pv2_volts:AVERAGE \
LINE1:pv2_volts#0000FF:"PV2 Volts" \
GPRINT:pv2_volts:LAST:"Cur\: %5.2lf" \
GPRINT:pv2_volts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv2_volts:MAX:"Max\: %5.2lf" \
GPRINT:pv2_volts:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Weekly PV2 Volts graph  60 x 60 x 24 x 7

/usr/bin/rrdtool graph /tmp/pv2_volts_weekly.png \
-w 785 -h 120 -a PNG \
--start -604800 --end now \
--vertical-label "Volts" \
--font DEFAULT:7: \
--title "PV2 Volts" \
--lower-limit 0 \
--x-grid MINUTE:120:MINUTE:720:MINUTE:1440:0:%a:%d:%m:%Y \
DEF:pv2_volts=aerosharp_pv2_volts.rrd:pv2_volts:AVERAGE \
LINE1:pv2_volts#0000FF:"PV2 Volts" \
GPRINT:pv2_volts:LAST:"Cur\: %5.2lf" \
GPRINT:pv2_volts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv2_volts:MAX:"Max\: %5.2lf" \
GPRINT:pv2_volts:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Monthly PV2 Volts graph  60 x 60 x 24 x 30 = 2592000

/usr/bin/rrdtool graph /tmp/pv2_volts_monthly.png \
-w 785 -h 120 -a PNG \
--start -2592000 --end now \
--vertical-label "Volts" \
--font DEFAULT:7: \
--title "PV2 Volts" \
--lower-limit 0 \
--x-grid MINUTE:1440:MINUTE:720:MINUTE:1440:0:%d \
DEF:pv2_volts=aerosharp_pv2_volts.rrd:pv2_volts:AVERAGE \
LINE1:pv2_volts#0000FF:"PV2 Volts" \
GPRINT:pv2_volts:LAST:"Cur\: %5.2lf" \
GPRINT:pv2_volts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv2_volts:MAX:"Max\: %5.2lf" \
GPRINT:pv2_volts:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Yearly PV2 Volts graph  60 x 60 x 24 x 30 x 12 = 31104000

/usr/bin/rrdtool graph /tmp/pv2_volts_yearly.png \
-w 785 -h 120 -a PNG \
--start -31104000 --end now \
--vertical-label "Volts" \
--font DEFAULT:7: \
--title "PV2 Volts" \
--lower-limit 0 \
--x-grid MINUTE:43200:MINUTE:10080:MINUTE:43200:0:%b-%y \
DEF:pv2_volts=aerosharp_pv2_volts.rrd:pv2_volts:AVERAGE \
LINE1:pv2_volts#0000FF:"PV2 Volts" \
GPRINT:pv2_volts:LAST:"Cur\: %5.2lf" \
GPRINT:pv2_volts:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv2_volts:MAX:"Max\: %5.2lf" \
GPRINT:pv2_volts:MIN:"Min\: %5.2lf\t\t\t" \

#------------------------------------------ Here are the 4 PV1 Current graph creation commands --------------------

/usr/bin/rrdtool graph /tmp/pv1_current_daily.png \
-w 785 -h 120 -a PNG \
--start -86400 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "PV1 Amps" \
--lower-limit 0 \
--x-grid MINUTE:30:MINUTE:30:MINUTE:60:0:%H:%M \
--alt-y-grid --rigid \
DEF:pv1_current=aerosharp_pv1_current.rrd:pv1_current:AVERAGE \
LINE1:pv1_current#0000FF:"PV1 Current" \
GPRINT:pv1_current:LAST:"Cur\: %5.2lf" \
GPRINT:pv1_current:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv1_current:MAX:"Max\: %5.2lf" \
GPRINT:pv1_current:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Weekly PV1 Current graph  60 x 60 x 24 x 7

/usr/bin/rrdtool graph /tmp/pv1_current_weekly.png \
-w 785 -h 120 -a PNG \
--start -604800 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "PV1 Current" \
--lower-limit 0 \
--x-grid MINUTE:120:MINUTE:720:MINUTE:1440:0:%a:%d:%m:%Y \
DEF:pv1_current=aerosharp_pv1_current.rrd:pv1_current:AVERAGE \
LINE1:pv1_current#0000FF:"PV1 Current" \
GPRINT:pv1_current:LAST:"Cur\: %5.2lf" \
GPRINT:pv1_current:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv1_current:MAX:"Max\: %5.2lf" \
GPRINT:pv1_current:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Monthly PV1 Current graph  60 x 60 x 24 x 30 = 2592000

/usr/bin/rrdtool graph /tmp/pv1_current_monthly.png \
-w 785 -h 120 -a PNG \
--start -2592000 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "PV1 Current" \
--lower-limit 0 \
--x-grid MINUTE:1440:MINUTE:720:MINUTE:1440:0:%d \
DEF:pv1_current=aerosharp_pv1_current.rrd:pv1_current:AVERAGE \
LINE1:pv1_current#0000FF:"PV1 Current" \
GPRINT:pv1_current:LAST:"Cur\: %5.2lf" \
GPRINT:pv1_current:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv1_current:MAX:"Max\: %5.2lf" \
GPRINT:pv1_current:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Yearly PV1 Current graph  60 x 60 x 24 x 30 x 12 = 31104000

/usr/bin/rrdtool graph /tmp/pv1_current_yearly.png \
-w 785 -h 120 -a PNG \
--start -31104000 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "PV1 Current" \
--lower-limit 0 \
--x-grid MINUTE:43200:MINUTE:10080:MINUTE:43200:0:%b-%y \
DEF:pv1_current=aerosharp_pv1_current.rrd:pv1_current:AVERAGE \
LINE1:pv1_current#0000FF:"PV1 Current" \
GPRINT:pv1_current:LAST:"Cur\: %5.2lf" \
GPRINT:pv1_current:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv1_current:MAX:"Max\: %5.2lf" \
GPRINT:pv1_current:MIN:"Min\: %5.2lf\t\t\t" \

#------------------------------------------ Here are the 4 PV2 Current graph creation commands --------------------

/usr/bin/rrdtool graph /tmp/pv2_current_daily.png \
-w 785 -h 120 -a PNG \
--start -86400 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "PV2 Amps" \
--lower-limit 0 \
--x-grid MINUTE:30:MINUTE:30:MINUTE:60:0:%H:%M \
--alt-y-grid --rigid \
DEF:pv2_current=aerosharp_pv2_current.rrd:pv2_current:AVERAGE \
LINE1:pv2_current#0000FF:"PV2 Current" \
GPRINT:pv2_current:LAST:"Cur\: %5.2lf" \
GPRINT:pv2_current:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv2_current:MAX:"Max\: %5.2lf" \
GPRINT:pv2_current:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Weekly PV2 Current graph  60 x 60 x 24 x 7

/usr/bin/rrdtool graph /tmp/pv2_current_weekly.png \
-w 785 -h 120 -a PNG \
--start -604800 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "PV2 Current" \
--lower-limit 0 \
--x-grid MINUTE:120:MINUTE:720:MINUTE:1440:0:%a:%d:%m:%Y \
DEF:pv2_current=aerosharp_pv2_current.rrd:pv2_current:AVERAGE \
LINE1:pv2_current#0000FF:"PV2 Current" \
GPRINT:pv2_current:LAST:"Cur\: %5.2lf" \
GPRINT:pv2_current:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv2_current:MAX:"Max\: %5.2lf" \
GPRINT:pv2_current:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Monthly PV2 Current graph  60 x 60 x 24 x 30 = 2592000

/usr/bin/rrdtool graph /tmp/pv2_current_monthly.png \
-w 785 -h 120 -a PNG \
--start -2592000 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "PV2 Current" \
--lower-limit 0 \
--x-grid MINUTE:1440:MINUTE:720:MINUTE:1440:0:%d \
DEF:pv2_current=aerosharp_pv2_current.rrd:pv2_current:AVERAGE \
LINE1:pv2_current#0000FF:"PV2 Current" \
GPRINT:pv2_current:LAST:"Cur\: %5.2lf" \
GPRINT:pv2_current:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv2_current:MAX:"Max\: %5.2lf" \
GPRINT:pv2_current:MIN:"Min\: %5.2lf\t\t\t" \

#  Create Yearly PV2 Current graph  60 x 60 x 24 x 30 x 12 = 31104000

/usr/bin/rrdtool graph /tmp/pv2_current_yearly.png \
-w 785 -h 120 -a PNG \
--start -31104000 --end now \
--vertical-label "Amps" \
--font DEFAULT:7: \
--title "PV2 Current" \
--lower-limit 0 \
--x-grid MINUTE:43200:MINUTE:10080:MINUTE:43200:0:%b-%y \
DEF:pv2_current=aerosharp_pv2_current.rrd:pv2_current:AVERAGE \
LINE1:pv2_current#0000FF:"PV2 Current" \
GPRINT:pv2_current:LAST:"Cur\: %5.2lf" \
GPRINT:pv2_current:AVERAGE:"Avg\: %5.2lf" \
GPRINT:pv2_current:MAX:"Max\: %5.2lf" \
GPRINT:pv2_current:MIN:"Min\: %5.2lf\t\t\t" \


