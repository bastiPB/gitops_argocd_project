pipeline {

    agent any

    environment{

        DOCKERHUB_USERNAME = "bastipb"
        APP_NAME = "gitops-argo-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKER_USERNAME}" + "/" + "${APP_NAME}"
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
    }
}

//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 
