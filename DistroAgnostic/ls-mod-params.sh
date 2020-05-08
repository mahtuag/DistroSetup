#!/bin/sh

# Taken from
# https://serverfault.com/questions/62316/how-do-i-list-loaded-linux-module-parameter-values

cat /proc/modules | cut -f 1 -d " " | while read module; do \
 echo "Module: $module"; \
 if [ -d "/sys/module/$module/parameters" ]; then \
  ls /sys/module/$module/parameters/ | while read parameter; do \
   echo -n "Parameter: $parameter --> "; \
   cat /sys/module/$module/parameters/$parameter; \
  done; \
 fi; \
 echo; \
done

