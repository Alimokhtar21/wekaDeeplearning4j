#!/bin/bash

if [ -z $WEKA_HOME ]; then
    echo "make sure WEKA_HOME env variable is set!"
    exit 1
fi

export CLASSPATH=$WEKA_HOME/weka.jar

if [ $1 == "fresh" ]; then
    rm lib/*
    mvn clean
fi
mvn -Dmaven.test.skip=true install
ant -f build_package.xml clean
ant -f build_package.xml make_package -Dpackage=wekaDl4j
cd dist
java weka.core.WekaPackageManager -install-package wekaDl4j0.0.1.zip
