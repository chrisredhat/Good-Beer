#!/bin/bash

# all plugin section in build.gradle

if grep 'plugins { id' build.gradle; then
  echo "plugin section already exists"
else
  gsed -i "s/^allprojects/plugins { id \"org.sonarqube\" version \"2.7\" } \n\nallprojects/" build.gradle
fi
