#!groovy

node('puppet-test') {

    String fullJobName = "${JOB_NAME}"
    String[] jobName = fullJobName.split("/")
    String puppetEnv
    String filterPat
    switch ("${env.BRANCH_NAME}") {
        case 'master':
            puppetEnv = "production"
            filterPat = "^(${jobName[0]}closedtrue)\$"
            break
        case 'development':
            puppetEnv = "development"
            filterPat = "^(${jobName[0]})(closedtrue|synchronizedfalse)\$"
            break
        default:
            echo 'Puppet environment could not be determined!'
            exit
    }
    properties([
        pipelineTriggers([
            [$class: 'GenericTrigger',
                genericVariables: [
                    [
                        key: 'repo',
                        value: '$.repository.name',
                        expressionType: 'JSONPath', //Optional, defaults to JSONPath
                        regexpFilter: '', //Optional, defaults to empty string
                        defaultValue: 'cx_airserver' //Optional, defaults to empty string
                    ],
                    [
                        key: 'action',
                        value: '$.action',
                        expressionType: 'JSONPath',
                        regexpFilter: '',
                        defaultValue: 'synchronized'
                    ],
                    [
                        key: 'merged',
                        value: '$.pull_request.merged',
                        expressionType: 'JSONPath',
                        regexpFilter: '',
                        defaultValue: 'false'
                    ]
                ],
                printContributedVariables: true,
                printPostContent: true,
                regexpFilterText: '$repo$action$merged',
                regexpFilterExpression: filterPat
            ]
        ])
    ])
    stage('checkout') {
        deleteDir()
        checkout scm
        echo "preparing environment..."
    }
    stage('deploy') {
        echo "deploying module..."
        withCredentials([file(credentialsId: 'puppet-jenkins-ssh', variable: 'SSHUSER')]) {
            try {
                sh """#!/bin/bash
                if [ ${merged} == true ]
                    then
                        ssh -o StrictHostKeyChecking=No \
                            -i ${SSHUSER} \
                        puppet-jenkins@puppet.phx.connexta.com \
                        '/usr/bin/sudo -u root -i r10k deploy module -e ${puppetEnv} ${jobName[0]} -v'
                else
                    echo 'PR not merged, skipping deployment...' 
                fi   
                """
            } catch(groovy.lang.MissingPropertyException ex) {
                sh "echo '\$merged POST variable not found or job started locally, will not deploy module. Please manually run r10k to deploy.'"
            }
        } 
    }
}