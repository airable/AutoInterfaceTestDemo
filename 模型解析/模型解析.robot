*** Settings ***
Resource          模型解析业务关键字.robot

*** Test Cases ***
请求解析
    setParseModelReq    jf17    Z3JvdXAxLE0wMC82QS84Ni93S2dHRlYwSVEzQ0FCaXJaQUpsMnNxTGs3blE3ODUuemlw

查询解析进度
    setInspectProgressReq    jf17    M1560822688136
    waitUntilModelHasBeenParsed    jf17    M1560822688136
