#!/usr/bin/env bash

git fetch origin main && git checkout FETCH_HEAD -B main && git pull && mix deps.get && mix escript.build
