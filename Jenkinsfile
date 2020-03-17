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
        stage('Authorizong Org')
         {

             rc = bat returnStatus: true, script: "\"${toolbelt}\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            if (rc != 0)
            {
              error 'hub org authorization failed' 
            }
             list= bat returnStatus: true, script: "\"${toolbelt}\" force:org:list"
        }
        stage('Retrive Data')
        {
             vk=bat returnStatus: true, script: "\"${toolbelt}\" force:source:retrieve -m CustomTab,CustomApplication,PermissionSet,StaticResource,FlexiPage,ApexClass,AuraDefinitionBundle,LightningComponentBundle,ApexComponent,ApexPage,ApexTrigger,CustomLabels,CustomObject,ContentAsset -u ${HUB_ORG}"
             if(vk != 0)
             {
                error 'not retrived'
             }
        }
        stage('Creating Scratch Org')
        {
            rs=bat returnStatus: true, script: "\"${toolbelt}\" force:config:set defaultdevhubusername=${HUB_ORG}"
            rmsg = bat returnStatus: true, script: "\"${toolbelt}\" force:org:create --setdefaultusername --definitionfile config/project-scratch-def.json  --setalias jenkins -v ${HUB_ORG} username=${SFDC_USERNAME}"
            if(rmsg !=0)
            {
                error 'Scratch Org not created'
            }
        }
        stage('push to scratch org')
        {
            rs=bat returnStatus: true, script: "\"${toolbelt}\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --jwtkeyfile \"${jwt_key_file}\" --username ${SFDC_USERNAME} --instanceurl https://test.salesforce.com "
            rs=bat returnStatus: true, script: "\"${toolbelt}\" force:config:set defaultusername=${SFDC_USERNAME}"
            rc = bat returnStatus: true, script: "\"${toolbelt}\" force:source:push --targetusername ${SFDC_USERNAME}"
            if (rc != 0)
            {
                error 'push failed'
            }
        }
        stage('logging out Orgs')
        {
            removeOrg=bat returnStatus: true, script: "\"${toolbelt}\" force:auth:logout -u ${HUB_ORG} -p"
            removeScratchOrg=bat returnStatus: true, script: "\"${toolbelt}\" force:auth:logout -u ${SFDC_USERNAME} -p"
            list= bat returnStatus: true, script: "\"${toolbelt}\" force:org:list"
        }
    }
}
