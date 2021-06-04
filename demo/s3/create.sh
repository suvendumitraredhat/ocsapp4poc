#!/bin/bash
curl -L -s https://github.com/red-hat-storage/demo-apps/blob/main/packaged/photo-album.tgz?raw=true | tar xvz
cd photo-album/
./demo.sh
oc -n demo get pods
oc -n demo get obc

