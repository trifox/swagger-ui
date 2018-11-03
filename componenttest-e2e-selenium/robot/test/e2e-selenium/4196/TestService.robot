*** Settings ***
Documentation     This test assumes that the infra and debug stack is running.Since this is a SIDT template we believe the debug setup ist part of the provided value hence testing the debug frontend is part of the job
Library           SeleniumLibrary
Resource          ../../common/spec-loader.robot

*** Test Cases ***
Test Ufp Swagger Proxy
    [Documentation]    testing develop index page
    [Tags]    debug    non-critical
    Open Swagger Config Spec    http://test-specs/bugs/4196.yaml
    Capture Page Screenshot
    Click Button    Authorize
    Input Text    //div[@class='wrapper'][2]//section//input    aaa
    Input Password    //div[@class='wrapper'][3]//section/input    aaa
    Click Button    //div[@class='auth-container'][1]//form//div[@class='auth-btn-wrapper']//button[@class='btn modal-btn auth authorize button']
    Capture Page Screenshot
    Click Button    class:close-modal
    Capture Page Screenshot
    Click Button    Authorize
    Capture Page Screenshot
