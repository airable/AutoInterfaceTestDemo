*** Settings ***
Resource          ../Common/basConfig.txt
Resource          ../公共数据.robot

*** Keywords ***
setParseModelReq
    [Arguments]    ${database_key}    ${file_key}
    Comment    后面转测过来的接口有所变化。请求解析，解析完成以后状态码为2（整在解析）-1（解析错误），5为解析完成
    ${database_key}    Set Variable    ${database_key}
    ${file_key}    Set Variable    ${file_key}
    ${priority}    Set Variable    10
    ${parse_model_url}    Set Variable    ${base_api_url}/api/${database_key}/parses/files
    ${parse_model_req}    set Variable    '{ "fileKey":"${file_key}", "priority":${priority} }'    #此处加引号变成json类型字符串然后用json.loads转成字典
    ${parse_model_req}    Evaluate    json.loads(${parse_model_req})    json
    log    parse model req :${parse_model_req}
    ${req}    Set Variable    ${parse_model_req}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${resp}    requests.POST    ${parse_model_url}    json=${req}    headers=${headers}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    ${data}    Get From Dictionary    ${resDict}    data
    Comment    ${percentage}    Get From Dictionary    ${data}    percentage
    ${model_key}    Get From Dictionary    ${data}    modelKey
    [Return]    ${model_key}

setInspectProgressReq
    [Arguments]    ${database_key}    ${model_key}
    ${database_key}    Set Variable    ${database_key}
    ${model_key}    Set Variable    ${model_key}
    ${inspect_progress_url}    Set Variable    ${base_api_url}/api/${database_key}/parses/status?modelKey=${model_key}
    log    inspect progress url:${inspect_progress_url}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${resp}    requests.Get    ${inspect_progress_url}    headers=${headers}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    ${data}    Get From Dictionary    ${resDict}    data
    #判断是新老接口
    Comment    ${res}    Run Keyword And Return Status    Dictionary Should Contain Key    ${data}    percentage
    Comment    ${percentage}=    Set Variable If    '${res}'=='True'    Get From Dictionary    ${data}    percentage
    ${model_key}    Get From Dictionary    ${data}    modelKey
    Comment    ${res}    Run Keyword And Return Status    Dictionary Should Contain Key    ${data}    status
    Comment    ${status}=    Set Variable If    '${res}'=='True'    Get From Dictionary    ${data}    status
    ${status}    Get From Dictionary    ${data}    status
    [Return]    ${status}

waitUntilModelHasBeenParsed
    [Arguments]    ${database_key}    ${model_key}
    #循环等待模型解析完成
    : FOR    ${i}    IN RANGE    0    500
    \    ${status}    setInspectProgressReq    ${database_key}    ${model_key}
    \    log    Parsing model,wait...
    \    Sleep    2
    \    Should Not Be Equal    ${status}    -1    #不允许为-1
    \    Exit For Loop If    '${status}'=='3'
    \    log    status :${status}
    log    Model has been parsed !
