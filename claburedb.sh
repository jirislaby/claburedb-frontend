#!/bin/bash

while :; do
	rails server -e production
	sleep 10
	echo clabure restarted | mail -s 'clabure restarted' xslaby
done
