#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME ='anantfromdbg@gmail.com'

    def HUB_ORG='anantfromdbg@gmail.com'
    def SFDC_HOST = 'https://login.salesforce.com'
    def JWT_KEY_CRED_ID ='2ab55480-a2a8-43b7-a762-218175a0ec7e'
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
	    stage('Run CLI on Docker image'){
		    sh 'pwd'
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
	                     sh 'pwd'
	    }
      
       stage('Test Installation'){
	    sh 'pwd' 
       
            rc = sh returnStatus: true, script: "docker exec -i SFCLI bin/bash sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${id_key} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
	    }
	    
	  /*  stage('Install CLI'){
		    
		     if (fileExists('/var/lib/jenkins/sfdx')) 
		       {
			   sh '~/sfdx/bin/sfdx version'
		       } 
		       else {
		             sh 'wget -q https://developer.salesforce.com/media/salesforce-cli/sfdx/channels/stable/sfdx-linux-x64.tar.xz'
                             sh 'mkdir ~/sfdx'
                             sh 'tar xJf sfdx-linux-x64.tar.xz -C ~/sfdx --strip-components 1'
		             sh '~/sfdx/bin/sfdx version'
		        }
		      
		    
	    }
	    
	    stage('Authorize the org'){
            //rc = sh returnStatus: true, script: "/var/lib/jenkins/sfdx/bin/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"      
              rc = sh returnStatus: true, script: "~/sfdx/bin/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"  
	    }
	    stage('Run Test'){
	          rc = sh returnStatus: true, script: "~/sfdx/bin/sfdx force:apex:test:run --testlevel RunLocalTests --targetusername anantfromdbg@gmail.com -d /test-result-codecoverage.json"  
	       }
	    
	    
	    stage('Code Quality Check'){
		withSonarQubeEnv(credentialsId: 'SonarCloud', installationName: 'SonarCloud') {
               sh "${tool("SonarQube")}/bin/sonar-scanner \
		-Dsonar.organization=anant338 \
               -Dsonar.projectKey=anant338_SFDevelopment \
		-Dsonar.language=apex \
               -Dsonar.sources=. \
                -Dsonar.tests=. \
	       -Dsonar.apex.coverage.reportPath=./test-result-codecoverage.json  "
           }
	 }
	*/    
	    
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
	    stage('Uninstall CLI'){
		   sh 'rm -rf ~/sfdx' 
	    }
    }
}
