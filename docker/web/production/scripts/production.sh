#!/usr/bin/env bash

if [ "$FORCE_INSTALLER" == "true" ]; then
    npm run installer force
else
    npm run installer
fi