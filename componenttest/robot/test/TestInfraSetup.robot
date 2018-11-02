*** Settings ***
Documentation     This test assumes that the infra and debug stack is running.Since this is a SIDT template we believe the debug setup ist part of the provided value hence testing the debug frontend is part of the job
Library           SeleniumLibrary

*** Variables ***
${SERVICE_NAME1}    wiremock-petstore
${SERVICE_PORT1}    8080
${SERVICE_NAME2}    swagger-petstore
${SERVICE_PORT2}    8080

*** Test Cases ***
Test Wiremock Petstrore
    [Documentation]    testing develop index page
    [Tags]    debug    non-critical
    Open Browser    http://${SERVICE_NAME1}:${SERVICE_PORT1}/__admin    Chrome
    Wait Until Page Contains    mappings
    Capture Page Screenshot    ScreenshotInfraWiremock.png
    Close Browser

Test Swagger Petstrore
    [Documentation]    testing develop index page
    [Tags]    debug    non-critical
    Open Browser    http://${SERVICE_NAME2}:${SERVICE_PORT2}    Chrome
    Wait Until Page Contains    swagger
    Capture Page Screenshot    ScreenshotInfraPetstore.png
    Close Browser
