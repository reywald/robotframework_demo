*** Settings ***
Documentation       A demo of Data-Driven Testing (DDT) in Robot Framework.

Library             Browser
Resource            ../resources/keywords.resource

Test Setup          Set Browser Timeout    30 seconds
Test Teardown       Close Browser Session
Test Template       Validate Unsuccessful Login


*** Test Cases ***    username    password
Invalid Username    abcd    admin123
Invalid Password    Admin    abc
Special Characters    @#$    %$^&
Invalid username and Password    abcd    abc123


*** Keywords ***
Validate Unsuccessful Login
    [Documentation]    Validates that an unsuccessful login attempt shows the correct error message.
    [Arguments]    ${username}    ${password}
    Open The Browser With URL    chromium
    Fill The Login Form    ${username}    ${password}
    Verify Error Message Is Correct
