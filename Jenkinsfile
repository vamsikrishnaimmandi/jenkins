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
   checkout scm
}

withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')])
{
   /* stage('Authorizing dev org')
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
         
        vk=bat returnStatus: true, script: "\"${toolbelt}\" force:source:retrieve -m CustomTab,CustomApplication,PermissionSet,StaticResource,FlexiPage,ApexClass,AuraDefinitionBundle,LightningComponentBundle,ApexComponent,ApexPage,ApexTrigger,CustomLabels,CustomObject,ContentAsset -u saikrishna@popcornapps.com"
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
    }*/

      stage('Deploye Code') 
    {
     
                rc = bat returnStatus: true, script: "\"${toolbelt}\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
        rs=bat returnStatus: true, script: "\"${toolbelt}\" force:org:list"
        if (rc != 0) { error 'hub org authorization failed' }
        remove=bat returnStatus: true, script: "\"${toolbelt}\" force:auth:logout -u arrow@popcornapps.com"
        input: n/y
        remove1=bat returnStatus: true, script: "\"${toolbelt}\" force:auth:logout -u kondamdeepaksai2222@gmail.com -p"
        remove2=bat returnStatus: true, script: "\"${toolbelt}\" force:auth:logout -u sfdctraining@popcornapps.com -p"
        remove3=bat returnStatus: true, script: "\"${toolbelt}\" force:auth:logout -u test-a4aw0lsugkii@example.com -p"
        remove4=bat returnStatus: true, script: "\"${toolbelt}\" force:auth:logout -u vamsi@popcornapps.com -p"
        remove4=bat returnStatus: true, script: "\"${toolbelt}\" force:auth:logout -u rookienoob123@popcornapps.com -p"
        // need to pull out assigned username
         echo "after removeing orgs"
        rs=bat returnStatus: true, script: "\"${toolbelt}\" force:org:list"
     /*
            rmsg = bat returnStdout: true, script: "\"${toolbelt}\" force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
            if(rmsg !=0)
            {
                error 'not deployed'
            }
            //
        printf rmsg
        println('Hello from a Job DSL script!')
        println(rmsg)*/
    }
}
}