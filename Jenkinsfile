#!groovy

node('puppet-test') {

    String fullJobName = "${JOB_NAME}"
    String[] jobName = fullJobName.split("/")
    String puppetEnv
    String filterPat
    switch ("${env.BRANCH_NAME}") {
        case 'master':
            puppetEnv = "production"
            filterPat = "^(${jobName[0]}${env.BRANCH_NAME}closedtrue)\$"
            break
        case 'development':
            puppetEnv = "development"
            filterPat = "^(${jobName[0]})${env.BRANCH_NAME}(closedtrue|synchronizedfalse)\$"
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
                        defaultValue: "${jobName[0]}" //Optional, defaults to empty string
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
                    ],
                    [
                        key: 'base_branch',
                        value: '$.pull_request.base_branch',
                        expressionType: 'JSONPath',
                        regexpFilter: '',
                        defaultValue: 'null'
                    ]
                ],
                printContributedVariables: true,
                printPostContent: true,
                regexpFilterText: '$repo$base_branch$action$merged',
                regexpFilterExpression: filterPat
            ]
        ])
    ])

  // Include the puppet_shared_pipeline definition
  library 'puppet_shared_pipeline@master'
  
  puppetPipeline(puppetEnv: "${puppetEnv}")
}