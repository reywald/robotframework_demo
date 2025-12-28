*** Settings ***
Documentation       Tests for switching between browser tabs

Library             Collections
Library             Browser
Resource            ../resources/keywords.resource

Test Setup          Set Browser Timeout    30
Test Teardown       Close Browser Session


*** Variables ***
${BROWSER}      chromium
${WEB_URL}      https://demo.automationtesting.in/Windows.html


*** Test Cases ***
Switch Windows
    [Documentation]    Switch to a child window and back
    Open The Browser With URL    ${BROWSER}    ${WEB_URL}
    # ${ID} =    Get Page IDs    CURRENT    CURRENT    CURRENT
    ${consent_btn} =    Get Element By Role    BUTTON    name=Do not consent
    Click    ${consent_btn}
    Open Child Window
    ${ID} =    Verify The Child Window Is Opened
    Verify The User Is Back To Parent Window    ${ID}


*** Keywords ***
Open Child Window
    [Documentation]    Click buttons to open a child window
    ${window_btn} =    Get Element By Role    LINK    name=Open New Seperate Windows
    Click    ${window_btn}
    ${click_btn} =    Get Element By Role    BUTTON    name=click
    Click    ${click_btn}

Verify The Child Window Is Opened
    [Documentation]    Switch to the child window
    ${ID} =    Switch Page    NEW
    Get Element By    Text    Selenium automates browsers
    RETURN    ${ID}

Verify The User Is Back To Parent Window
    [Documentation]    Switch back to the parent window
    [Arguments]    ${ID}
    Switch Page    ${ID}
    Get Element By Role    HEADING    name=Automation Demo Site
    Sleep    4 seconds
