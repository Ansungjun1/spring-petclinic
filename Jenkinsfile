pipeline{
  agent any

  tools {
    jdk 'jdk17'
    maven 'M3'
  }

  environment{
    DOCKERHUB_CREDENTIALS = credential('dockerCredentials')
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
        dir("${env.WORKSPACE}"){
          sh """
            docker build -t ansungjun/spring-petclinic:$BUILD_NUMBER .
            docker tag ansungjun/spring-petclinic:$BUILD_NUMBER ansungjun/spring-petclinic:latest
          """
        }
      }
    }
    stage ('Docker Image Push')
    {
      steps
      {
        sh """
          echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
          docker push ansungjun/spring-petclinic:latest
        """
      }
    }
    
  }
}
