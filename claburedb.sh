#!/bin/bash

while :; do
	rails server -e production
	echo clabure restarted | mail -s 'clabure restarted' xslaby
done
