#!groovy
import groovy.json.JsonSlurperClassic
node
{

def BUILD_NUMBER=env.BUILD_NUMBER
def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
def SFDC_USERNAME="jenkins@scratchorg.com"

def HUB_ORG=env.HUB_ORG_DH
def SFDC_HOST = env.SFDC_HOST_DH
def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH

println 'KEY IS' 
println JWT_KEY_CRED_ID
println HUB_ORG
println SFDC_HOST
println CONNECTED_APP_CONSUMER_KEY
def toolbelt = tool 'toolbelt'

stage('checkout source')
    {
    // when running in multi-branch job, one must issue this command
   // checkout scm
}

withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')])
{
    stage('Authorizing dev org')
    {
            
        rc = bat returnStatus: true, script: "\"${toolbelt}\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST} --setalias my-hub-org"
        if (rc != 0) { error 'hub org authorization failed' }
        // need to pull out assigned username
        
         rs=bat returnStatus: true, script: "\"${toolbelt}\" force:config:set defaultdevhubusername=${HUB_ORG} --global"
         list= bat returnStatus: true, script: "\"${toolbelt}\" force:org:list"
        rmsg = bat returnStatus: true, script: "\"${toolbelt}\" force:org:create --setdefaultusername --definitionfile config/project-scratch-def.json  --setalias jenkins -v ${HUB_ORG} username=jenkins@scratchorg.com"
       
    }
    stage('retrive data from org')
    {
        // rs=bat returnStatus: true, script: "\"${toolbelt}\" force:config:set defaultusername=${HUB_ORG}"
         
        vk=bat returnStatus: true, script: "\"${toolbelt}\" force:source:retrieve -m CustomTab,CustomApplication,PermissionSet,StaticResource,FlexiPage,ApexClass,AuraDefinitionBundle,LightningComponentBundle,ApexComponent,ApexPage,ApexTrigger,CustomLabels,CustomObject,ContentAsset"
        if(vk != 0){error 'not retrived'}
    }
   stage('Push To Test Org')
        {
            rs=bat returnStatus: true, script: "\"${toolbelt}\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --jwtkeyfile \"${jwt_key_file}\" --username ${SFDC_USERNAME} --instanceurl https://test.salesforce.com"
                rs=bat returnStatus: true, script: "\"${toolbelt}\" force:config:set defaultusername=${SFDC_USERNAME}"
        rc = bat returnStatus: true, script: "\"${toolbelt}\" force:source:push --targetusername ${SFDC_USERNAME}"
        if (rc != 0)
        {
            error 'push failed'
        }
    }

    /*  stage('Deploye Code') 
    {
        if (isUnix()) {
            rc = sh returnStatus: true, script: "${toolbelt} force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
        }else{
                rc = bat returnStatus: true, script: "\"${toolbelt}\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
        }
        if (rc != 0) { error 'hub org authorization failed' }

        println rc
        
        // need to pull out assigned username
        if (isUnix()) {
            rmsg = sh returnStdout: true, script: "${toolbelt} force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
        }else{
            rmsg = bat returnStdout: true, script: "\"${toolbelt}\" force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
        }
            //
        printf rmsg
        println('Hello from a Job DSL script!')
        println(rmsg)
    }*/
}
}