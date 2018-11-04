*** Settings ***
Documentation     bug #4409: operationId normalization and layout tracking
Library           SeleniumLibrary
Resource          ../../common/spec-loader.robot

*** Test Cases ***
Test Ufp Swagger Proxy
    [Documentation]    expands an operation that has a normalizable operationId
    Open Swagger Config Spec    http://test-specs/bugs/4409.yaml
    Page Should Contain Element    class:opblock-tag-section
    Page Should Contain    /myApi
    Click Element    class:opblock
    Page Should Contain Element    class:opblock-body
    Page Should Contain Element    //div[contains(@class, 'opblock') and contains(@class, 'is-open')]
    Close Browser

*** Keywords ***
