#!/bin/bash
REMOTE_SERVER=ztt-pct-db01.ztt.hs-worms.de

rsync -raz --delete ../ root@$REMOTE_SERVER:/tmp/gate-func-test/
ssh root@$REMOTE_SERVER "cd /tmp/gate-func-test/ && docker build -t gate-func-test . -f docker-image/Dockerfile && mkdir /tmp/output && docker run -v /tmp/output/:/output/ gate-func-test -swp -shp -swps"
