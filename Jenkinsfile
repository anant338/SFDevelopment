#!groovy

import groovy.json.JsonSlurperClassic

    def SF_CONSUMER_KEY='3MVG9kBt168mda_8xf5Uf0E_8NG68WIoOcS8YF6mjB9nimUO4rZuDhneuZqE3B1yyv4hQI1dnvZjxUW2gxQhK'
    def SF_USERNAME='anantfromdbg@gmail.com'
    def SERVER_KEY_CREDENTALS_ID='34fa2a72-30ba-419a-bf54-39a2594bc2cd'
    def TEST_LEVEL='RunLocalTests'
    def SF_INSTANCE_URL = 'https://login.salesforce.com'

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
                            bat 'docker pull salesforce/salesforcedx:latest-rc-slim'
                            bat 'docker run --name SFCLI -i -d salesforce/salesforcedx:latest-rc-slim bash'
                            bat 'docker ps'   
                           } 
                        catch(Error) {
                             echo 'Salesforce CLI is not running'
                             bat 'docker stop SFCLI'
                             bat 'docker rm SFCLI'
                             bat 'docker pull salesforce/salesforcedx:latest-rc-slim'
                             bat 'docker run --name SFCLI -i -d salesforce/salesforcedx:latest-rc-slim bash'
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
                  if(isUnix()){
                   rc=sh returnStatus: true, script: 'docker exec -i SFCLI sfdx auth:jwt:grant --instanceurl ${SF_INSTANCE_URL} --clientid ${SF_CONSUMER_KEY} --username ${SF_USERNAME} --jwtkeyfile ${SERVER_KEY_CREDENTALS_ID} --setdefaultdevhubusername'
                  } else {
                    rc=bat returnStatus: true, script: 'docker exec -i SFCLI bin/bash sfdx auth:jwt:grant --instanceurl ${SF_INSTANCE_URL} --clientid ${SF_CONSUMER_KEY} --username ${SF_USERNAME} --jwtkeyfile \"${SERVER_KEY_CREDENTALS_ID}\" --setdefaultdevhubusername'  
                  } 
                  if(rc != 0) {error 'Org Authorization failed'}
                  }
                  echo rc
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
