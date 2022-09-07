#!/bin/bash

touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp

cd /sources/lfs

for package in \
    gettext \
    bison \
    perl \
    Python \
    texinfo \
    util-linux; do
    source /sources/lfs/compile-package.sh 7 $package
done
exit
