pipeline {
    agent any

    tools {nodejs "node" }

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        
        stage('checkout') {
            steps {
                echo 'git clone'
                git branch : "master" , url: "https://github.com/RizkyRajitha/dockernetworkdemo.git"
            }
        }
        
        stage('npm install') {
            steps {
                echo 'npm install'
                sh "npm i"
            }
        }
    }
}
