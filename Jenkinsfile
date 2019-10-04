pipeline {
    //定义运行环境，一般是any 就是本机，也可以是docker 服务 ，node节点，kubernetes等
    agent any
    //agent docker {
    //}
    //构建超时时间为10分钟，重试次数为3
    options {
        timeout(time:10, unit: 'MINUTES')
        retry(3)
    }
    environment {
        SONAR_SERVER = 'http://localhost:9000'
    }
    //定义变量执行时，会让其先输入变量，使用变量的话，用${params.PerformMavenRelease}
    parameters {
        choice(name:'PerformMavenRelease',choices:'False\nTrue',description:'desc')
    }
    states {
        stage('build and test') {
            steps {
                 echo 'build and test'
                 echo '${SONAR_SERVER}'
            }

        }

        stage('deploy') {
            steps {
                echo 'deploy'
            }

        }
    }

}