#!/bin/bash

# Config
export MODULES=('pad'
                'ram'        'sep1'
                'drive'      'sep1'
                'battery'    'sep1'
                'pulseaudio' 'sep1'
                'time'
                'pad')

export DELAY='0.5s'

# Module config
export TIME_FORMAT='+%H:%M, %m-%d (%Y)'
export SEPERATOR1=' | '
export DRIVE_CHECK_MOUNT='/home'
export BATTERY_NAME='BAT0'
export BATTERY_SHOW_STATUS=0
