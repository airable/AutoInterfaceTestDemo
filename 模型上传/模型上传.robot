*** Settings ***
Resource          模型上传业务关键字.robot

*** Test Cases ***
模型上传
    ${database_key}    Set Variable    jf17
    ${file_name}    Set Variable    double-2019.zip
    setUploadRevitModelReq    ${database_key}    ${file_name}
