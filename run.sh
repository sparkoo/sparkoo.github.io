#!/bin/bash

docker run --rm --volume="${PWD}:/usr/src/app" -p 4000:4000 -it starefossen/github-pages
