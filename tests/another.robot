*** Settings ***
Resource          ../resources/variables/vars_general.robot
Resource          ../resources/keywords/kws_general.robot
Resource          ../resources/keywords/kws_another.robot
Library           ../resources/keywords/kws_manual_lib.py
Library           SeleniumLibrary
Library           OperatingSystem
Library           Collections
Library           String
Library           RPA.Archive
Test Setup        Simple Setup
Test Teardown     Capture Page Screenshot    EMBED
Suite Teardown    Close All Browsers

*** Variables ***
${URL}              http://the-internet.herokuapp.com/drag_and_drop
${target}           \#column-a
${source}           \#column-b

*** Test Cases ***
Example Drag And Drop 1
    [Tags]    drag_and_drop1
    [Documentation]  This case used JS, example without JQuery
    #Drag And Drop    ${img}   ${div2}
    #Mouse Down    ${div2}
    #Mouse Up    ${div2}
    Drag And Drop By Js Only    ${target}    ${source}
    Element Text Should Be    //div[@class='column'][1]/header    B

Example Drag And Drop 2
    [Tags]    drag_and_drop2
    [Documentation]  Used more complicate JS, example with JQuery
    [Setup]   Simple Setup    https://demos.telerik.com/kendo-ui/dragdrop/index
    ${target}    Set Variable     \#draggable
    ${source}    Set Variable     \#droptarget
    Wait Until Element Is Visible    //div[@id='draggable']
    Drag And Drop By Js    ${target}    ${source}
    Element Text Should Be    //div[@id='droptarget']    You did great!

Example Drag And Drop 3
    [Tags]    drag_and_drop3
    [Documentation]  Used more simplier JS, example without JQuery
    ${js}        Get File              ${CURDIR}/../resources/scripts/drag_and_drop.js
    ${result}    Execute Javascript    ${js}; return DragNDrop("${target}", "${source}");
    Element Text Should Be    //div[@class='column'][1]/header    B

Example Drag And Drop 4
    [Tags]    drag_and_drop4
    [Documentation]  Used more simplier JS, example with JQuery
    [Setup]   Simple Setup    https://demos.telerik.com/kendo-ui/dragdrop/index
    ${target}    Set Variable     \#draggable
    ${source}    Set Variable     \#droptarget
    ${js}        Get File              ${CURDIR}/../resources/scripts/drag_and_drop.js
    Wait Until Element Is Visible    //div[@id='draggable']
    ${result}    Execute Javascript    ${js}; return DragNDrop("${target}", "${source}");
    Element Text Should Be    //div[@id='droptarget']    You did great!

Example Upload File
    [Tags]    upload_file
    [Documentation]  Simple upload file from project structure
    [Setup]   Simple Setup    https://the-internet.herokuapp.com/upload
    Wait Until Element Is Visible    id:file-submit
    ${path}    Normalize Path    ${CURDIR}/../resources/data/image_edge.jpeg
    Choose File    id:file-upload    ${path}
    Click Element    id:file-submit
    Element Text Should Be  tag:h3  File Uploaded!
    Element Text Should Be  id:uploaded-files  image_edge.jpeg

Example Download File
    [Tags]    download_file
    [Documentation]  Simple download file from source
    [Setup]   Simple Setup    https://the-internet.herokuapp.com/download
    ${target}    Set Variable     //a[contains(text(),'.txt')][1]
    Wait Until Element Is Visible    ${target}
    ${filename}    Get Text    ${target}
    Click Element    ${target}
    #Sleep    5s
    ${path}    Wait Until Keyword Succeeds    1 min    2 sec    Download Should Be Done    ${DOWNLOAD_PATH}    ${filename}
    File Should Not Be Empty    ${path}

Example Read File, Change Content And Create New File
    [Tags]    create_file
    [Documentation]  Simple upload file from project structure
    [Setup]   ${EMPTY}
    ${path}    Normalize Path    ~/Downloads/w1
    ${file}    Get File    ${path}/widget_data.json
    ${file}    Replace String    ${file}    "widget_name"    "1234 New Name"
    Create File    ${path}/widget_data_new.json    ${file}

Example Read ZIP, Change Content, Create New File, Archive to ZIP again
    [Tags]    rpa_unzip_file    rpa_zip_file
    [Documentation]  Simple working with zip file by the RPA.Archive library
    [Setup]   ${EMPTY}
    ${path}    Normalize Path    ~/Downloads/w1
    ${file}    Extract Archive    ${path}/archive1.zip    ${path}/archive1
    Archive Folder With Zip    ${path}/archive1    ${path}/archive2.zip

Example Extract ZIP By Manual Method
    [Tags]    unzip_file
    [Documentation]  Simple working with zip file by manual method
    [Setup]   ${EMPTY}
    ${rndString}    Generate Random String    8    [LETTERS][NUMBERS]
    ${path}    Normalize Path    ~/Downloads/w1
    Extract Files From Zip    ${path}/archive1.zip    ${path}/Archive_${rndString}

Example Archive Single File To ZIP By Manual Method
    [Tags]    zip_file
    [Documentation]  Simple working with zip file by manual method
    [Setup]   ${EMPTY}
    ${rndString}    Generate Random String    8    [LETTERS][NUMBERS]
    ${path}    Normalize Path    ~/Downloads/w1
    Archive File To Zip   ${path}    widget_data.json    ${path}/archive1.zip


Example Parse JSON And Check It
    [Tags]    json_file1
    [Documentation]  Simple upload file from project structure
    [Setup]   ${EMPTY}
    ${path}    Normalize Path    ~/Downloads/d-amossx-as-03_AT Manually Created Order Type EYuGZiBl.json
    ${file}    Get File    ${path}
    ${result}    JSON Loads    ${file}
    Log To Console    ${result}

