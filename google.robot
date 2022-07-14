*** Settings ***
Library           SeleniumLibrary
Test Setup        Go to URL
Test Teardown     Capture Page Screenshot    EMBED
Suite Teardown    Close All Browsers

*** Variables ***
${URL}    http://d-amossx-as-03.swi.srse.net:8114/AmdocsOSS/Portal/login.html

*** Test Cases ***
Simple example Search
    [Tags]    tag1
    Simple Search    Robot Framework

*** Keywords ***
Simple Search
    [Arguments]    ${SearchWord}
    Close Coockies Form If It Is
    Wait Until Element Is Enabled    id:view40
    Input Text    id:view40    setrakov
    Input Text    id:view42    123456
    Press Keys    id:view42    ENTER
    Wait Until Element Is Visible    id:ossui-mainframe-header-logout
    Location Should Contain    /AmdocsOSS/Portal/index.html

Create WebDriver With Chrome Options
    ${chrome_options} =    Evaluate    selenium.webdriver.ChromeOptions()
    Call Method    ${chrome_options}    add_argument    enable-automation
    Call Method    ${chrome_options}    add_argument    --window-size\=1920,1080
    Call Method    ${chrome_options}    add_argument    --log-level\=3
    #Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Call Method    ${chrome_options}    add_argument    --dns-prefetch-disable
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Create WebDriver    Chrome    chrome_options=${chrome_options}

Go to URL
    Create WebDriver With Chrome Options
    Go To    ${URL}
    Sleep    5s
    ${curr_location}    Get Location
    Log To Console    Current location is: ${curr_location}

Close Coockies Form If It Is
    ${is_visible}    Run Keyword And Return Status    Element Should Be Visible   id:W0wltc
    IF  ${is_visible}
        Click Element                        id:W0wltc
        Wait Until Element Is Not Visible    id:W0wltc
    END