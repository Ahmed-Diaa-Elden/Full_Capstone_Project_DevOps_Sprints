pipeline {
    agent any

    stages {
        // stage('Preparation') {
        //     steps {
        //         echo 'prepare github repo....'
        //         git branch: 'main', url: 'https://github.com/Ahmed-Diaa-Elden/Full_Capstone_Project_DevOps_Sprints'
        //     }
        // }
        stage('Build-client') {
            steps {
                echo 'building flask-app image....'
                sh "docker build Project/. -t 244282014725.dkr.ecr.us-east-1.amazonaws.com/sprints-ecr:${env.BUILD_NUMBER}"
            }
        }

        // stage('artifact-client') {
        //     steps {
        //         echo ' pushing client image into docker repo...'
        //         withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        //             sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
        //             sh "docker push mohamedswelam/client:${env.BUILD_NUMBER}"
        //         }
        //     }
        // }
        stage('artifact-client') {
            steps {
                echo ' pushing client image into ECR repo...'
                    sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 244282014725.dkr.ecr.us-east-1.amazonaws.com"
                    sh "docker push 244282014725.dkr.ecr.us-east-1.amazonaws.com/sprints-ecr:${env.BUILD_NUMBER}"
            }
        }

        stage('updating deployment files') {
            steps {
                echo 'replacing old images with the new one'
                sh "sed -i \"s|image:.*|image: 244282014725.dkr.ecr.us-east-1.amazonaws.com/sprints-ecr:${env.BUILD_NUMBER}|g\" k8s/flask_app.yaml"
            }
        }

        stage('Deploy to EKS') {
            steps {
                echo 'Deploying to minikube'
                sh 'aws eks --region us-east-1 update-kubeconfig --name pc-eks'
                sh 'cd k8s'
                sh 'kubectl apply -f pv.yaml'
                sh 'kubectl apply -f config.yaml'
                sh 'kubectl apply -f service_headless.yaml'
                sh 'kubectl apply -f secret.yaml'
                sh 'kubectl apply -f statefulset.yaml'
                sh 'kubectl apply -f service_flask.yaml'
                sh 'kubectl apply -f flask_app.yaml'
                echo 'Getting nodes info'
                sh 'kubectl get no -o wide'
                echo 'Getting podes info'
                sh 'kubectl get po -o wide'
                sh 'cd ..'
            }
        }
    }
}