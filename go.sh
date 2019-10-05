#!/bin/sh

APP_NAME=dhwang-study


test() {
    echo 'execute go test'
    ./gradlew test
}

build() {
    echo 'execute go build $IMAGE_TAG'
    ./gradlew clean -x test build
    jarName=`./gradlew -q printJarName`
    docker build --build-arg jarName="build/libs/$jarName" -t $APP_NAME:$IMAGE_TAG .
}

deploy() {
    echo 'execute go deploy'
    ENV=${ENV:=dev}
    docker run --name $APP_NAME $APP_NAME:$IMAGE_TAG .
}

case $1 in
 test|build|deploy|deploy_local_k8s )
   $1;;
 * )
   echo "not support!!! example: go <test|build|deploy>"
   exit 1;;
esac
