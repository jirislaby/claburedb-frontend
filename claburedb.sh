#!/bin/bash

bundle exec rails server -b 0.0.0.0 -e production
sleep 30
echo clabure restarted | mail -s 'clabure restarted' xslaby
exec $0
