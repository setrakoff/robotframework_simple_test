*** Settings ***
Library           SeleniumLibrary
Test Setup        Go to G
Test Teardown     Capture Page Screenshot    EMBED
Suite Teardown    Close All Browsers

*** Variables ***
${URL}    http://google.com

*** Test Cases ***
Simple example Search
    [Tags]    tag1
    Simple Search    Robot Framework

*** Keywords ***
Simple Search
    [Arguments]    ${SearchWord}
    Close Coockies Form If It Is
    Wait Until Element Is Enabled    name:q
    Input Text    name:q    ${SearchWord}
    Press Keys    name:q    ENTER
    Wait Until Element Is Visible    class:logo
    Location Should Contain    /search?q=Robot+Framework

Create WebDriver With Chrome Options
    ${chrome_options} =    Evaluate    selenium.webdriver.ChromeOptions()
    Call Method    ${chrome_options}    add_argument    enable-automation
    Call Method    ${chrome_options}    add_argument    --log-level\=3
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Call Method    ${chrome_options}    add_argument    --dns-prefetch-disable
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Create WebDriver    Chrome    chrome_options=${chrome_options}

Go to G
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