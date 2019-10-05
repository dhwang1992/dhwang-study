#!/bin/sh

APP_NAME=dhwang-study


test() {
    echo 'execute go test'
    ./gradlew test
}

build() {
    echo 'execute go build'
    DOCKER_REGISTRY_SERVER='http://localhost:5000'
    DOCKER_REGISTRY_NAME=$(echo $DOCKER_REGISTRY_SERVER | sed 's~http[s]*://~~g')
    DOCKER_USER='admin'
    DOCKER_PASSWORD='admin123'
    CI_COMMIT_SHA=${GIT_COMMIT:=$(git log -n 1 --pretty=format:'%h')}
    IMAGE_TAG="$CI_COMMIT_SHA"

    ./gradlew clean -x test build
    jarName=`./gradlew -q printJarName`
    docker build --build-arg jarName="build/libs/$jarName" -t $DOCKER_REGISTRY_NAME/$APP_NAME:$IMAGE_TAG .

    # push镜像
    docker login --username=$DOCKER_USER --password=$DOCKER_PASSWORD $DOCKER_REGISTRY_SERVER
    docker push $DOCKER_REGISTRY_NAME/$APP_NAME:$IMAGE_TAG
    docker rmi $DOCKER_REGISTRY_NAME/$APP_NAME:$IMAGE_TAG
}

deploy() {
    echo 'execute go deploy'
    DOCKER_REGISTRY_SERVER='http://localhost:5000'
    DOCKER_REGISTRY_NAME=$(echo $DOCKER_REGISTRY_SERVER | sed 's~http[s]*://~~g')
    CI_COMMIT_SHA=${GIT_COMMIT:=$(git log -n 1 --pretty=format:'%h')}
    IMAGE_TAG="$CI_COMMIT_SHA"
    ENV=${ENV:=dev}
    docker run -d -p 10000:10000 --name $APP_NAME $DOCKER_REGISTRY_NAME/$APP_NAME:$IMAGE_TAG
}

case $1 in
 test|build|deploy|deploy_local_k8s )
   $1;;
 * )
   echo "not support!!! example: go <test|build|deploy>"
   exit 1;;
esac
