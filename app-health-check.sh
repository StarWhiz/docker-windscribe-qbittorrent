#! /bin/bash

# Check to make sure qbittorrent-nox is running

QBTNX=$(pgrep qbittorrent-nox | wc -l )
if [[ ${QBTNX} -ne 1 ]]
then
	echo "qbittorrent-nox process not running"
	exit 1
fi

echo "qbittorrent-nox is running"

exit 0

