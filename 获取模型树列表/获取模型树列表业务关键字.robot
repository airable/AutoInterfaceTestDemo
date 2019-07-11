*** Settings ***
Resource          ../Common/basConfig.txt
Resource          ../公共数据.robot

*** Keywords ***
setGetModelTreeListReq
    [Arguments]    ${database_key}    ${model_key}
    ${database_key}    Set Variable    ${database_key}
    ${get_model_tree_list_url}    Set Variable    ${base_api_url}/api/${database_key}/trees/list?modelKey=${model_key}
    log    get model tree list url:${get_model_tree_list_url}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${resp}    requests.Get    ${get_model_tree_list_url}    headers=${headers}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    Comment    此处获取的是一个列表
    ${data_list}    Get From Dictionary    ${resDict}    data
    ${data_list_len}    Get Length    ${data_list}
    ${tree_key_list}    Create List
    log    ....
    : FOR    ${i}    IN RANGE    0    ${data_list_len}
    \    log    ${data_list}][${i}]
    \    ${tree_key}    Get From Dictionary    ${data_list}[${i}]    key
    \    Append To List    ${tree_key_list}    ${tree_key}
    log    tree key list:${tree_key_list}
    [Return]    ${tree_key_list}    # \ 返回的是列表
