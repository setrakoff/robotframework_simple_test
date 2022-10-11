*** Settings ***
Resource          ../resources/variables/vars_general.robot
Resource          ../resources/keywords/kws_general.robot
Library           SeleniumLibrary
Library           Collections
Test Setup        Simple Setup
Test Teardown     Capture Page Screenshot    EMBED
Suite Teardown    Close All Browsers

*** Variables ***
${URL}               https://d-amossx-as-03.swi.srse.net:8701/login
${i_username_ACA}    name:user-name
${i_password_ACA}    name:password
${btn_login}         xpath://button[.='Login']

*** Test Cases ***
Simple example
    [Tags]    aca
    Wait Until Element Is Enabled    ${i_username_ACA}    ${WAIT}
    Input Text      ${i_username_ACA}    setrakov
    Input Text      ${i_password_ACA}    123456
    Click Button    ${btn_login}
    Wait Until Element Is Visible    //a/span[text()='Order Entry']
