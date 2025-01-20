pipeline{
  agent any

  tools {
    jdk 'JDK17'
    maven 'M3'
  }

  environment{
    DOCKERHUB_CREDENTIALS = credentials('dockerCredential')
    AWS_CREDENTIALS = credentials('AWSCredential')
    GIT_CREDENTIALS = credentials('gCredential')
    REGION = 'ap-northeast-2'
  }

  stages {
    stage ('Git Clone'){
      steps{
        echo 'Git Clone'
        git url: 'https://github.com/Ansungjun1/spring-petclinic.git',
          branch: 'main', credentialIdL: 'GIT_CREDENTIALS'
      }
    }
  }
}
