#!groovy

import groovy.json.JsonSlurperClassic

// -------------------------------------------------------------------------
    // Check out code from source control.
    // -------------------------------------------------------------------------
pipeline{
    agent any
      stages{
         stage('checkout source') {
                   steps{
                         checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/anant338/SFDevelopment.git']]])
                   }
              }
    
          stage('Get CLI from Docker'){
              steps{ 
                        bat 'docker pull salesforce/salesforcedx:latest-rc-slim'
                  try{
                        bat 'docker stop SFCLI'
                        bat 'docker rm SFCLI'
                        
                  } 
                  catch{
                        echo 'Salesforce CLI is not running'
                  }     
                        bat 'docker run --name SFCLI -i -d salesforce/salesforcedx:latest-rc-slim bash'
                        bat 'docker ps'
                        
                   }
              }
         stage('Test SFDX'){
             steps{
                   bat 'docker exec -i SFCLI bin/bash sfdx version'
                   
                 }
             }
         stage('Job Complete'){
             steps{
                  bat 'docker stop SFCLI'
                  bat 'docker rm SFCLI'
                  echo 'Job Complete'
             }
           }
      }
   }   
