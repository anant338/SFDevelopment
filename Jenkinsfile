#!groovy

import groovy.json.JsonSlurperClassic

    def SF_CONSUMER_KEY='3MVG9kBt168mda_8xf5Uf0E_8NG68WIoOcS8YF6mjB9nimUO4rZuDhneuZqE3B1yyv4hQI1dnvZjxUW2gxQhK'
    def SF_USERNAME='anantfromdbg@gmail.com'
    def SERVER_KEY_CREDENTALS_ID='7d0dbdb9-c9ee-4524-9c3a-e0d07113dad7'
    def TEST_LEVEL='RunLocalTests'
    def SF_INSTANCE_URL = 'https://login.salesforce.com/'

pipeline{
  
    agent any
    
      stages{
          
    
       // -------------------------------------------------------------------------
       // Check out code from source control.
       // -------------------------------------------------------------------------
         stage('checkout source') {
                   steps{
                         checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/anant338/SFDevelopment.git']]])
                   }
              }
    
          stage('Get CLI from Docker'){
              steps{  
                  script {    
                     try{
                            bat 'docker pull salesforce/salesforcedx:latest-slim'
                            bat 'docker run --name SFCLI -i -d salesforce/salesforcedx:latest-slim bash'
                            bat 'docker ps'   
                           } 
                        catch(Error) {
                             echo 'Salesforce CLI is not running'
                             bat 'docker stop SFCLI'
                             bat 'docker rm SFCLI'
                             bat 'docker pull salesforce/salesforcedx:latest-slim'
                             bat 'docker run --name SFCLI -i -d salesforce/salesforcedx:latest-slim bash'
                             bat 'docker ps'
                           }
                     }
                  }
          }
      
          
       stage('Test SFDX'){
             steps{
                   bat 'docker exec -i SFCLI bin/bash sfdx version'
                   
                 }
             }

          stage('Authorize Dev Org'){
              steps{
                  script{
                 withEnv(["HOME=${env.WORKSPACE}"]) {
                 withCredentials([file(credentialsId: '7d0dbdb9-c9ee-4524-9c3a-e0d07113dad7', variable: 'jwt_key_file')]) {
                    // script{ 
                         //print ${jwt_key_file}
                   //      def key_file = "\"+${jwt_key_file}+"\"
                   //    }
                  if(isUnix()){
                   rc=sh returnStatus: true, script: 'docker exec -i SFCLI sfdx auth:jwt:grant --instanceurl ${SF_INSTANCE_URL} --clientid ${SF_CONSUMER_KEY} --username ${SF_USERNAME} --jwtkeyfile ${jwt_key_file}'
                  } else {
                        //rc=bat returnStatus: true, script: 'docker exec -i SFCLI sfdx force:auth:jwt:grant --jwtkeyfile \"${jwt_key_file}\" --instanceurl https://login.salesforce.com --clientid ${SF_CONSUMER_KEY} --username ${SF_USERNAME}' 
                         bat 'docker exec -i SFCLI sfdx force:auth:jwt:grant --jwtkeyfile ${jwt_key_file} --instanceurl https://login.salesforce.com --clientid ${SF_CONSUMER_KEY} --username ${SF_USERNAME}'    
                       } 
                           if(rc != 0) {error 'Org Authorization failed'}
                     } //-withCredentials 
                    } //-WithEnv
                  } //--script
                  echo rc
                } //--steps
          } //--stage
        
       
         stage('Job Complete'){
             steps{
                  bat 'docker stop SFCLI'
                  bat 'docker rm SFCLI'
                  echo 'Job Complete'
             }
           }
          
              
    
      } //--Stages
    
   } //--Pipeline  
