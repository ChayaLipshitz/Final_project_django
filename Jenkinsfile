pipeline{
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'ps'
                sh 'docker stop dev_connect'
                sh 'docker rm dev_connect'
                sh 'docker build --tag dev_connect:3.0.1 .'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run -p 5000:5000 --name dev_connect -d -v dev_connect_data:/usr/src/app dev_connect:3.0.1'
            }
        }
        stage('Test') {
          steps {
            sh 'echo testing...'
            sh 'docker exec  -it dev_connect python django_web_app/manage.py test'
          }
        }
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
}