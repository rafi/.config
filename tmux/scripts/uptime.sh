#!/usr/bin/env bash

uptime | rev | cut -d":" -f1 | rev | sed s/,//g
