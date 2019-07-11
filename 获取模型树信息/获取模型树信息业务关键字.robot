*** Settings ***
Resource          ../Common/basConfig.txt
Resource          ../公共数据.robot

*** Keywords ***
setGetModelTreeInfoReq
    [Arguments]    ${database_key}    ${tree_key}
    ${database_key}    Set Variable    ${database_key}
    ${get_model_tree_list_url}    Set Variable    ${base_api_url}/api/${database_key}/trees?treeKey=${tree_key}
    log    get model tree info \ url:${get_model_tree_list_url}
    log    ================================================================================================
    log    tree key info:
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${resp}    requests.Get    ${get_model_tree_list_url}    headers=${headers}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    ${data}    Get From Dictionary    ${resDict}    data
    log    ================================================================================================

setGetAllModelTreeInfoReq
    [Arguments]    ${database_key}    ${tree_key_list}
    ${tree_key_len}    Get Length    ${tree_key_list}
    : FOR    ${i}    IN RANGE    0    ${tree_key_len}
    \    log    tree key:${tree_key_list}[${i}]
    \    setGetModelTreeInfoReq    ${database_key}    ${tree_key_list}[${i}]
