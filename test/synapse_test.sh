#!/usr/bin/env bash
git clone https://github.com/vertexproject/synapse.git -v ./synapse
cd ./synapse
git checkout msgpack_prep
pytest -v -s --disable-warnings --durations 6 --maxfail 6
exit $?
