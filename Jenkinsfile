#!groovy

node {

    def SF_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH
    def SF_USERNAME=env.HUB_ORG_DH
    def SERVER_KEY_CREDENTIALS_ID=env.JWT_CRED_ID_DH
    def DEPLOYDIR=env.gitpathforjenkins
    def TEST_LEVEL='RunLocalTests'



    def toolbelt = tool 'toolbelt'


    // -------------------------------------------------------------------------
    // Check out code from source control.
    // -------------------------------------------------------------------------

    stage('checkout source') {
        checkout scm
    }


    // -------------------------------------------------------------------------
    // Run all the enclosed stages with access to the Salesforce
    // JWT key credentials.
    // -------------------------------------------------------------------------

    withCredentials([file(credentialsId: SERVER_KEY_CREDENTIALS_ID, variable: 'server_key_file')])
     {
        // -------------------------------------------------------------------------
        // Authenticate to Salesforce using the server key.
        // -------------------------------------------------------------------------


        stage('Authorize to Salesforce')
         {
             

 rc = command "\"${toolbelt}\" force:auth:jwt:grant --clientid ${SF_CONSUMER_KEY} --jwtkeyfile ${SERVER_KEY_CREDENTIALS_ID} --username ${SF_USERNAME} --instanceurl https://login.salesforce.com --setdefaultdevhubusername"
            if (rc != 0) {
                error 'Salesforce org authorization failed.'
            }
        }


        // -------------------------------------------------------------------------
        // Deploy metadata and execute unit tests.
        // -------------------------------------------------------------------------

        stage('Deploy and Run Tests')
         {
            rc = command "\"${toolbelt}\" force:source:deploy -p /Sample_/manifest/. -u ${SF_USERNAME}"
            echo "after rc"
            if (rc != 0) {
                error 'Salesforce deploy and test run failed.'
            }
        }


        // -------------------------------------------------------------------------
        // Example shows how to run a check-only deploy.
        // -------------------------------------------------------------------------

        //stage('Check Only Deploy') {
        //    rc = command "${toolbelt}/sfdx force:mdapi:deploy --checkonly --wait 10 --deploydir ${DEPLOYDIR} --targetusername UAT --testlevel ${TEST_LEVEL}"
        //    if (rc != 0) {
        //        error 'Salesforce deploy failed.'
        //    }
        //}
    }
}

def command(script) {
    if (isUnix()) {
        return sh(returnStatus: true, script: script);
    } else {
		return bat(returnStatus: true, script: script);
    }
}