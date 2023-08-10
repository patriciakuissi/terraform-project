pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from a Git repository
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                // Build your application here
                sh 'echo "Building  application..."'
            }
        }
         stage('SonarQube analysis') {
            agent {
                docker {
                  image 'sonarsource/sonar-scanner-cli:4.7.0'
                }
               }
               environment {
        CI = 'true'
        //  scannerHome = tool 'Sonar'
        scannerHome='/opt/sonar-scanner'
    }
            steps{
                withSonarQubeEnv('Sonar') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }       
        
        stage('Test') {
            steps {
                // Run tests for your application
                sh 'echo "Running tests..."'
            }
        }
        
        stage('Deploy') {
            steps {
                // Deploy your application (this is a placeholder, you'd configure your actual deployment process)
                sh 'echo "Deploying the application..."'
            }
        }
    }
    
  
}
