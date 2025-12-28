*** Settings ***
Documentation       Tests to login in the Login Page

Library             Browser
Resource            ../resources/keywords.resource

Test Setup          Set Browser Timeout    30
Test Teardown       Close Browser Session


*** Test Cases ***
Validate Unsuccessful Login
    [Documentation]    Login with wrong credentials
    Open The Browser With URL    chromium
    Fill The Login Form    username=Admin    password=admin
    Verify Error Message Is Correct

Validate Successful Login
    [Documentation]    Login with valid credentials
    Open The Browser With URL    chromium
    Fill The Login Form    username=Admin    password=admin123
    Verify Dashboard Page Opens
