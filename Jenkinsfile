#!/usr/bin/env groovy

pipeline {
  agent {
    docker {
      image 'ruby:2.6.1'
    }
  }

  stages {
    stage('requirements') {
      steps {
        sh 'gem install bundler'
      }
    }

    stage('build') {
      steps {
        sh 'bundle install'
      }
    }

    stage('test') {
      steps {
        sh 'cap frontend:dev deploy'
      }
    }
  }
}
