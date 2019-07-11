*** Settings ***
Resource          数据库管理/数据库管理业务关键字.robot
Resource          模型上传/模型上传业务关键字.robot
Resource          模型解析/模型解析业务关键字.robot
Resource          获取模型信息/获取模型信息业务关键字.robot
Resource          创建场景/创建场景业务关键字.robot
Resource          公共数据.robot
Resource          获取图纸列表/获取图纸列表关键字.robot
Resource          获取模型树列表/获取模型树列表业务关键字.robot
Resource          获取模型树信息/获取模型树信息业务关键字.robot

*** Variables ***
${temp_database_key}    test
${suit_model_list}    ${EMPTY}
${ifc_system_file_name}    F:\\autoUploadModels\\ifc\\water_with_system.ifc
${arango_url}     http://bos-arango-pre.rickricks.com
${arango_username}    root
${arango_password}    yjhl_arango
${arango_collection_name}    systems
${arango_key_name}    name
${arango_condition}    家用冷水 6
${suit_file_key_list}    ${EMPTY}
${file_key_txt_path}    F:\\autoUploadModels\\filekey\\filekey.txt    # 存储filekey列表的文件路径

*** Test Cases ***
请求解析
    ${suit_file_key}    Set Variable    Z3JvdXAxLE0wMC83Ni8yMi93S2dHRlYwUUw5ZUFZRWY2QUYtd3V2TXdmY2cyNjUuemlw
    ${suit_database_name}    Set Variable    jf17
    setParseModelReq    ${suit_database_name}    ${suit_file_key}

批量上传模型并验证业务
    ${database_key}    Set Variable    jf30
    ${file_name_list}    Get Suffix File List    F:\\autoUploadModels\\Revit    0701.zip
    批量上传revit模型并验证    ${database_key}    ${file_name_list}

上传模型并验证图纸信息
    ${database_key}    Set Variable    jf30
    ${file_name}    Set Variable    科研楼 修改-1-2015.zip
    上传revit模型并对比文件名和验证图纸信息业务    ${database_key}    ${file_name}

上传模型并和源文件图纸信息对比验证
    ${database_key}    Set Variable    ${temp_database_key}
    ${file_name}    Set Variable    两居室 扩大客厅-1-2016-0625.zip
    上传revit模型并对比文件名和验证图纸信息业务    ${database_key}    ${file_name}
    log    ====================================================================================================
    log    ${file_name} data and interfaces are OK !

CLass_01_批量上传Revit模型并和源文件图纸信息对比验证
    ${database_key}    Set Variable    ${temp_database_key}
    ${file_name_list}    Set Variable    科研楼 修改-1-2015.zip    两居室 扩大客厅-1-2016.zip    人民医院站-管线综合模型-2016.zip    实训中心水暖最终-1-2019.zip    三层Revit商务办公楼模型0001-1-2019.zip
    批量上传revit模型并对比文件名和验证图纸信息业务    ${database_key}    ${file_name_list}
    log    ====================================================================================================
    log    Data and interfaces are OK !

上传dea模型并验证
    ${database_key}    Set Variable    ${temp_database_key}
    ${file_name}    Set Variable    Frog-Dae-ani.zip
    上传dae模型并验证业务    ${database_key}    ${file_name}

Class_02_批量上传dae模型并验证
    ${database_key}    Set Variable    ${temp_database_key}
    ${file_name_list}    Get Suffix File List    ${base_dae_file_path}    .zip
    Comment    ${file_name_list}    Set Variable    Chair_Static_ani.zip    skin_and_morph.zip    house_csdn.zip    sheep.zip
    ...    USB_Sticks_dae_ani.zip
    ${file_name_list}    Set Variable    ${file_name_list}
    批量上传dae模型并验证    ${database_key}    ${file_name_list}

上传ifc模型并验证
    ${database_key}    Set Variable    jf31
    ${file_name}    Set Variable    water_with_system.ifc
    上传ifc模型并验证业务    ${database_key}    ${file_name}

创建数据库
    setCreateDatabaseReq    jfbig    jfname

删除数据库
    setDeleteDatabase    jf29

Class_03_批量上传ifc模型并验证
    ${database_key}    Set Variable    ${temp_database_key}
    ${ifc_list}    Get Suffix File List    F:\\autoUploadModels\\ifc    .ifc
    ${file_name_list}    Set Variable    ${ifc_list}
    log    ${file_name_list}
    批量上传ifc模型并验证业务    ${database_key}    ${file_name_list}

验证ifc模型树信息
    #获取模型树列表
    上传ifc模型并验证业务    jf30    water_with_system.ifc

验证指定key模型树信息

ifc中的system和数据库比较
    将ifc模型导出字符串与数据库进行对比    ${ifc_system_file_name}

上传ifc模型并验证key以及解码后的字符串
    上传ifc模型并验证key以及解码后的字符串    ${temp_database_key}    三堡冷冻机房_system.ifc    ${ifc_system_file_name}

Class_04_批量上传fbx模型并验证
    ${database_key}    Set Variable    ${temp_database_key}
    ${fbx_list}    Get Suffix File List    F:\\autoUploadModels\\fbx    .zip
    ${file_name_list}    Set Variable    ${fbx_list}
    log    ${file_name_list}
    批量上传fbx模型并验证业务    ${database_key}    ${file_name_list}

上传fbx模型并验证
    上传fbx模型并验证业务    ${temp_database_key}    5-update.zip

Class_05_通过filekey批量解析模型
    ${database_key}    Set Variable    ${temp_database_key}
    ${file_key_list}    Read File As List    ${file_key_txt_path}
    Comment    ${file_key_list}    Set Variable    Z3JvdXAxLE0wMC81Ny8wOS93S2dMQ0Z4MThZV0FEb3c2QUFlbHhZYlN0OG81NDkuemlw    Z3JvdXAxLE0wMC81Ny8wOS93S2dMQ0Z4MThZMkFKYjBUQUZWTW5iNnZZRk00NTkuemlw    Z3JvdXAxLE0wMC81Ny8wQS93S2dMQ0Z4MTlELUFIZ1VNRWk2aU96c1ZFemc3OTQuemlw    Z3JvdXAxLE0wMC81QS85Ny93S2dMQ0Z4Mkd4LUFCTUJ3QVBlbmlPeVkyQUU1MDcuemlw
    ...    Z3JvdXAxLE0wMC81Ny81Ny93S2dMQ0Z4MkJjQ0FXRkdhQUFXejY3Q2NteWM1NTkuemlw    Z3JvdXAxLE0wMC81QS85Ny93S2dMQ0Z4Mkc3LUFKZ2VJQmtqSzhUb05jQVEwNzcuemlw    Z3JvdXAxLE0wMC81QS9GQi93S2dMQ0Z4MkhPcUFSemM0RGlmTjBoLUtUYkk5Njkuemlw    Z3JvdXAxLE0wMC81Qi8xNi93S2dMQ0Z4MkhTR0FmZU5XRGtDZXE0dHppLTgzMTUuemlw
    通过filekey批量解析模型业务    ${database_key}    ${file_key_list}

通过filekey解析单个模型

*** Keywords ***
上传revit模型并验证业务
    [Arguments]    ${database_key}    ${file_name}
    ${database_key}    Set Variable    ${database_key}
    ${database_name}    Set Variable    jfname
    #上传的模型名称
    ${file_name}    Set Variable    ${file_name}
    Comment    setCreateDatabaseReq    ${database_key}    ${database_name}
    ${file_key}    setUploadRevitModelReq    ${database_key}    ${file_name}
    ${model_key}    setParseModelReq    ${database_key}    ${file_key}
    #等待解析完成
    waitUntilModelHasBeenParsed    ${database_key}    ${model_key}
    #创建场景
    Sleep    1
    setCreateScenesReq    ${database_key}    ${model_key}
    #获取模型信息
    Sleep    1
    setGetModelInfoReq    ${database_key}    ${model_key}
    Append To List    ${suit_model_list}    ${file_name}：${model_key}
    [Return]    ${model_key}

批量上传revit模型并验证
    [Arguments]    ${database_key}    ${file_name_list}
    ${model_list}    Create List
    Set Suite Variable    ${suit_model_list}    ${model_list}
    ${file_name_list_len}    Get Length    ${file_name_list}
    : FOR    ${i}    IN RANGE    0    ${file_name_list_len}
    \    ${file_name}    Set Variable    ${file_name_list}[${i}]
    \    ${model_key}    上传revit模型并验证业务    ${database_key}    ${file_name}
    \    log    ${file_name}_modelkey:${model_key}
    log    model list:${suit_model_list}

上传revit模型并对比文件名和验证图纸信息业务
    [Arguments]    ${database_key}    ${file_name}
    ${database_key}    Set Variable    ${database_key}
    #上传的模型名称
    ${file_name}    Set Variable    ${file_name}
    #文件名前缀
    ${file_prefix_name}    Get Prefix Name    ${file_name}
    ${unzip_dir_path}    Set Variable    F:\\autoUploadModels\\Revit\\unzip_files\\${file_prefix_name}\\PlanViews
    ${file_name_list}    Get File List    ${unzip_dir_path}
    Comment    setCreateDatabaseReq    ${database_key}    ${database_name}
    ${file_key}    setUploadRevitModelReq    ${database_key}    ${file_name}
    ${model_key}    setParseModelReq    ${database_key}    ${file_key}
    #等待解析完成
    waitUntilModelHasBeenParsed    ${database_key}    ${model_key}
    #验证图纸列表和图纸信息
    获取图纸列表并校验文件名和图纸信息关键字    ${database_key}    ${model_key}    ${file_name_list}
    Run Keyword And Ignore Error    Append To List    ${suit_model_list}    ${file_name}:${model_key}
    Run Keyword And Ignore Error    Append To List    ${suit_file_key_list}    ${file_name}:${file_key}

批量上传revit模型并对比文件名和验证图纸信息业务
    [Arguments]    ${database_key}    ${file_name_list}
    ${model_list}    Create List
    Set Suite Variable    ${suit_model_list}    ${model_list}
    ${file_key_list}    Create List
    Set Suite Variable    ${suit_file_key_list}    ${file_key_list}
    ${file_name_list_len}    Get Length    ${file_name_list}
    : FOR    ${i}    IN RANGE    0    ${file_name_list_len}
    \    log    =================================================================================================================================================
    \    log    ${file_name_list}[${i}]
    \    log    =================================================================================================================================================
    \    Run Keyword And Ignore Error    上传revit模型并对比文件名和验证图纸信息业务    ${database_key}    ${file_name_list}[${i}]
    log    =================================================================================================================================================
    log    model list:${suit_model_list}
    log    file key list:${suit_file_key_list}

上传dae模型并验证业务
    [Arguments]    ${database_key}    ${file_name}
    ${database_key}    Set Variable    ${database_key}
    ${database_name}    Set Variable    jfname
    #上传的模型名称
    ${file_name}    Set Variable    ${file_name}
    Comment    setCreateDatabaseReq    ${database_key}    ${database_name}
    ${file_key}    setUploadAdeModelReq    ${database_key}    ${file_name}
    ${model_key}    setParseModelReq    ${database_key}    ${file_key}
    #等待解析完成
    waitUntilModelHasBeenParsed    ${database_key}    ${model_key}
    #创建场景
    Sleep    1
    setCreateScenesReq    ${database_key}    ${model_key}
    #获取模型信息
    Sleep    1
    setGetModelInfoReq    ${database_key}    ${model_key}
    Run Keyword And Ignore Error    Append To List    ${suit_model_list}    ${file_name}:${model_key}
    Run Keyword And Ignore Error    Append To List    ${suit_file_key_list}    ${file_name}:${file_key}
    [Return]    ${model_key}

批量上传dae模型并验证
    [Arguments]    ${database_key}    ${file_name_list}
    ${model_list}    Create List
    Set Suite Variable    ${suit_model_list}    ${model_list}
    ${file_key_list}    Create List
    Set Suite Variable    ${suit_file_key_list}    ${file_key_list}
    ${file_name_list_len}    Get Length    ${file_name_list}
    : FOR    ${i}    IN RANGE    0    ${file_name_list_len}
    \    log    =================================================================================================================================================
    \    log    ${file_name_list}[${i}]
    \    log    =================================================================================================================================================
    \    Run Keyword And Ignore Error    上传dae模型并验证业务    ${database_key}    ${file_name_list}[${i}]
    log    =================================================================================================================================================
    log    model list:${suit_model_list}
    log    file key list:${suit_file_key_list}

上传ifc模型并验证业务
    [Arguments]    ${database_key}    ${file_name}
    ${database_key}    Set Variable    ${database_key}
    ${database_name}    Set Variable    jfname
    #上传的模型名称
    ${file_name}    Set Variable    ${file_name}
    Comment    setCreateDatabaseReq    ${database_key}    ${database_name}
    ${file_key}    setUploadIfcModelReq    ${database_key}    ${file_name}
    ${model_key}    setParseModelReq    ${database_key}    ${file_key}
    #等待解析完成
    waitUntilModelHasBeenParsed    ${database_key}    ${model_key}
    #创建场景
    Sleep    1
    Comment    setCreateScenesReq    ${database_key}    ${model_key}
    #获取模型信息
    Sleep    1
    Comment    setGetModelInfoReq    ${database_key}    ${model_key}
    #验证模型树所有key信息
    验证所有key的ifc模型树信息    ${database_key}    ${model_key}
    Run Keyword And Ignore Error    Append To List    ${suit_model_list}    ${file_name}:${model_key}
    Run Keyword And Ignore Error    Append To List    ${suit_file_key_list}    ${file_name}:${file_key}
    #验证ifc解析后的system字符串和数据路
    Comment    将ifc模型导出字符串与数据库进行对比

验证指定key的ifc模型树信息
    [Arguments]    ${database_key}    ${tree_key}
    setGetModelTreeInfoReq    ${database_key}    ${tree_key}

验证所有key的ifc模型树信息
    [Arguments]    ${database_key}    ${model_key}
    ${treekey_list}    setGetModelTreeListReq    ${database_key}    ${model_key}
    setGetAllModelTreeInfoReq    ${database_key}    ${treekey_list}

批量上传ifc模型并验证业务
    [Arguments]    ${database_key}    ${file_name_list}
    ${model_list}    Create List
    Set Suite Variable    ${suit_model_list}    ${model_list}
    ${file_key_list}    Create List
    Set Suite Variable    ${suit_file_key_list}    ${file_key_list}
    ${file_name_list_len}    Get Length    ${file_name_list}
    : FOR    ${i}    IN RANGE    0    ${file_name_list_len}
    \    log    =================================================================================================================================================
    \    log    ${file_name_list}[${i}]
    \    log    =================================================================================================================================================
    \    Run Keyword And Ignore Error    上传ifc模型并验证业务    ${database_key}    ${file_name_list}[${i}]
    log    =================================================================================================================================================
    log    model list:${suit_model_list}
    log    file key list:${suit_file_key_list}

将ifc模型导出字符串与数据库进行对比
    [Arguments]    ${ifc_system_file_name}=${ifc_system_file_name}
    ${ifc_system_file_name}    Set Variable    ${ifc_system_file_name}
    ${search_list}    Decode From Ifc File    ${ifc_system_file_name}
    log    ${search_list}
    ${res}    Compare List From Arango    ${search_list}    ${arango_url}    ${arango_username}    ${arango_password}    ${temp_database_key}
    ...    ${arango_collection_name}    ${arango_key_name}    ${arango_condition}
    log    ${res}

上传ifc模型并验证key以及解码后的字符串
    [Arguments]    ${database_key}    ${file_name}    ${ifc_system_file_name}=${ifc_system_file_name}
    ${model_list}    Create List
    Set Suite Variable    ${suit_model_list}    ${model_list}
    ${database_key}    Set Variable    ${database_key}
    ${database_name}    Set Variable    jfname
    #上传的模型名称
    ${file_name}    Set Variable    ${file_name}
    Comment    setCreateDatabaseReq    ${database_key}    ${database_name}
    ${file_key}    setUploadIfcModelReq    ${database_key}    ${file_name}
    ${model_key}    setParseModelReq    ${database_key}    ${file_key}
    #等待解析完成
    waitUntilModelHasBeenParsed    ${database_key}    ${model_key}
    #创建场景
    Sleep    1
    Comment    setCreateScenesReq    ${database_key}    ${model_key}
    #获取模型信息
    Sleep    1
    Comment    setGetModelInfoReq    ${database_key}    ${model_key}
    #验证模型树所有key信息
    验证所有key的ifc模型树信息    ${database_key}    ${model_key}
    Run Keyword And Ignore Error    Append To List    ${suit_model_list}    ${file_name}:${model_key}
    Run Keyword And Ignore Error    Append To List    ${suit_file_key_list}    ${file_name}:${file_key}
    #验证ifc解析后的system字符串和数据路
    将ifc模型导出字符串与数据库进行对比    ${ifc_system_file_name}

上传fbx模型并验证业务
    [Arguments]    ${database_key}    ${file_name}
    ${database_key}    Set Variable    ${database_key}
    ${database_name}    Set Variable    jfname
    #上传的模型名称
    ${file_name}    Set Variable    ${file_name}
    Comment    setCreateDatabaseReq    ${database_key}    ${database_name}
    ${file_key}    setUploadFbxModelReq    ${database_key}    ${file_name}
    ${model_key}    setParseModelReq    ${database_key}    ${file_key}
    #等待解析完成
    waitUntilModelHasBeenParsed    ${database_key}    ${model_key}
    #创建场景
    Sleep    1
    setCreateScenesReq    ${database_key}    ${model_key}
    #获取模型信息
    Sleep    1
    setGetModelInfoReq    ${database_key}    ${model_key}
    Run Keyword And Ignore Error    Append To List    ${suit_model_list}    ${file_name}:${model_key}
    Run Keyword And Ignore Error    Append To List    ${suit_file_key_list}    ${file_name}:${file_key}
    [Return]    ${model_key}

批量上传fbx模型并验证业务
    [Arguments]    ${database_key}    ${file_name_list}
    ${model_list}    Create List
    Set Suite Variable    ${suit_model_list}    ${model_list}
    ${file_key_list}    Create List
    Set Suite Variable    ${suit_file_key_list}    ${file_key_list}
    ${file_name_list_len}    Get Length    ${file_name_list}
    : FOR    ${i}    IN RANGE    0    ${file_name_list_len}
    \    log    =================================================================================================================================================
    \    log    ${file_name_list}[${i}]
    \    log    =================================================================================================================================================
    \    Run Keyword And Ignore Error    上传fbx模型并验证业务    ${database_key}    ${file_name_list}[${i}]
    log    =================================================================================================================================================
    log    model list:${suit_model_list}
    log    file key list:${suit_file_key_list}

通过filekey批量解析模型业务
    [Arguments]    ${database_key}    ${file_key_list}
    ${model_list}    Create List
    Set Suite Variable    ${suit_model_list}    ${model_list}
    ${file_key_list_len}    Get Length    ${file_key_list}
    : FOR    ${i}    IN RANGE    0    ${file_key_list_len}
    \    log    =================================================================================================================================================
    \    log    ${file_key_list}[${i}]
    \    log    =================================================================================================================================================
    \    Run Keyword And Ignore Error    通过filekey单独解析模型    ${database_key}    ${file_key_list}[${i}]
    log    =================================================================================================================================================
    log    model and file key list:${suit_model_list}

通过filekey单独解析模型
    [Arguments]    ${database_key}    ${file_key}
    ${database_key}    Set Variable    ${database_key}
    #上传的模型名称
    ${model_key}    setParseModelReq    ${database_key}    ${file_key}
    #等待解析完成
    waitUntilModelHasBeenParsed    ${database_key}    ${model_key}
    #获取模型信息
    setGetModelInfoReq    ${database_key}    ${model_key}
    Run Keyword And Ignore Error    Append To List    ${suit_model_list}    ${model_key}:${file_key}
