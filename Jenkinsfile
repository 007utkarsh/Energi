pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE_TAG = "latest"  // Tag for the Docker image
        ENERGI_VERSION = "v1.1.7"    // Version of the Energi client
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t your-docker-image-name:${DOCKER_IMAGE_TAG} ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to a registry (e.g., Docker Hub)
                    sh "docker push your-docker-image-name:${DOCKER_IMAGE_TAG}"
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Apply Kubernetes manifests
                    sh "kubectl apply -f your-kubernetes-manifest.yaml"
                }
            }
        }
    }
}
