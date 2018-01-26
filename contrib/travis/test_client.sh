#!/bin/sh

set -x

cd examples
export PATH=$HOME/bogus/bin:$PATH

make -n client
pcc -showme -o client client.c
ls -l $HOME/bogus/lib
ldd client
ldd $HOME/bogus/lib/libpmix.so
ldd $HOME/bogus/lib/libpsrvopen-pal.so
ldd $HOME/bogus/lib/libpsrvopen-rte.so
nm $HOME/bogus/lib/libpsrvopen-pal.so | grep libevent

psrvr &
# wait a little for the server to start
sleep 2
prun --oversubscribe -n 2 ./client
ret=$?

prun --terminate

exit $ret
