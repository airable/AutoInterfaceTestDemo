*** Settings ***
Resource          获取模型树列表业务关键字.robot

*** Test Cases ***
获取模型树列表
    setGetModelTreeListReq    jf30    M1561624496367

TEST
    :FOR    ${i}    IN    0
    \    LOG    A
