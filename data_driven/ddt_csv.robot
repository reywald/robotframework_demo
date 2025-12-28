*** Settings ***
Documentation       A demo of Data-Driven Testing (DDT) with CSV in Robot Framework.

Library             Browser
Library             DataDriver    file=./data.csv    encoding=UTF-8    dialect=unix
Resource            ../resources/keywords.resource

Test Setup          Set Browser Timeout    30 seconds
Test Teardown       Close Browser Session
Test Template       Validate Unsuccessful Login


*** Test Cases ***
Login To Form Using ${username} And ${password}    abc    123


*** Keywords ***
Validate Unsuccessful Login
    [Documentation]    Validates that an unsuccessful login attempt shows the correct error message.
    [Arguments]    ${username}    ${password}
    Open The Browser With URL    chromium
    Fill The Login Form    ${username}    ${password}
    Verify Error Message Is Correct
