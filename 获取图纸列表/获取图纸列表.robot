*** Settings ***
Resource          获取图纸列表关键字.robot

*** Test Cases ***
获取图纸列表
    setGetDrawingListReq    jf17    M1561341942190

获取图纸并检验图纸信息
    Comment    获取图纸列表并校验图纸信息关键字    jf17    M1561341942190
    获取图纸列表并校验文件名和图纸信息关键字    jf17    M1561341942190

获取图纸并全面验证
