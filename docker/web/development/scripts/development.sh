#!/bin/bash

yarn install --prefer-offline

bower install --allow-root

node ./node_modules/sails/bin/sails.js lift