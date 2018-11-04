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
    Scroll Into View And Check Is Visible    //div[@class='swagger-ui']//div[2]//div[6]

Render model wrapper collapse
    #    // .swagger-ui .models
    Scroll Into View And Check Is Visible    //div[@class='swagger-ui']//section[contains(@class,'models')and contains(@class,'is-open')]
    Click Element    //div[@class='swagger-ui']//section[contains(@class, 'models')]//h4
    Scroll Into View And Check Is Visible    //div[@class='swagger-ui']//section[contains(@class,'models') and not(contains(@class,'is-open'))]

Testing order model
    #    // .swagger-ui .models
    Scroll Into View And Check Is Visible    //div[@class='swagger-ui']//section[contains(@class,'models')and contains(@class,'is-open')]
    Click Element    //div[@id='model-Order']//span[contains(@class,'model-toggle')]

Testing Category model
    #    // .swagger-ui .models
    Scroll Into View And Check Is Visible    //div[@class='swagger-ui']//section[contains(@class,'models')and contains(@class,'is-open')]
    Click Element    //div[@id='model-Category']//span[contains(@class,'model-toggle')]

Testing User model
    #    // .swagger-ui .models
    Scroll Into View And Check Is Visible    //div[@class='swagger-ui']//section[contains(@class,'models')and contains(@class,'is-open')]
    Click Element    //div[@id='model-User']//span[contains(@class,'model-toggle')]

Testing Tag model
    #    // .swagger-ui .models
    Scroll Into View And Check Is Visible    //div[@class='swagger-ui']//section[contains(@class,'models')and contains(@class,'is-open')]
    Click Element    //div[@id='model-Tag']//span[contains(@class,'model-toggle')]

Testing Pet model
    #    // .swagger-ui .models
    Scroll Into View And Check Is Visible    //div[@class='swagger-ui']//section[contains(@class,'models')and contains(@class,'is-open')]
    Click Element    //div[@id='model-Pet']//span[contains(@class,'model-toggle')]

Testing ApiResponse model
    #    // .swagger-ui .models
    Scroll Into View And Check Is Visible    //div[@class='swagger-ui']//section[contains(@class,'models')and contains(@class,'is-open')]
    Click Element    //div[@id='model-ApiResponse']//span[contains(@class,'model-toggle')]

*** Keywords ***
Scroll Into View And Check Is Visible
    [Arguments]    ${locator}
    Scroll Element Into View    ${locator}
    Element Should Be Visible    ${locator}
    ${content}=    Get Text    ${locator}
    Log    Text of NODE is ${content}
    Capture Page Screenshot

Teardown Test Page
    Capture Page Screenshot
    Close Browser

Set Up Test Page
    Open Swagger Config Spec    http://test-specs/petstore.json
    Page Should Contain Element    class:opblock-tag-section
    Page Should Contain    Petstore
    Capture Page Screenshot
