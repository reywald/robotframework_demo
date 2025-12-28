*** Settings ***
Documentation       All the page objects and keywords of the landing page.

Library             Browser


*** Variables ***
${DASHBOARD_TITLE}                  css=h6.oxd-topbar-header-breadcrumb-module
${LOGIN_ERROR_MESSAGE}              css=p.oxd-alert-content-text
${FORGOT_PASSWORD_LINK}             css=p.orangehrm-login-forgot-header
${MISSING_USERNAME_ERROR_MSG}       css=span.oxd-input-field-error-message
${MISSING_PASSWORD_ERROR_MSG}       css=span.oxd-input-field-error-message


*** Keywords ***
Fill The Login Form
    [Documentation]    Fill the login form with given username and password.
    [Arguments]    ${username}    ${password}
    Fill Text    css=input[name="username"]    ${username}
    Fill Text    css=input[name="password"]    ${password}
    Click    css=button[type="submit"]

Go To Forgot Your Password Page
    [Documentation]    Click on the 'Forgot your password?' link to navigate to the forgot password page.
    Click    ${FORGOT_PASSWORD_LINK}

Verify The Error Message Is Correct
    [Documentation]    Verify that the login error message matches the expected message.
    Get Text    ${LOGIN_ERROR_MESSAGE}    ==    Invalid credentials

Verify Missing Username Error Message
    [Documentation]    Verify that the missing username error message is displayed correctly.
    Get Text    ${MISSING_USERNAME_ERROR_MSG}    ==    Required

Verify Missing Password Error Message
    [Documentation]    Verify that the missing password error message is displayed correctly.
    Get Text    ${MISSING_PASSWORD_ERROR_MSG}    ==    Required
