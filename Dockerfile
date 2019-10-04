FROM openjdk:8-jre-slim


#COPY 和 ADD 区别，官方更推荐使用COPY 单纯的复制文件以及相关权限，而ADD
#使用了一些额外的功能，例如解压等

COPY build/libs/dhwang-study-1.0-SNAPSHOT.jar ./app.jar

#CMD exec 格式：["可执行文件", "参数1", "参数2"...]
# shell 格式：CMD <命令>
#指令就是用于指定默认的容器主进程的启动命令的

#CMD 和 ENTRYPOINT命令实现的功能一样，都是定义容器的主进程启动命令
#docker run nginx -i 后面的-i会自己作为CMD传递到容器里面变成
#ENTRYPOINT "CMD"
#当容器在执行一些命令之前需要做一些数据初始化的工作,可以使用ENTRYPOINT
#ENTRYPOINT["init-data.sh"]
#CMD ["redis-server", "a" ,"b"]
ARG jarName

ENV SPRING_PROFILES_ACTIVE=local
ENV APP_JAR=app.jar

#ENV NODE_VERSION=7.2.0 NODE_VERSION1=7.2.1



#构建参数和 ENV 的效果一样，都是设置环境变量。所不同的是，
#ARG 所设置的构建环境的环境变量，在将来容器运行时是不会存在这些环境变量的。
#
#在 1.13 之前的版本，要求 --build-arg 中的参数名，必须在 Dockerfile 中用 ARG 定义过了，
#换句话说，就是 --build-arg 指定的参数，必须在 Dockerfile 中使用了。
#如果对应参数没有被使用，则会报错退出构建。从 1.13 开始，这种严格的限制被放开，不再报错退出，
#而是显示警告信息，并继续构建。这对于使用 CI 系统，用同样的构建流程构建不同的
#Dockerfile 的时候比较有帮助，避免构建命令必须根据每个 Dockerfile 的内容修改。

VOLUME /data
#这里的 /data 目录就会在运行时自动挂载为匿名卷，任何向 /data 中写入的信息都不会记录进容器存储层，
#从而保证了容器存储层的无状态化。当然，运行时可以覆盖这个挂载设置。

CMD ["sh", "-c", "java -XX:MetaspaceSize=256M -Xms1024M -Dfile.encoding=UTF-8 -Djava.security.egd=file:/dev/./urandom -Duser.timezone=Asia/Shanghai -jar /$APP_JAR"]

#docker build 命令该如何写
#docker build --build-arg jarName="build/libs/$jarName"
#--build-arg mockServerJarName="mock-server/build/libs/$mockServerJarName" -t $APP_NAME:$IMAGE_TAG .



