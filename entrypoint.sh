#!/bin/bash
cd $HOME

SERVER_DIR=$HOME/server
MODIFIED_STARTUP=$(eval echo "$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')")

# Validate server
echo "Validating server files..."
EX=""

if [ ! -z $CUSTOM_BRANCH_NAME ]; then
  EX="-beta $CUSTOM_BRANCH_NAME"

  if [ ! -z $CUSTOM_BRANCH_PASSWORD ]; then
    EX="-beta $CUSTOM_BRANCH_NAME -betapassword $CUSTOM_BRANCH_PASSWORD"
  fi
fi

./steamcmd.sh +login anonymous +force_install_dir $SERVER_DIR +app_update 996560 validate $EX +quit

# Start server
echo "Starting server..."
cd $SERVER_DIR && ${MODIFIED_STARTUP}
