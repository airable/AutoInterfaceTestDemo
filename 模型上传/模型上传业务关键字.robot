*** Settings ***
Resource          ../Common/basConfig.txt
Resource          ../公共数据.robot

*** Keywords ***
setUploadRevitModelReq
    [Arguments]    ${database_key}    ${file_name}
    ${key}    Set Variable    ${database_key}
    ${file_name}    Set Variable    ${file_name}
    ${upload_url}    Set Variable    ${base_api_url}/api/${database_key}/files
    ${file_path}    Set Variable    ${base_file_path}\\${file_name}
    log    upload url:${upload_url}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${file_key}    Upload Model    ${file_path}    ${upload_url}    headers=${headers}
    [Return]    ${file_key}

setUploadAdeModelReq
    [Arguments]    ${database_key}    ${file_name}
    ${key}    Set Variable    ${database_key}
    ${file_name}    Set Variable    ${file_name}
    ${upload_url}    Set Variable    ${base_api_url}/api/${database_key}/files
    ${file_path}    Set Variable    ${base_dae_file_path}\\${file_name}
    log    upload url:${upload_url}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${file_key}    Upload Model    ${file_path}    ${upload_url}    headers=${headers}
    [Return]    ${file_key}

setUploadIfcModelReq
    [Arguments]    ${database_key}    ${file_name}
    ${key}    Set Variable    ${database_key}
    ${file_name}    Set Variable    ${file_name}
    ${upload_url}    Set Variable    ${base_api_url}/api/${database_key}/files
    ${file_path}    Set Variable    ${base_ifc_file_path}\\${file_name}
    log    upload url:${upload_url}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${file_key}    Upload Model    ${file_path}    ${upload_url}    headers=${headers}
    [Return]    ${file_key}

setUploadFbxModelReq
    [Arguments]    ${database_key}    ${file_name}
    ${key}    Set Variable    ${database_key}
    ${file_name}    Set Variable    ${file_name}
    ${upload_url}    Set Variable    ${base_api_url}/api/${database_key}/files
    ${file_path}    Set Variable    ${base_fbx_file_path}\\${file_name}
    log    upload url:${upload_url}
    ${Authorization}    Set Variable    ${EMPTY}
    ${headers}    Create Dictionary    Authorization=${Authorization}
    ${file_key}    Upload Model    ${file_path}    ${upload_url}    headers=${headers}
    [Return]    ${file_key}
