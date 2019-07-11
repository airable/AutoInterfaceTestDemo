*** Settings ***
Resource          ../Common/basConfig.txt
Resource          ../公共数据.robot

*** Keywords ***
setCreateDatabaseReq
    [Arguments]    ${database_key}    ${name}
    ${key}    Set Variable    ${database_key}
    ${name}    Set Variable    ${name}
    ${permission}    Set Variable    public    #赋值全局变量
    ${databases_url}    Set Variable    ${base_database_url}/api/databases
    ${databases_management_req}    set Variable    '{ "key": "${key}", "name": "${name}", "permission": "${permission}"}'    #此处加引号变成json类型字符串然后用json.loads转成字典
    ${databases_management_req}    Evaluate    json.loads(${databases_management_req})    json
    log    databases_management_req:${databases_management_req}
    ${req}    Set Variable    ${databases_management_req}
    ${resp}    requests.POST    ${databases_url}    json=${req}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    log    ${resDict}
    ${data}    Get From Dictionary    ${resDict}    data
    ${res_key}    Get From Dictionary    ${data}    key
    Should Be Equal    ${key}    ${res_key}

setDeleteDatabase
    [Arguments]    ${database_key}
    ${key}    Set Variable    ${database_key}
    ${delete_database_url}    Set Variable    ${base_database_url}/api/databases?databaseKey=${database_key}
    log    delete database url:${delete_database_url}
    ${resp}    requests.Delete    ${delete_database_url}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    log    ${resDict}
    ${data}    Get From Dictionary    ${resDict}    data

修改数据库访问权限
