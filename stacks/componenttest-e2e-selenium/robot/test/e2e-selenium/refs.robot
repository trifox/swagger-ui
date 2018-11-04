*** Settings ***
Documentation     Render Model Wrapper
Test Setup        Set Up Test Page
Test Teardown     Teardown Test Page
Library           SeleniumLibrary
Resource          ../common/spec-loader.robot

*** Variables ***

*** Test Cases ***
Render model wrapper
    [Tags]    wip
    Element Should Contain    class:title    API1 Test
    Page Should Contain    Api1Prop
    Page Should Contain    TestResponse
    Click Element    //div[@id='model-TestResponse']/span[2]
    Capture Page Screenshot
    Element Should Contain    //div[@id='model-TestResponse']    api1prop
    Element Should Contain    //div[@id='model-TestResponse']    api2prop
    Element Should Contain    //div[@id='model-TestResponse']    api2.yamlApi2Prop
    Element Should Contain    //div[@id='model-TestResponse']    this is an api2prop
    Capture Page Screenshot

*** Keywords ***
Teardown Test Page
    Capture Page Screenshot
    Close Browser

Set Up Test Page
    Open Swagger Config Spec    http://test-specs/refs/api1.yaml
    Page Should Contain Element    class:opblock-tag-section
    Capture Page Screenshot
