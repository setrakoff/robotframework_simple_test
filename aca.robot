*** Settings ***
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
${WAIT}              5s

*** Test Cases ***
Simple example
    [Tags]    aca
    Wait Until Element Is Enabled    ${i_username_ACA}    ${WAIT}
    Input Text      ${i_username_ACA}    setrakov
    Input Text      ${i_password_ACA}    123456
    Click Button    ${btn_login}
    Wait Until Element Is Visible    //a/span[text()='Order Entry']


*** Keywords ***
Simple Setup
    Create WebDriver With Chrome Options
    Go to URL    ${URL}
    Close Cookies Form If It Is

Create WebDriver With Chrome Options
    ${chrome_options} =    Evaluate    selenium.webdriver.ChromeOptions()
    #Call Method    ${chrome_options}    add_argument    enable-automation
    Call Method    ${chrome_options}    add_argument    --window-size\=1920,1080
    #Call Method    ${chrome_options}    add_argument    --log-level\=3
    #Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    #Call Method    ${chrome_options}    add_argument    --dns-prefetch-disable
    #Call Method    ${chrome_options}    add_argument    --disable-gpu
    Create WebDriver    Chrome    chrome_options=${chrome_options}

Go to URL
    [Arguments]    ${curr_url}
    Go To    ${curr_url}
    Sleep    ${WAIT}
    ${curr_location}    Get Location
    Log To Console    Current location is: ${curr_location}
    Log Source

Close Cookies Form If It Is
    ${is_visible}    Run Keyword And Return Status    Element Should Be Visible   id:W0wltc
    IF  ${is_visible}
        Click Element                        id:W0wltc
        Wait Until Element Is Not Visible    id:W0wltc
    END