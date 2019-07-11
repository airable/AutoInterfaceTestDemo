*** Settings ***
Resource          ../Common/basConfig.txt
Resource          ../公共数据.robot
Resource          获取模型信息业务关键字.robot

*** Keywords ***
setGetModelInfoReq
    [Arguments]    ${database_key}    ${model_key}
    ${database_key}    Set Variable    ${database_key}
    ${model_key}    Set Variable    ${model_key}
    ${get_model_info_url}    Set Variable    ${base_api_url}/api/${database_key}/models?modelKey=${model_key}
    log    get model info url:${get_model_info_url}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${resp}    requests.Get    ${get_model_info_url}    headers=${headers}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    ${data}    Get From Dictionary    ${resDict}    data
