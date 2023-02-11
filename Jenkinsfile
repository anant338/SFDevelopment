#!groovy

import groovy.json.JsonSlurperClassic

// -------------------------------------------------------------------------
    // Check out code from source control.
    // -------------------------------------------------------------------------
pipeline{
    agent{
        docker { image 'salesforce/salesforcedx:7.188.1-slim' }
    }
   stages{
         stage('checkout source') {
                   steps{
                         checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/anant338/SFDevelopment.git']]])
                   }
              }
    
          stage('Get CLI from Docker'){
              steps{
                        sh 'docker images' 
                       
                   }
              }
         stage('Test SFDX'){
             steps{
                   sh "sfdx version"  
                }
             }
      }
   }   
