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
                 script{
                        rc=command "docker pull salesforce/salesforcedx:latest-rc-slim"
                        rc=command "docker run -it salesforce/salesforcedx:latest-rc-slim"
                       }
                   }
              }
         stage('Test SFDX'){
             steps{
                 script{
                        rc=command "sfdx version"
                        echo rc
                      }
                }
             }
      }
   }   
