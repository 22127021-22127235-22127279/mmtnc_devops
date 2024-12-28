pipeline {
    agent any

    environment {
        // Đặt các biến môi trường cần thiết
        DOCKER_IMAGE = 'meow-web'   // Tên image Docker
        DOCKER_REGISTRY = 'dockerhub-username' // Thay bằng username Docker Hub
        GIT_REPO = 'https://github.com/dlhmy22/meow' // Đường dẫn GitHub
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Lấy mã nguồn từ GitHub
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build Application') {
            steps {
                // Cài đặt dependencies hoặc build
                script {
                    if (fileExists('package.json')) {
                        sh 'npm install'  // Dành cho ứng dụng Node.js
                    } else if (fileExists('requirements.txt')) {
                        sh 'pip install -r requirements.txt'  // Dành cho Python
                    } else {
                        echo 'Không phát hiện file để build'
                    }
                }
            }
        }

        stage('Test Application') {
            steps {
                // Chạy thử nghiệm nếu có
                script {
                    if (fileExists('package.json')) {
                        sh 'npm test'  // Chạy test cho ứng dụng Node.js
                    } else {
                        echo 'Không phát hiện file để test'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                sh """
                docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest .
                """
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    // Login Docker Hub và push image
                    sh """
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest
                    """
                }
            }
        }

        stage('Deploy Application') {
            steps {
                // Chạy container từ image trên Docker
                sh """
                docker stop meow-web || true
                docker rm meow-web || true
                docker run -d --name meow-web -p 8080:8080 ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest
                """
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Check logs.'
        }
    }
}
