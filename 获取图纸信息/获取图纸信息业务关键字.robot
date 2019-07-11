*** Settings ***
Resource          ../Common/basConfig.txt
Resource          ../公共数据.robot

*** Keywords ***
setGetDrawingInfoReq
    [Arguments]    ${database_key}    ${drawing_key}
    ${database_key}    Set Variable    ${database_key}
    ${drawing_key}    Set Variable    ${drawing_key}
    ${get_draing_info_url}    Set Variable    ${base_api_url}/api/${database_key}/drawings?drawingKey=${drawing_key}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${resp}    requests.Get    ${get_draing_info_url}    headers=${headers}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    ${data}    Get From Dictionary    ${resDict}    data
    #校验key对应的信息是否包含在data中
    ${data_key_list}    Set Variable    id    key    rev    permission    owner
    ...    fileKey    name    type    pkgKey
    ${data_key_list_len}    Get Length    ${data_key_list}
    : FOR    ${i}    IN RANGE    0    ${data_key_list_len}
    \    Dictionary Should Contain Key    ${data}    ${data_key_list}[${i}]
    Comment    \    log    result contains ${data_key_list}[${i}]
