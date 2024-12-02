pipeline{
  agent any

  tools {
    jdk 'jdk17'
    maven 'M3'
  }

  stages {
    stage ('Git Clone') {
      steps {
        echo 'Git Clone'
        git url: 'https://github.com/Ansungjun1/spring-petclinic.git', branch: 'main'
      }
    }
    stage ('Maven Build')
    {
      steps
      {
        echo 'Maven Build'
        sh 'mvn -Dmaven.test.failure.ignore=true clean package'
      }
    }
    stage ('Docker Image')
    {
      steps
      {
        dir("${env.WORKSPACE"}){
          sh """
            docker buld -t ansungjun/spring-petclinic:$BUILD_NUMBER .
            docker tag ansungjun/spring-petclinic:$BUILD_NUMBER ansungjun/spring-petclinic:latest
          """
        }
        sh 'Docker 
      }
    }
  }
}
