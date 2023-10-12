#!/bin/bash

while :; do
    process=$(ps aux | grep "fwGUI" | grep -v grep)
    if [ -n "$process" ]; then
        pid=$(echo "$process" | awk '{print $2}')
        echo "Killing process $pid"
        kill -9 "$pid"
    fi
    process=$(ps aux | grep "activmgr" | grep -v grep)
    if [ -n "$process" ]; then
        pid=$(echo "$process" | awk '{print $2}')
        echo "Killing process $pid"
        kill -9 "$pid"
    fi
    process=$(ps aux | grep "activhardwareservice" | grep -v grep)
    if [ -n "$process" ]; then
        pid=$(echo "$process" | awk '{print $2}')
        echo "Killing process $pid"
        kill -9 "$pid"
    fi
    process=$(ps aux | grep "mediaremoteagent" | grep -v grep)
    if [ -n "$process" ]; then
        pid=$(echo "$process" | awk '{print $2}')
        echo "Killing process $pid"
        kill -9 "$pid"
    fi
    sleep 1
done
