  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build --tag dev_connect:3.0.1 .'
        sh 'docker run -p 5000:5000 --name dev_connect -v dev_connect_data:/usr/src/app dev_connect:3.0.1'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
      // stage('Test') {
    //   steps {
    //     sh 'touch test.sh'
    //     sh 'docker run -p 8000:8000 --name dev_connect dev_connect:2.0.1 test > test.sh'
    //   }
    // }
    stage('Push') {
      steps {
        sh 'gcloud auth configure-docker us-west1-docker.pkg.dev'
        sh 'docker tag dev_connect:2.0.1 us-west1-docker.pkg.dev/devconnect-final-project/chaya-lipshitz-artifacts/dev_connect:2.0.1'
        sh 'docker push us-west1-docker.pkg.dev/devconnect-final-project/chaya-lipshitz-artifacts/dev_connect:2.0.1'
      }
    }
  }
  
  post {
    always {
      sh 'docker logout'
    }
  }
