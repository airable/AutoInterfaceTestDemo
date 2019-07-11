*** Settings ***
Resource          数据库管理业务关键字.robot

*** Test Cases ***
创建数据库
    setCreateDatabaseReq    jf13    jfname

删除数据库
    setDeleteDatabase    jf17
