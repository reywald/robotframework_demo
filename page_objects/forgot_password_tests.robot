*** Settings ***
Documentation       Tests to validate the Forgot Your Password functionality

Library             Browser
Resource            ../resources/generic.resource
Resource            ../resources/login.resource
Resource            ../resources/forgot_password.resource

Test Setup          Open The Browser With URL
Test Teardown       Close Browser Session


*** Test Cases ***
Validate Reset Password Functionality
    [Documentation]    Test to validate the reset password functionality.
    login.Go To Forgot Your Password Page
    forgot_password.Verify Forgot Your Password Page Opens
    forgot_password.Fill The Forgot Password Form
    forgot_password.Verify The Reset Message

Validate Cancel Functionality
    [Documentation]    Test to validate the cancel functionality on Forgot Your Password page.
    login.Go To Forgot Your Password Page
    forgot_password.Verify Forgot Your Password Page Opens
    forgot_password.Cancel The Reset Password
    forgot_password.Verify Login Page Is Displayed
