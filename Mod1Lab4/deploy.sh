#!/bin/bash
DEVICE_CONNECTION_STRING="HostName=edxiothub-chrishowd-2.azure-devices.net;DeviceId=testDevice;SharedAccessKey=GB1QcIEu49BuoyDSSbSav+uiXKV1ewgetj7sIy2Q7xI="

if [ $# -eq 0 ]
  then
        echo Deploying to Pi
        ADDRESS="192.168.1.144"
        USERNAME="pi"
        PASSWORD="raspberry"

        sshpass -p $PASSWORD ssh $USERNAME@$ADDRESS "rm -r AzureIoT; mkdir AzureIoT"
        sshpass -p $PASSWORD scp ./main.c ./bme280.c ./bme280.h ./wiring.h ./CMakeLists.txt "$USERNAME@$ADDRESS:/home/pi/AzureIoT"

        sshpass -p $PASSWORD ssh $USERNAME@$ADDRESS "cd ./AzureIoT; cmake . && make; sudo ./app '$DEVICE_CONNECTION_STRING'"
    else
        echo Deploying Locally
        cmake ./ && make && sudo ./app $DEVICE_CONNECTION_STRING
fi