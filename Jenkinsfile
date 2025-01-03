pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'DockerHub'  // Tên credentials trong Jenkins
        DOCKER_IMAGE_NAME = '22127279/mmtnc_devops' // Tên Docker repository
        DOCKER_TAG = 'latest'  // Tag của Docker image
    }

    stages {
        stage('Checkout') {
            steps {
                // Kiểm tra mã nguồn từ Git repository
                git 'https://github.com/22127021-22127235-22127279/mmtnc_devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    bat "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        bat """
                            echo %{DOCKER_PASSWORD} | docker login -u %DOCKER_USERNAME% --password-stdin
                        """
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push Docker image lên Docker Hub
                    bat "docker push ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}"
                }
            }
        }
    }
}
