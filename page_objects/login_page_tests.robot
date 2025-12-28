*** Settings ***
Documentation       Tests to login to Login Page

Library             Browser
Resource            ../resources/generic.resource
Resource            ../resources/login.resource
Resource            ../resources/dashboard.resource
Resource            ../resources/forgot_password.resource

Test Setup          Open The Browser With URL
Test Teardown       Close Browser Session


*** Test Cases ***
Validate Unsuccessful Login With Invalid Credentials
    [Documentation]    Test to validate unsuccessful login with invalid credentials.
    login.Fill The Login Form    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    login.Verify The Error Message Is Correct

Validate Unsuccessful Login With Blank Username
    [Documentation]    Test to validate unsuccessful login with blank username.
    login.Fill The Login Form    ${BLANK_USERNAME}    ${VALID_PASSWORD}
    login.Verify Missing Username Error Message

Validate Unsuccessful Login With Blank Password
    [Documentation]    Test to validate unsuccessful login with blank password.
    login.Fill The Login Form    ${VALID_USERNAME}    ${BLANK_PASSWORD}
    login.Verify Missing Password Error Message

Validate Successful Login With Valid Credentials
    [Documentation]    Test to validate successful login with valid credentials.
    login.Fill The Login Form    ${VALID_USERNAME}    ${VALID_PASSWORD}
    dashboard.Verify Dashboard Page Is Open
