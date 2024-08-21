pipeline {
    agent any
     environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY_ID')
        
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        // stage('Terraform Plan') {
        //     steps {
        //         script {
        //             sh 'terraform plan '
        //         }
        //     }
        // }
        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply --auto-approve '
                }
            }
        }
        
    }
    post {
        always {
            cleanWs()
        }
    }
}       