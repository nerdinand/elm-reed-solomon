#!/bin/bash

set -ex

pushd tests
elm-make TestRunner.elm --output tests.js
node tests.js
popd
