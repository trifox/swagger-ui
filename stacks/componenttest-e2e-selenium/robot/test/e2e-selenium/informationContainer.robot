*** Settings ***
Documentation     Render Model Wrapper
Test Setup        Set Up Test Page
Test Teardown     Teardown Test Page
Library           SeleniumLibrary
Resource          ../common/spec-loader.robot

*** Variables ***

*** Test Cases ***
Render model wrapper
    #    // div.swagger-ui > div:nth-child(2) > div:nth-child(6)",
    Element Should Contain    class:title    Swagger Petstore
    Element Should Contain    class:version    1.0.0
    Element Should Contain    class:info    ufp-swagger-proxy:8080/proxy/http://test-specs:80/
    Element Should Contain    class:info    Terms of service
    Element Should Contain    class:info    Contact the developer
    Element Should Contain    class:info    Apache 2.0
    Element Should Contain    class:info    Find out more about Swagger

*** Keywords ***
Teardown Test Page
    Capture Page Screenshot
    Close Browser

Set Up Test Page
    Open Swagger Config Spec    http://test-specs/petstore.json
    Page Should Contain Element    class:opblock-tag-section
    Page Should Contain    Petstore
    Capture Page Screenshot
