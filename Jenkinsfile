def SendSlackMessage(message, color) {
    slackSend (channel: "$SLACK_CHANNEL", color: color, message: "$message: Job '${JOB_NAME} [${BUILD_NUMBER}]' (${BUILD_URL})")
}

@NonCPS
def getBuildCause() {
    def cause = ''
    try {
        for (buildCause in currentBuild.buildCauses) {
            if (buildCause != null) {
                echo "Build cause description: ${currentBuild.buildCauses}"
                description = buildCause.shortDescription
                if (description.contains("Branch indexing")) {
                    cause = 'indexing'
                }
                if (description.contains("Started by user")) {
                    cause = 'user'
                }
                if (description.contains("Push event")) {
                    cause = 'push'
                }
            }
        }
    } catch(msg) {
        echo "Error getting build cause: ${msg}"
    }
    return cause
}

def getHost() {
    return "ubuntu@app-skyexpo"
}

pipeline {
    agent any
    options {
        disableConcurrentBuilds()
        parallelsAlwaysFailFast()
    }

    environment {
        BUILD_CAUSE = getBuildCause()
        PROJECT_NAME = 'skyexpo-matchmaking'
        SLACK_CHANNEL = 'p-skyexpo-matchmaking-dev'
        SSH_HOST = 'ubuntu@app-skyexpo'
    }

    stages {
        stage('slack notification') {
            steps {
                script {
                    if (env.BUILD_CAUSE == 'user') {
                        SendSlackMessage('DEPLOYING', '#0000FF')
                    } else {
                        SendSlackMessage('TESTING', '#0000FF')
                    }
                }
            }
        }

        stage('run tests') {
            stages {
                stage('backend') {
                    steps {
                        sh 'dump-env -t ./backend/config/.env.template -p "SECRET_" > ./backend/config/.env'
                        sh 'docker-compose -f docker-compose.yml -f docker-compose.prod.yml config --quiet'
                        sh 'docker-compose run --rm web sh ./docker/ci.sh'
                    }
                }
            }
        }

        stage('deploy') {
            when {
                allOf {
                    expression { env.BUILD_CAUSE == 'user' }
                    expression { currentBuild.currentResult == 'SUCCESS' }
                }
            }
            stages {
                stage('copy project to lxc') {
                    steps {
                        sshagent(['49ae3b50-fc13-4072-9794-b308d96bc51d']) {
                            sh 'ssh -o StrictHostKeyChecking=no $SSH_HOST uptime'
                            sh 'rsync -rlptgDvz --exclude=node_modules --exclude=__pycache__ --exclude=/reports . $SSH_HOST:/home/ubuntu/$PROJECT_NAME'
                        }
                    }
                }
                stage('build images') {
                    steps {
                        sshagent(['49ae3b50-fc13-4072-9794-b308d96bc51d']) {
                            sh 'ssh -o StrictHostKeyChecking=no $SSH_HOST uptime'
                            sh "ssh -A $SSH_HOST 'cd /home/ubuntu/$PROJECT_NAME; docker-compose -f docker-compose.yml -f docker-compose.prod.yml build'"
                            sh """ssh -A $SSH_HOST 'cd /home/ubuntu/$PROJECT_NAME; dump-env -t ./backend/config/.env.template -p "SECRET_" --strict=SECRET_DJANGO_SECRET_KEY > ./backend/config/.env'"""
                        }
                    }
                }
                stage('start project') {
                    steps {
                        sshagent(['49ae3b50-fc13-4072-9794-b308d96bc51d']) {
                            sh 'ssh -o StrictHostKeyChecking=no $SSH_HOST uptime'
                            sh "ssh -A $SSH_HOST 'cd /home/ubuntu/$PROJECT_NAME; docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d'"
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            script {
                if (env.BUILD_CAUSE == 'user') {
                    SendSlackMessage('DEPLOYED', '#00FF00')
                } else {
                    SendSlackMessage('TESTS OK', '#00FF00')
                }
            }
        }
        unstable {
            SendSlackMessage('TESTS FAILED', '#FF0000')
        }
        failure {
            SendSlackMessage('BUILD FAILED', '#FF0000')
        }
        always {
            script {
                try {
                    build job: 'CleanUp', propagate: false, wait: false
                } catch(err) {
                    echo "CleanUp not started: ${err}"
                }
            }
        }
    }
}