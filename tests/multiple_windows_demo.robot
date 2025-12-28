*** Settings ***
Documentation       Switch from a main window to others

Library             Collections
Library             Browser
Resource            ../resources/keywords.resource

Test Setup          Set Browser Timeout    30
Test Teardown       Close Browser Session


*** Variables ***
${BROWSER}      chromium
${WEB_URL}      https://demo.automationtesting.in/Windows.html


*** Test Cases ***
Multiple Windows Switch
    [Documentation]    Open multiple windows and verify them
    Open The Browser With URL    ${BROWSER}    ${WEB_URL}
    Open Child Windows
    ${ID} =    Verify The Child Windows Are Opened
    Verify The User Is Back To Parent Window    ${ID}
    Sleep    10 seconds


*** Keywords ***
Open Child Windows
    [Documentation]    Click buttons to open a child window
    ${window_btn} =    Get Element By Role    LINK    name=Open Seperate Multiple Windows
    Click    ${window_btn}
    ${click_btn} =    Get Element By Role    BUTTON    name=click
    Click    ${click_btn}

Verify The Child Windows Are Opened
    [Documentation]    Switch to the child windows
    ${id} =    Switch Page    NEW    CURRENT    CURRENT
    Get Title    should be    Index
    Switch Page    NEW    CURRENT    CURRENT
    Get Title    should be    Selenium
    RETURN    ${id}

Verify The User Is Back To Parent Window
    [Documentation]    Return back to the parent windpw
    [Arguments]    ${ID}
    Switch Page    ${ID}    CURRENT    CURRENT
    Get Title    should be    Frames & windows
    Get Text    h1    should be    Automation Demo Site
