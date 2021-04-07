#!/usr/bin/env sh

rm -rf assets;
mkdir assets;
cd assets;
LATEST=$(wget https://api.github.com/repos/evansiroky/timezone-boundary-builder/releases/latest -q -O - | grep -m 1 -o 'https.*timezones-with-oceans.geojson.zip')
wget $LATEST;
unzip -j timezones-with-oceans.geojson.zip;
ln -s combined-with-oceans.json timezones-with-oceans.geojson;
cd ..;

./tz-service &

while true; do
    echo "Checking for assets/timezone.snap.json...";
    test -f assets/timezone.snap.json && break;
    sleep 1;
done;

echo "Assets ready.";

killall tz-service;

rm assets/*oceans*
