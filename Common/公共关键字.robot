*** Settings ***
Library           BOSFLibrary

*** Keywords ***
截取文件名
    [Arguments]    ${file_name}    # 普通文件名
    [Return]    ${left_file_name}

比较文件列表与列表值是否相同
