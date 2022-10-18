*** Settings ***
Resource          ../variables/vars_general.robot
Library           SeleniumLibrary
Library           OperatingSystem

*** Keywords ***
Download Should Be Done
    [Arguments]    ${directory}    ${filename}
    [Documentation]    Verifies that the directory has file and no one temp file is presented.
    ...
    ...    Returns path to the file
    ${file}    Join Path    ${directory}    ${filename}
    ${files}    List Files In Directory    ${directory}
    FOR  ${f}  IN  @{files}
        Should Not Match Regexp    ${f}    (?i).*\\.tmp    Chrome is still downloading a file
    END
    File Should Exist    ${file}
    Log    File was successfully downloaded to ${file}
    [Return]    ${file}


Create New Unique Directory
  [Arguments]    ${parent_dir}
  [Documentation]    Create new  unique directory.
  ...
  ...    Returns path to created directory

  ${now}    Get Time    epoch
  ${new_dir}    Join Path    ${parent_dir}    downloads_${now}
  Create Directory    ${new_dir}
  [Return]    ${new_dir}
