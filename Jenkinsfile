pipeline{
    agent any
    stages {
        stage('Build') {
            steps {
                env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B ${GIT_COMMIT}', returnStdout: true).trim()
                sh 'docker ps'
                // sh 'docker stop dev_connect'
                // sh 'docker rm dev_connect'
                sh 'docker build --tag dev_connect:$env.GIT_COMMIT_MSG .'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run -p 5000:5000 --name dev_connect -d -v dev_connect_data:/usr/src/app dev_connect:$env.GIT_COMMIT_MSG'
            }
        }
        stage('Test') {
          steps {
            sh 'echo testing...'
            sh 'docker exec dev_connect python django_web_app/manage.py test'
          }
        }
        stage('Push') {
            steps {
                sh 'gcloud auth configure-docker us-west1-docker.pkg.dev'
                sh 'docker tag dev_connect:$env.GIT_COMMIT_MSG us-west1-docker.pkg.dev/devconnect-final-project/chaya-lipshitz-artifacts/dev_connect:$env.GIT_COMMIT_MSG'
                sh 'docker push us-west1-docker.pkg.dev/devconnect-final-project/chaya-lipshitz-artifacts/dev_connect:$env.GIT_COMMIT_MSG'
            }
        }
    }

    post {
        always {
        sh 'docker logout'
        }
    }
}