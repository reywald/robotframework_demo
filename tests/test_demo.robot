*** Settings ***
Documentation       To validate the Login Form

Library             Browser
Resource            ../resources/keywords.resource

Test Setup          Set Browser Timeout    30
Test Teardown       Close Browser Session


*** Variables ***
${BROWSER}      chromium


*** Test Cases ***
Validate Unsuccessful Login
    [Documentation]    To validate unsuccessful login using the Login Form
    Open The Browser With URL    BROWSER=${BROWSER}
    Fill The Login Form    username=Admin    password=Admin
    Verify Error Message Is Correct
