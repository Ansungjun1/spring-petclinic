pipeline{
  agent any

  tools {
    jdk 'JDK17'
    maven 'M3'
  }

  environment{
    DOCKERHUB_CREDENTIALS = credentials('dockerCredential')
    AWS_CREDENTIALS = credentials('AWSCredential')
    //GIT_CREDENTIALS = credentials('gitCredential')
    REGION = 'ap-northeast-2'
  }

  stages {
    stage ('Git Clone'){
      steps{
        echo 'Git Clone'
        git url: 'https://github.com/Ansungjun1/spring-petclinic.git',
          branch: 'main', credentialsId: 'GIT_CREDENTIALS'
      }
    }
    stage('Maven Build'){
      steps{
        echo 'Maven Build'
        sh 'mvn -Dmaven.test.failure.ignore=true clean package'
      }
    }
    stage('Docker Image Build'){
      steps{
        echo 'Docker Iamge Build'
        dir("${env.WORKSPACE}"){
          sh """
          docker build -t ansungjun/spring-petclinic:$BUILD_NUMBER .
          docker tag ansungjun/spring-petclinic:$BUILD_NUMBER ansungjun/spring-petclinic:latest
          """
        }
      }
    }
    stage('Docker Login'){
      steps{
        sh """
        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
        docker push ansungjun/spring-petclinic:latest
        """
      }
    }
    stage('Remove Docker Image'){
      steps{
        sh """
        docker rmi ansungjun/spring-petclinic:$BUILD_NUMBER
        docker rmi ansungjun/spring-petclinic:latest
        """
      }
    }
    stage('Upload to S3') {
      steps {
        echo "Upload to S3"
        dir("${env.WORKSPACE}") {
          sh 'zip -r deploy.zip ./deploy AppSpec.yml'
          withAWS(region:"${REGION}", credentials:"${AWS_CREDENTIALS}"){
            s3Upload(file:"deploy.zip", bucket:"user19-codedeploy-bucket")
          }
          sh 'rm -rf ./deploy.zip'                 
        }
      }
    }
  }
}
