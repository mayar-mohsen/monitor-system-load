# monitor-system-load </br>
### Bash shell script which monitor the performance of the system each 1 minute. </br>
If the load on the system increased during 1 minute , 5 minutes or 15 minutes: </br>

    > A message will be sent in */var/log/SystemLoad* specyfing the load and date . </br>
    > A detailed message will be sent in */tmp/events* specyfing the load in each time , 1 min. , 5 min, and 15 minutes , </br>
      and details about the server as the hostname and the server IP address. 
