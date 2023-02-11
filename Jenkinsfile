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
                   }
              }
         stage('Test SFDX'){
             steps{
                   bat 'sfdx version' 
                }
             }
      }
   }   
