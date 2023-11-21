pipeline {

    agent any

    environment{

        DOCKERHUB_USERNAME = "bastipb"
        APP_NAME = "gitops-argo-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}" + "/" + "${APP_NAME}"
        REGISTRY_CREDS = 'dockerhub'
    }
    
    stages{

        stage('Cleanup Workspace'){
            steps{
                script{

                    cleanWs()
                }
            }
        }
        stage('Checkout Code'){
            steps {
                script{

                    git credentialsId: 'github',
                    url: 'https://github.com/bastiPB/gitops_argocd_project.git',
                    branch: 'main'
                }
            }
        }
        stage('Build Docker Image'){
            steps{
                script{

                    docker_image = docker.build "${IMAGE_NAME}"
                }
            }
        }
        stage('Push Docker Image to DockerHUB'){
            steps{
                script{
                    
                    docker.withRegistry('',REGISTRY_CREDS){

                        docker_image.push("$BUILD_NUMBER")
                        docker_image.push('latest')
                    }      
                }
            }
        }
        stage('Delete Docker images'){
            steps{
                script{

                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:latest"
                }
            }
        }
        stage('Updating k8s deployment file'){
            steps{
                script{

                    sh """
                    cat deployment.yml
                    sed -i 's/${APP_NAME}.*/s${APP_NAME}:${IMAGE_TAG}/g' deployment.yml
                    cat deployment.yml

                    """
                }
            }
        }
    }
}
