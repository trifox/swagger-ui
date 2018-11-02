*** Settings ***
Documentation     This test assumes that the infra and debug stack is running.Since this is a SIDT template we believe the debug setup ist part of the provided value hence testing the debug frontend is part of the job
Library           SeleniumLibrary

*** Variables ***
${SERVICE_NAME1}    ufp-swagger-proxy
${SERVICE_PORT1}    8080

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
    Select From List By Value    class:select available
    Capture Page Screenshot    ScreenshotServiceStart.png
    Click Element    link:Execute
    Click Element    //html//body//div[@id='swagger-ui']//section[@class='swagger-ui swagger-container']//div[@class='swagger-ui']//div[2]//div[@class='wrapper'][1]//section[@class='block col-12 block-desktop col-12-desktop']//div//span[1]//div[@class='opblock-tag-section is-open']//div//span[3]//div[@id='operations-pet-findPetsByStatus']//div[2]//div[@class='opblock-body']//div[@class='opblock-section']//div[@class='table-container']//table[@class='parameters']//tbody//tr//td[@class='col parameters-col_description']//select//option[1]
    Capture Page Screenshot    ScreenshotServiceStart.png
