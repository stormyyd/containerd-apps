#!/bin/sh

export LD_LIBRARY_PATH=/usr/local/115/lib:$LD_LIBRARY_PATH
export PATH=/usr/local/115:$PATH
export HOME=/config
exec /usr/local/115/115
