*** Settings ***
Documentation       All the page objects and keywords of the dashboard page.

Library             Browser


*** Variables ***
${FORGOT_PASSWORD_TITLE}    css=h6.orangehrm-forgot-password-title
${USERNAME}                 css=input[name="username"]
${RESET_BUTTON}             css=button.orangehrm-forgot-password-button--reset
${CANCEL_BUTTON}            css=button.orangehrm-forgot-password-button--cancel
${LOGIN_PAGE_TITLE}         css=h5.orangehrm-login-title
${RESET_MESSAGE}            css=h6.orangehrm-forgot-password-title


*** Keywords ***
Verify Forgot Your Password Page Opens
    [Documentation]    Verify that the "Forgot Your Password" page is opened by checking the title element.
    Get Text    ${FORGOT_PASSWORD_TITLE}    ==    Reset Password

Fill The Forgot Password Form
    [Documentation]    Fill in the username in the forgot password form.
    Fill Text    ${USERNAME}    abc@gmail.com
    Click    ${RESET_BUTTON}

Cancel The Reset Password
    [Documentation]    Click the cancel button to return to the login page.
    Click    ${CANCEL_BUTTON}

Verify The Reset Message
    [Documentation]    Verify that the reset message is displayed after submitting the forgot password form.
    Get Text    ${RESET_MESSAGE}    ==    Reset Password link sent successfully

Verify Login Page Is Displayed
    [Documentation]    Verify that the login page is displayed by checking the title element.
    Get Text    ${LOGIN_PAGE_TITLE}    ==    Login
