pipeline {
    agent any

    stages {
        stage('terraform init') {
            steps {
                sh "cd terraform/dev"
                sh "terraform init"
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
	stage('terraform validation') {
            steps {
                echo "terraform validate"
            }
	}
    }
}
