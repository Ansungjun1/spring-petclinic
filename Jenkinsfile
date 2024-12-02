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

  }
}
