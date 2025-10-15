pipeline {
  agent any

  environment {
    DOCKER_IMAGE = "oxydoxy/my-web-app"
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/0xy-doxy/EXP_8.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh 'docker build -t $DOCKER_IMAGE .'
        }
      }
    }

    stage('Push to DockerHub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-cred',
          usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
          sh 'docker push $DOCKER_IMAGE'
        }
      }
    }

    stage('Deploy Container') {
      steps {
        sh 'docker rm -f my-web-app-container || true'
        sh 'docker run -d -p 8080:80 --name my-web-app-container $DOCKER_IMAGE'
      }
    }
  }

  post {
    success { echo "✅ CI/CD pipeline completed successfully!" }
    failure { echo "❌ Pipeline failed!" }
  }
}
