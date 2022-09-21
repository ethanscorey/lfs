#!/bin/bash
rm -rf /tmp/*
find /usr/lib /usr/libexec -name \*.la -delete
find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf
userdel -r tester
# tester doesn't own its home directory, so we need to manually delete
rm -rf /home/tester
exit
