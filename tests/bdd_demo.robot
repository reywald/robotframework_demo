*** Settings ***
Documentation       A demo BDD-style test suite for testing login to a web application.

Library             Browser
Resource            generic.resource

Test Setup          Open The Browser With URL
Test Teardown       Close Browser Session


*** Variables ***
${LOGIN_ERROR_MESSAGE}      css=.oxd-alert-content--error
${DASHBOARD_TITLE}          css=h6.oxd-topbar-header-breadcrumb-module


*** Test Cases ***
Validate Unsuccessful Login With Invalid Credentials
    [Documentation]    Test to validate that login fails with invalid credentials.
    Given I Open The Browser With URL
    When I Fill The Login Form    ${INVALID_USERNAME}    ${INVALID_PASSWORD}
    Then I Should See An Error Message
    And I Close The Browser

Validate Successful Login With Valid Credentials
    [Documentation]    Test to validate that login is successful with valid credentials.
    Given I Open The Browser With URL
    When I Fill The Login Form    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Then I Should Be Logged In Successfully
    And I Close The Browser


*** Keywords ***
Given I Open The Browser With URL
    [Documentation]    Opens the browser and navigates to the specified URL.
    Open The Browser With URL

When I Fill The Login Form
    [Documentation]    Fills the login form with invalid credentials.
    [Arguments]    ${username}    ${password}
    Fill Text    css=input[name="username"]    ${username}
    Fill Text    css=input[name="password"]    ${password}
    Click    css=button[type="submit"]

Then I Should See An Error Message
    [Documentation]    Verifies that an error message is displayed for invalid login.
    Get Text    ${LOGIN_ERROR_MESSAGE}    ==    Invalid credentials

Then I Should Be Logged In Successfully
    [Documentation]    Verifies that the user is logged in successfully.
    Get Text    ${DASHBOARD_TITLE}    ==    Dashboard

And I Close The Browser
    [Documentation]    Closes the browser session.
    Close Browser Session
