*** Settings ***
Resource          ../公共数据.robot
Resource          ../Common/basConfig.txt

*** Keywords ***
setCreateScenesReq
    [Arguments]    ${database_key}    ${model_key}
    ${database_key}    Set Variable    ${database_key}
    ${model_key}    Set Variable    ${model_key}
    ${create_scenes_url}    Set Variable    ${base_api_url}/api/${database_key}/scenes
    ${create_scenes_req}    set Variable    '{"modelKey":"${model_key}"}'    #此处加引号变成json类型字符串然后用json.loads转成字典
    ${create_scenes_req}    Evaluate    json.loads(${create_scenes_req})    json
    log    create csenes req:${create_scenes_req}
    ${req}    Set Variable    ${create_scenes_req}
    ${resp}    requests.POST    ${create_scenes_url}    json=${req}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
