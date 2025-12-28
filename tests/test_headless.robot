*** Settings ***
Documentation       To validate the Login Form in headless mode

Library             Browser
Resource            ../resources/keywords.resource

Test Setup          Set Browser Timeout    30
Test Teardown       Close Browser Session


*** Test Cases ***
Validate Unsuccessful Login Headless Chrome
    [Documentation]    To validate unsuccessful login using the Login Form in headless chrome mode
    Open The Browser Headlessly With URL    BROWSER=chromium
    Fill The Login Form    username=Admin    password=Admin
    Verify Error Message Is Correct

Validate Unsuccessful Login Headless Firefox
    [Documentation]    To validate unsuccessful login using the Login Form in headless firefox mode
    Open The Browser Headlessly With URL    BROWSER=firefox
    Fill The Login Form    username=Admin    password=Admin
    Verify Error Message Is Correct
