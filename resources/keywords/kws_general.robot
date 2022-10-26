*** Settings ***
Resource          ../variables/vars_general.robot
Library           SeleniumLibrary
Library           Collections
Library           OperatingSystem

*** Keywords ***
Simple Setup
    [Arguments]    ${changed_url}=${URL}
    Create WebDriver With Chrome Options
    Go to URL    ${changed_url}
    Close Cookies Form If It Is

Create WebDriver With Chrome Options
    ${chrome_options} =    Evaluate    selenium.webdriver.ChromeOptions()
    Call Method    ${chrome_options}    add_argument    enable-automation
    Call Method    ${chrome_options}    add_argument    --window-size\=1920,1080
    Call Method    ${chrome_options}    add_argument    --log-level\=3
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Call Method    ${chrome_options}    add_argument    --dns-prefetch-disable
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    ${prefs}  Create Dictionary
    ...  download.default_directory=${DOWNLOAD_PATH}
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    Create WebDriver    Chrome    chrome_options=${chrome_options}

Go to URL
    [Arguments]    ${curr_url}
    Go To    ${curr_url}
    Sleep    ${WAIT}
    Log Source

Close Cookies Form If It Is
    ${is_visible}    Run Keyword And Return Status    Element Should Be Visible   id:W0wltc
    IF  ${is_visible}
        Click Element                        id:W0wltc
        Wait Until Element Is Not Visible    id:W0wltc
    END