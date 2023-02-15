#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME ='anantfromdbg@gmail.com'

    def HUB_ORG='anantfromdbg@gmail.com'
    def SFDC_HOST = 'https://login.salesforce.com'
    //def JWT_KEY_CRED_ID = '7d0dbdb9-c9ee-4524-9c3a-e0d07113dad7'
    def JWT_KEY_CRED_ID ='5ec79b74-2c7e-4e7b-b179-832d06329872'
    def CONNECTED_APP_CONSUMER_KEY='3MVG9kBt168mda_8xf5Uf0E_8NG68WIoOcS8YF6mjB9nimUO4rZuDhneuZqE3B1yyv4hQI1dnvZjxUW2gxQhK'

    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY
   // def toolbelt = tool 'toolbelt'

    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
	    sh 'ls -l'
	stage('Get CLI from Docker'){
		try{
                            sh 'docker pull salesforce/salesforcedx:latest-slim'
                            sh 'docker run --name SFCLI -i -d salesforce/salesforcedx:latest-slim bash'
			    
                            sh 'docker ps'   
                           } 
                        catch(Error) {
                             echo 'Salesforce CLI is not running'
                             sh 'docker stop SFCLI'
                             sh 'docker rm SFCLI'
                             sh 'docker pull salesforce/salesforcedx:latest-slim'
                             sh 'docker run --name SFCLI -i -d salesforce/salesforcedx:latest-slim bash'
                             sh 'docker ps'
                             
                           }
		
	}
	  //  stage('Install CLI'){
	  //	   sh 'wget https://developer.salesforce.com/media/salesforce-cli/sfdx-v5.99.1-d7efd75-linux-amd64.tar.xz'
	  //	   sh 'tar -xvJf sfdx-v5.9.9-d42cf65-linux-amd64.tar.xz'
	  //	   sh 'cd sfdx'
	  //	   sh './install'
	  //	   sh 'sfdx version'
		    
	    }
	    
	    stage('Test SFDXinstallation'){
		    sh 'docker exec -i SFCLI bin/bash sfdx version'
		    rc = sh returnStatus: true, script: "docker exec -i SFCLI bin/bash sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
		  //  rc = sh returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
	    }
       // stage('Deploye Code') {
       //     if (isUnix()) {
      //          rc = sh returnStatus: true, script: "${toolbelt} force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
      //      }else{
      //           rc = bat returnStatus: true, script: "\"${toolbelt}\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
      //      }
      //      if (rc != 0) { error 'hub org authorization failed' }

	//		println rc
			
			// need to pull out assigned username
		//	if (isUnix()) {
		//		rmsg = sh returnStdout: true, script: "${toolbelt} force:source:deploy --manifest manifest/package.xml -u ${HUB_ORG}"
		//	}else{
		//	   rmsg = bat returnStdout: true, script: "\"${toolbelt}\" force:source:deploy --manifest manifest/package.xml -u ${HUB_ORG}"
		//	}
			  
           // printf rmsg
          //  println('Hello from a Job DSL script!')
          //  println(rmsg)
      //  }
    }
}
