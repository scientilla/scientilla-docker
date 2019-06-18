#!/bin/bash

yarn install --prefer-offline

bower install --allow-root

if [ "$FORCE_INSTALLER" == "true" ]; then
    npm run installer force
else
    npm run installer
fi