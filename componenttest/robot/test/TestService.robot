*** Settings ***
Documentation     This test assumes that the infra and debug stack is running.Since this is a SIDT template we believe the debug setup ist part of the provided value hence testing the debug frontend is part of the job
Library           SeleniumLibrary

*** Variables ***
${SERVICE_NAME1}    ufp-swagger-proxy
${SERVICE_PORT1}    8080
${SERVICE_NAME2}    ufp-swagger-proxy-yaml
${SERVICE_PORT2}    8080

*** Test Cases ***
Test Ufp Swagger Proxy
    [Documentation]    testing develop index page
    [Tags]    debug    non-critical
    Open Browser    http://${SERVICE_NAME1}:${SERVICE_PORT1}    Chrome
    Wait Until Page Contains    ufp-swagger
    Capture Page Screenshot    ScreenshotServiceStart.png

Test Ufp Swagger Proxy Performs
    [Documentation]    testing develop index page
    [Tags]    debug    non-critical
    Open Browser    http://${SERVICE_NAME1}:${SERVICE_PORT1}    Chrome
    Wait Until Page Contains    ufp-swagger
    Capture Page Screenshot    ScreenshotServiceStart.png
    Click Element    id:operations-pet-findPetsByStatus
    Capture Page Screenshot    ScreenshotServiceStart.png
    Click Element    class:try-out__btn
    Capture Page Screenshot    ScreenshotServiceStart.png
    Click Element    //div[@id='operations-pet-findPetsByStatus']//div[2]//div[@class='opblock-body']//div[@class='opblock-section']//div[@class='table-container']//table[@class='parameters']//tbody//tr//td[@class='col parameters-col_description']//select//option[1]
    Capture Page Screenshot    ScreenshotServiceStart.png
    Click Button    Execute
    Capture Page Screenshot    ScreenshotServiceStart.png
    Wait Until Page Contains    TypeError: Failed to fetch
    Capture Page Screenshot    ScreenshotServiceFailRequestHttp.png
    Close Browser

Test Ufp Swagger Proxy Performs With HTTP
    [Documentation]    testing develop index page
    [Tags]    debug    non-critical
    Open Browser    http://${SERVICE_NAME1}:${SERVICE_PORT1}    Chrome
    Wait Until Page Contains    ufp-swagger
    Wait Until Page Contains    findByStatus
    Capture Page Screenshot    ScreenshotServiceStart.png
    Click Element    //html//body//div[@id='swagger-ui']//section[@class='swagger-ui swagger-container']//div[@class='swagger-ui']//div[2]//div[2]//div[@class='scheme-container']//section[@class='schemes wrapper block col-12']//label//select//option[2]
    Capture Page Screenshot    ScreenshotServiceStart.png
    Click Element    id:operations-pet-findPetsByStatus
    Capture Page Screenshot    ScreenshotServiceStart.png
    Click Element    class:try-out__btn
    Capture Page Screenshot    ScreenshotServiceStart.png
    Click Element    //div[@id='operations-pet-findPetsByStatus']//div[2]//div[@class='opblock-body']//div[@class='opblock-section']//div[@class='table-container']//table[@class='parameters']//tbody//tr//td[@class='col parameters-col_description']//select//option[1]
    Capture Page Screenshot    ScreenshotServiceStart.png
    Click Button    Execute
    Scroll Element Into View    class:responses-wrapper
    Capture Page Screenshot    ScreenshotServiceStart.png
    Wait Until Page Contains    <pets>
    Scroll Element Into View    class:responses-wrapper
    Capture Page Screenshot    ScreenshotServiceFailRequestHttp.png
    Close Browser
    Close Browser

*** Keywords ***
Test Ufp Swagger Proxy With YAML Config Works
    [Documentation]    testing develop index page
    [Tags]    debug    non-critical
    Open Browser    http://${SERVICE_NAME2}:${SERVICE_PORT2}    Chrome
    Wait Until Page Contains    ufp-swagger
    Wait Until Page Contains    uploadImage
