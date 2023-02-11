#!groovy

import groovy.json.JsonSlurperClassic

// -------------------------------------------------------------------------
    // Check out code from source control.
    // -------------------------------------------------------------------------
pipeline{
   stages{
         stage('checkout source') {
                   steps{
                         checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/anant338/SFDevelopment.git']]])
                   }
              }
    
          stage('Get CLI from Docker'){
              script{
                   sh "docker pull salesforce/salesforcedx:latest-rc-slim"
                   sh "docker run -it salesforce/salesforcedx:latest-rc-slim"
                }
              }
         stage('Test SFDX'){
                  sfdx version
             }
      }
   }   
