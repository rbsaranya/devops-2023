pipeline {
    agent any

    stages {
        stage('terraform init') {
            steps {
                cd terraform/dev
                terraform init
            }
        }
        stage('terraform plan') {
            steps {
                echo 'terraform plan'
            }
        }
        stage('terraform apply') {
            steps {
                echo 'terraform apply'
            }
        }
    }
}
