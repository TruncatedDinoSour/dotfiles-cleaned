#!/bin/bash

# Config
export MODULES=('pad'
                'ram'        'sep1'
                'drive'      'sep1'
                'battery'    'sep1'
                'brightness' 'sep1'
                'alsa'       'sep1'
                'time')

export DELAY='0.5'

# Module config
export TIME_FORMAT='+%H:%M, %m-%d (%Y)'
export SEPERATOR1=' | '
export DRIVE_CHECK_MOUNT='/home'
export BATTERY_NAME='BAT1'
export BATTERY_SHOW_STATUS=0

