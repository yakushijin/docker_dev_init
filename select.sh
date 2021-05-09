#!/bin/bash
if [ $# = 0 ]; then
    echo 引数が無い
    exit 1
fi

if [ $# -gt 1 ]; then
    echo 引数が多い
    exit 1
fi

if [ -e ./dockerComposes/${1} ]; then
    rm -fR ./src
    mkdir -p ./src
    cp -pf ./dockerComposes/${1}/docker-compose.yml .
    cp -pf ./dockerComposes/${1}/Makefile .
else
    echo ディレクトリが存在しない
    exit 1
fi
