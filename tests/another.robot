*** Settings ***
Resource          ../resources/variables/vars_general.robot
Resource          ../resources/keywords/kws_general.robot
Library           ../resources/keywords/kws_manual_lib.py
Library           SeleniumLibrary
Library           OperatingSystem
Library           Collections
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
