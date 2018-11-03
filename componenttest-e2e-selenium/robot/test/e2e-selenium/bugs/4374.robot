*** Settings ***
Documentation     bug #4374: OAS3 parameters should be visibly validated in Try-It-Out
Test Setup        Open Swagger Config Spec    http://test-specs/bugs/4374.yaml
Library           SeleniumLibrary
Resource          ../../common/spec-loader.robot

*** Test Cases ***
Test Ufp Swagger Proxy
    [Documentation]    indicates an error when a required parameter is not selected
    Page Should Contain Element    class:opblock-tag-section
    Page Should Contain    /pet/findByStatus
    Page Should Contain Element    class:opblock
    Click Element    class:opblock
    Page Should Contain Element    class:opblock.is-open

*** Keywords ***
Open Authorization
    Click Button    Authorize

Input Username Passwort
    [Arguments]    ${user}    ${password}
    Input Text    //div[@class='wrapper'][2]//section//input    ${user}
    Input Password    //div[@class='wrapper'][3]//section/input    ${password}

Authorize Button Popup
    Click Button    //div[@class='auth-container'][1]//form//div[@class='auth-btn-wrapper']//button[@class='btn modal-btn auth authorize button']
