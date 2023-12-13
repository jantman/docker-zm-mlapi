#!/bin/bash

set -o errexit

cd /mlapi
python3 ./mlapi.py -c /etc/mlapiconfig.ini
