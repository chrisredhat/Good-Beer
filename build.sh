#!/bin/bash

build () {
  echo "environment: $environment $url"

  cp -vf src/providers/beer-service.ts_bak src/providers/beer-service.ts
  gsed -i "s|@@@app_server_url@@@|$url|" src/providers/beer-service.ts

  ionic cordova prepare android --release
  ionic cordova compile android --release -- -- --keystore='keystore.jks' --storePassword='0000abc!' --password='0000abc!' --alias='code-sign'

  mkdir -p test/android/app/$environment
  cp -vf platforms/android/app/build/outputs/apk/release/app-release.apk test/android/app/$environment/
}


if [ $# != 2 ]; then
  echo "Invalid number of argument"
  exit 2
fi

case $1 in
  dev|sit|uat|prod)
    environment="$1"
    url="$2"
    ionic cordova platform add android
    build $environment $url 
    ;;
  *)
    echo "Invalid environment name"
    exit 3
    ;;
esac		
