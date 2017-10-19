#!/bin/bash
if [ -e /var/run/rsyslog/dev ]; then
    ln -sf /var/run/rsyslog/dev/log /dev/log
fi
exec "$@"
