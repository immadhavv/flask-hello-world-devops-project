pipeline {
   agent any
  
   environment {
       DOCKER_HUB_REPO = "madhav6798/cicd:flask-hello-world"
       CONTAINER_NAME = "flask-hello-world"
       DOCKERHUB_CREDENTIALS=credentials('dockerhubcredentials')
       DOCKERPATH ='/usr/local/bin/docker'
       MINIKUBEPATH = '/usr/local/bin/minikube'
   }
  
   stages {
      stage('Checkout') {
          steps {
              checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/immadhavv/flask-hello-world-devops-project']]])
          }
      }
       stage('Build') {
           steps {
               echo 'Building..'
               sh '$DOCKERPATH image build -t $DOCKER_HUB_REPO .'
           }
       }
       stage('Test') {
           steps {
               echo 'Testing..'
               sh '$DOCKERPATH stop $CONTAINER_NAME || true'
               sh '$DOCKERPATH rm $CONTAINER_NAME || true'
               sh '$DOCKERPATH run --name $CONTAINER_NAME $DOCKER_HUB_REPO /bin/bash -c "pytest test.py && flake8"'
           }
       }
       stage('Push') {
            steps {
                echo 'Pushing image..'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | $DOCKERPATH login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh '$DOCKERPATH push $DOCKER_HUB_REPO'
            }
        }
       stage('Deploy') {
           steps {
               echo 'Deploying....'
               sh '$MINIKUBEPATH kubectl -- apply -f deployment.yaml'
               sh '$MINIKUBEPATH kubectl -- apply -f service.yaml'
           }
       }
       
   }
}