#!/usr/bin/env bash

/setup/scripts/install-riak-python-client.sh

sudo dpkg -P riak
sudo dpkg -i /setup/riak-ts/riak-ts_1.0.0-1_amd64.deb

/setup/scripts/quick-configure-riak-2-pkg.sh

# initial table setup
sudo su riak
riak-admin bucket-type create GeoCheckin '{"props":{"table_def": "CREATE TABLE GeoCheckin (myfamily varchar not null, myseries varchar not null, time timestamp not null, weather varchar not null, temperature double, PRIMARY KEY ((myfamily, myseries, quantum(time, 15, 'm')), myfamily, myseries, time))"}}'
riak-admin bucket-type activate GeoCheckin
riak-admin bucket-type status GeoCheckin