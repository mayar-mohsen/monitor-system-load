#Monitor System Load

IP=$(hostname -i | awk '{print $2}')
HOSTNAME=$(hostname)

LOAD_1min=$(uptime | awk 'BEGIN {FS=","} {print $3 $4 $5}' | awk 'BEGIN {FS=":"} {print $2}' | awk '{print $1}')
LOAD_5min=$(uptime | awk 'BEGIN {FS=","} {print $3 $4 $5}' | awk 'BEGIN {FS=":"} {print $2}' | awk '{print $2}')
LOAD_15min=$(uptime | awk 'BEGIN {FS=","} {print $3 $4 $5}' | awk 'BEGIN {FS=":"} {print $2}' | awk '{print $3}')

while true
do
        OLD_1min=$LOAD_1min
        OLD_5min=$LOAD_5min
        OLD_15min=$LOAD_15min

        sleep 60

        LOAD_1min=$(uptime | awk 'BEGIN {FS=","} {print $3 $4 $5}' | awk 'BEGIN {FS=":"} {print $2}' | awk '{print $1}')
        LOAD_5min=$(uptime | awk 'BEGIN {FS=","} {print $3 $4 $5}' | awk 'BEGIN {FS=":"} {print $2}' | awk '{print $2}')
        LOAD_15min=$(uptime | awk 'BEGIN {FS=","} {print $3 $4 $5}' | awk 'BEGIN {FS=":"} {print $2}' | awk '{print $3}')

        if [ $LOAD_1min -gt $OLD_1min ]|bc || [ $LOAD_5min -gt $OLD_5min ]|bc || [ $LOAD_15min -gt $OLD_15min ]|bc
        then
                echo -n The load is: ${LOAD_1min} ${LOAD_5min} ${LOAD_15min} and the date is: `date` >> /var/log/SystemLoad
                echo "Subject: Server $IP load
                        Body:
                        Dear,
                                The system $HOSTNAME runs with IP $IP has a load of
                                1MIN load: $LOAD_1min
                                5MIN load: $LOAD_5min
                                15MIN load:$LOAD_15min
                        Thank you ." >> /tmp/events
        fi
done
