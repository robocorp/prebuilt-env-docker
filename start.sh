#!/usr/bin/env bash

echo "Linking the Agent with name $NAME and token $LINK_TOKEN"
/home/worker/bin/robocorp-workforce-agent-core link $LINK_TOKEN --name $NAME --instance-path /home/worker/instance

echo "Starting the Agent..."
/home/worker/bin/robocorp-workforce-agent-core start --instance-path /home/worker/instance & /usr/bin/rccremote & wait