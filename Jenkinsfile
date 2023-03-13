#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME ='anantfromdbg@gmail.com'

    def HUB_ORG='anantfromdbg@gmail.com'
    def SFDC_HOST = 'https://login.salesforce.com'
    //def JWT_KEY_CRED_ID = '7d0dbdb9-c9ee-4524-9c3a-e0d07113dad7'
    def JWT_KEY_CRED_ID ='a784f743-4856-433a-9855-9fb5f7dc5580'
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
	stage('Code Quality Check'){
		//Required Sonar Host URL
                 -Dsonar.host.url= https://sonarcloud.io/projects
                 -Dsonar.login= 00185c55a2c17131016046bace094e7db53dfc09
                //Project Key and Project name 
                 -Dsonar.projectKey= anant338_SFDevelopment
                 -Dsonar.projectName= SFDevelopment
                //Should be changed for every version release
                //-Dsonar.projectVersion=
			 
               //Path to the parent source code directory.
               //Example for multiple directory option, sonar.sources=srcDir1,srcDir2
              //-Dsonar.sources= 
              //Files to be excluded from sonar check
              -Dsonar.exclusions= **/*Test.cls , **/*test.cls , **/*Test*.cls , **/*test*.cls 
	      -Dsonar.coverage.exclusions = src/classes/*__* , **/*Test.cls , **/*test.cls , **/*Test*.cls , **/*test*.cls 
	      -Dsonar.apex.file.suffixes = .cls , .trigger
	      -Dsonar.apex.coverage.reportPath = force-app/main/default/test-result-codecoverage.json
	      
              //Language
              -Dsonar.language= Apex
	      
             //Encoding of the source files
              -Dsonar.sourceEncoding=UTF-8
		
	}

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) { 
	    stage('Install CLI'){
		    
		      sh 'wget -q https://developer.salesforce.com/media/salesforce-cli/sfdx/channels/stable/sfdx-linux-x64.tar.xz'
                      sh 'mkdir ~/sfdx'
                      sh 'tar xJf sfdx-linux-x64.tar.xz -C ~/sfdx --strip-components 1'
		      sh '~/sfdx/bin/sfdx version'
		    
	    }
	    
	    stage('Test SFDXinstallation'){
		  //rc = sh returnStatus: true, script: "/var/lib/jenkins/sfdx/bin/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
		  rc = sh returnStatus: true, script: "~/sfdx/bin/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"  
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
	    stage('Uninstall CLI'){
		   sh 'rm -rf ~/sfdx' 
	    }
    }
}
