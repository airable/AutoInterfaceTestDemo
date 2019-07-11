*** Settings ***
Resource          ../公共数据.robot
Resource          ../Common/basConfig.txt

*** Keywords ***
setGetFileListReq
    [Arguments]    ${database_key}
    ${database_key}    Set Variable    ${database_key}
    ${get_file_list_url}    Set Variable    ${base_api_url}/api/${database_key}/files/list
    log    get file list url:${get_file_list_url}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${resp}    requests.Get    ${get_file_list_url}    headers=${headers}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    ${data}    Get From Dictionary    ${resDict}    data
