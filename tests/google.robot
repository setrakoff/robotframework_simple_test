*** Settings ***
Resource          ../resources/variables/vars_general.robot
Resource          ../resources/keywords/kws_general.robot
Library           SeleniumLibrary
Library           Collections
Test Setup        Simple Setup
Test Teardown     Capture Page Screenshot    EMBED
Suite Teardown    Close All Browsers

*** Variables ***
${URL}               http://google.com
${WAIT}              5s

*** Test Cases ***
Simple Example
    [Tags]    google
    Wait Until Element Is Enabled    name:q
    Input Text    name:q    Robot Framework
    Press Keys    name:q    ENTER
    Wait Until Element Is Visible    class:logo
    Location Should Contain    /search?q=Robot+Framework


Find GitHub Google Result
    [Tags]    google    github
    Wait Until Element Is Enabled    name:q
    Input Text    name:q    Robot Framework
    Press Keys    name:q    ENTER
    Wait Until Element Is Visible    class:logo
    ${widget_we}    Get Search Result    Robot Framework - GitHub
    Should Not Be Equal    ${widget_we}    ${EMPTY}
    ${locator_list}    Create List    ${widget_we}    xpath:.//a[./h3]
    Click Element    ${locator_list}
    Sleep    3s
    Log Location


Debug Case
    [Tags]    debur_oleg
    Wait Until Element Is Enabled    name:q
    ${webelement}    Get WebElement    name:q
    Find Phrase    w=${webelement}    phrase=Robot Framework
    Location Should Contain    /search?q=Robot+Framework


*** Keywords ***
Find Phrase
    [Arguments]    &{param}
    ${param_keys}    Get Dictionary Keys    ${param}
    IF  'w' in ${param_keys}
        Input Text    ${param.w}    ${param.phrase}
        Press Keys    name:q    ENTER
    Wait Until Element Is Visible    class:logo
    END

Get Search Result
    [Arguments]    ${res_header}
    ${widget_we}    Set Variable    ${EMPTY}
    @{res_list}    Get WebElements    //div[@id='rso']/div
    FOR  ${res}  IN  @{res_list}
        ${locator_list}    Create List    ${res}    xpath:.//h3
        ${title_value}    Get Text    ${locator_list}
        IF  '${title_value}' == '${res_header}'
            ${widget_we}    Set Variable    ${res}
            BREAK
        END
    END
    [Return]    ${widget_we}
