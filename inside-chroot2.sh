#!/bin/bash

touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp

for package in \
    gettext \
    bison \
    perl \
    Python \
    texinfo \
    util-linux; do
    source ./compile-package.sh 7 $package
done
