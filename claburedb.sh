#!/bin/bash

while :; do
	bundle exec rails server -e production
	sleep 30
	echo clabure restarted | mail -s 'clabure restarted' xslaby
done
