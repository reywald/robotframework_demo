*** Settings ***
Documentation       Test suite for variable handling in Browser library

Library             Collections
Library             Browser
Resource            keywords.resource

Test Teardown       Close Browser Session


*** Variables ***
&{VISIBLE_ELEMENTS}     Forgot your password?=css=.orangehrm-login-forgot-header


*** Test Cases ***
Validate Visible Elements On Login Page
    [Documentation]    To validate the visibility of specific elements on the login page
    Open The Browser With URL    BROWSER=chromium    EXEC_PATH=${CHROME_EXECUTABLE_PATH}
    Verify Element On Login Page

Validate Successful Login
    [Documentation]    To validate successful login using the Login Form
    Open The Browser With URL    BROWSER=firefox    EXEC_PATH=${FIREFOX_EXECUTABLE_PATH}
    Fill The Login Form Successfully
    Verify Dashboard Page Opens
    Verify Items In Dashboard Page


*** Keywords ***
Verify Element On Login Page
    [Documentation]    Verifies that specific elements are visible on the login page
    Get Element States    ${VISIBLE_ELEMENTS}[Forgot your password?]    validate    visible

Verify Dashboard Page Opens
    [Documentation]    Verifies that the dashboard page opens after successful login
    Get Text    css=.oxd-topbar-header-breadcrumb-module    ==    Dashboard

Verify Items In Dashboard Page
    [Documentation]    Verfifies that all elements are visible in the Dashboard
    VAR    @{expected_list} =    Admin
    ...    PIM
    ...    Leave
    ...    Time
    ...    Recruitment
    ...    My Info
    ...    Performance
    ...    Dashboard
    ...    Directory
    ...    Maintenance
    ...    Claim
    ...    Buzz
    @{elements} =    Get Elements    selector=css=.oxd-main-menu-item--name
    @{actual_list} =    Create List

    FOR    ${element}    IN    @{elements}
        ${text} =    Get Text    ${element}
        Append To List    ${actual_list}    ${text}
    END

    Lists Should Be Equal    ${expected_list}    ${actual_list}
