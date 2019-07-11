*** Settings ***
Resource          ../Common/basConfig.txt
Resource          ../公共数据.robot
Resource          ../获取图纸信息/获取图纸信息业务关键字.robot

*** Keywords ***
setGetDrawingListReq
    [Arguments]    ${database_key}    ${model_key}
    ${database_key}    Set Variable    ${database_key}
    ${model_key}    Set Variable    ${model_key}
    ${get_draing_list_url}    Set Variable    ${base_api_url}/api/${database_key}/drawings/list?pkgKey=${model_key}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${resp}    requests.Get    ${get_draing_list_url}    headers=${headers}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    ${data}    Get From Dictionary    ${resDict}    data
    #图纸列表中的图纸key列表    #data 本身就是个列表
    ${data_list_len}    Get Length    ${data}
    ${drawing_key_list}    Create List
    ${drawing_name_list}    Create List
    : FOR    ${i}    IN RANGE    ${data_list_len}
    \    ${drawing_key}    Get From Dictionary    ${data}[${i}]    key
    \    Append To List    ${drawing_key_list}    ${drawing_key}
    \    ${drawing_name}    Get From Dictionary    ${data}[${i}]    name
    \    Append To List    ${drawing_name_list}    ${drawing_name}
    log    ${drawing_key_list}
    log    ${drawing_name_list}
    [Return]    ${drawing_key_list}    ${drawing_name_list}

获取图纸列表并校验图纸信息关键字
    [Arguments]    ${database_key}    ${model_key}
    Comment    图纸信息中的对应每一个key进行校验看是否有不存在的key信息
    ${database_key}    Set Variable    ${database_key}
    ${model_key}    Set Variable    ${model_key}
    ${get_draing_list_url}    Set Variable    ${base_api_url}/api/${database_key}/drawings/list?pkgKey=${model_key}
    ${resp}    requests.Get    ${get_draing_list_url}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    ${data}    Get From Dictionary    ${resDict}    data
    #图纸列表中的图纸key列表    #data 本身就是个列表
    ${data_list_len}    Get Length    ${data}
    ${drawing_key_list}    Create List
    ${drawing_name_list}    Create List
    : FOR    ${i}    IN RANGE    ${data_list_len}
    \    ${drawing_key}    Get From Dictionary    ${data}[${i}]    key
    \    Append To List    ${drawing_key_list}    ${drawing_key}
    \    ${drawing_name}    Get From Dictionary    ${data}[${i}]    name
    \    Append To List    ${drawing_name_list}    ${drawing_name}
    ${drawing_key_list_len}    Get Length    ${drawing_key_list}
    : FOR    ${i}    IN RANGE    0    ${drawing_key_list_len}
    \    setGetDrawingInfoReq    ${database_key}    ${drawing_key_list}[${i}]
    log    ====================================================================================================================================================
    log    ${drawing_key_list}
    log    ====================================================================================================================================================
    log    ${drawing_name_list}

获取图纸列表并校验文件名和图纸信息关键字
    [Arguments]    ${database_key}    ${model_key}    ${file_list}
    Comment    1.进行文件目录中json的二维文件名和列表中文件名和返回文件名进行校验    2.图纸信息中的对应每一个key进行校验看是否有不存在的key信息
    ${database_key}    Set Variable    ${database_key}
    ${model_key}    Set Variable    ${model_key}
    ${get_draing_list_url}    Set Variable    ${base_api_url}/api/${database_key}/drawings/list?pkgKey=${model_key}
    ${resp}    requests.Get    ${get_draing_list_url}
    ${resCode}    Set Variable    ${resp.status_code}
    ${resdata}    Set Variable    ${resp.content.decode('utf-8')}
    ${resDict}    To Json    ${resdata}
    ${data}    Get From Dictionary    ${resDict}    data
    #图纸列表中的图纸key列表    #data 本身就是个列表
    ${data_list_len}    Get Length    ${data}
    ${drawing_key_list}    Create List
    ${drawing_name_list}    Create List
    : FOR    ${i}    IN RANGE    ${data_list_len}
    \    ${drawing_key}    Get From Dictionary    ${data}[${i}]    key
    \    Append To List    ${drawing_key_list}    ${drawing_key}
    \    ${drawing_name}    Get From Dictionary    ${data}[${i}]    name
    \    Append To List    ${drawing_name_list}    ${drawing_name}
    log    ==================================================================================================
    log    file list:
    log    ${file_list}
    log    ==================================================================================================
    log    drawing name list:
    log    ${drawing_name_list}
    log    ==================================================================================================
    ${res}    Compare Two List    ${drawing_name_list}    ${file_list}
    Should Be True    '${res}'=='True'
    log    开始校验每一个key对应的图纸信息================================================================================================================================
    ${drawing_key_list_len}    Get Length    ${drawing_key_list}
    : FOR    ${i}    IN RANGE    0    ${drawing_key_list_len}
    \    setGetDrawingInfoReq    ${database_key}    ${drawing_key_list}[${i}]
