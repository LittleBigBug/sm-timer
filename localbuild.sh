#!/bin/bash

export $(cat .env | xargs)

if [ -n "$1" ]; then
    SM_PATH="$1"
fi

if [ -z "$SM_PATH" ]; then
    echo "No SM_PATH specified! Either use the first argument or SM_PATH env variable to point to sourcemod directory inside addons"
    exit 1
fi

smbuilder --flags "-i=./addons/sourcemod/scripting/include/ -i=$SM_PATH/scripting/include"

if [ -z "$AFTER_BUILD_MOVE_PATH" ]; then
    echo "Done"
    exit 0
fi

echo "Copying plugins to new dir.."

# One of the folder names in build, i.e surf, bhop, full, deathrun
if [ -z "$AFTER_BUILD_MOVE_SUITE" ]; then
    echo "No build suite specified! Not copying over plugins"
    exit 1
fi

cp ./builds/$AFTER_BUILD_MOVE_SUITE/addons/sourcemod/plugins/*.smx "$AFTER_BUILD_MOVE_PATH"
echo "Done"