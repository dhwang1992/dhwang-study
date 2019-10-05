#!/bin/sh

APP_NAME=dhwang-study


test() {
    echo 'execute go test'
    ./gradlew test
}

build() {
    echo 'execute go build'
    CI_COMMIT_SHA=${GIT_COMMIT:=$(git log -n 1 --pretty=format:'%h')}
    IMAGE_TAG="$CI_COMMIT_SHA"
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
