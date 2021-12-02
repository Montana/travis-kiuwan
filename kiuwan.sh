#!/bin/bash

  echo $TRAVIS_BUILD_DIR
  export APPNAME=$(basename $TRAVIS_BUILD_DIR)
  export BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
  wget -v https://www.kiuwan.com/pub/analyzer/KiuwanLocalAnalyzer.zip
  unzip KiuwanLocalAnalyzer.zip -d $HOME/.
  $HOME/KiuwanLocalAnalyzer/bin/agent.sh --user $kiuwan_user --pass $kiuwan_password -s $TRAVIS_BUILD_DIR -n $APPNAME -l $TRAVIS_BUILD_ID -c
