*** Settings ***
Documentation     This test assumes that the infra and debug stack is running.Since this is a SIDT template we believe the debug setup ist part of the provided value hence testing the debug frontend is part of the job
Library           SeleniumLibrary

*** Variables ***
${SERVICE_NAME1}    ufp-swagger-proxy
${SERVICE_PORT1}    8080

*** Keywords ***
Open Swagger Config Spec
    [Arguments]    ${spec}
    [Documentation]    Load a spec file
    [Tags]    debug    non-critical
    Open Browser    http://${SERVICE_NAME1}:${SERVICE_PORT1}    Chrome
    Wait Until Page Contains Element    class:download-url-input
    Capture Page Screenshot    ScreenshotServiceStart.png
    Input Text    class:download-url-input    ${spec}
    Click Button    Explore
    Sleep    1s
