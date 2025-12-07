*** Settings ***
Documentation    To validate the Login Form
Library    Browser

*** Variables ***
${BROWSER}    chromium
${URL}    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}    Admin
${PASSWORD}    Admin
${EXECUTABLE_PATH}    C:\\Users\\Ikechukwu Agbarakwe\\AppData\\Local\\ms-playwright\\chromium-1179\\chrome-win\\chrome.exe

*** Test Cases ***
Validate Unsuccessful Login
    Open the Browser with URL
    Fill the login form
    Verify error message is correct


*** Keywords ***
Open the Browser with URL
    New Browser    ${BROWSER}   headless=False    args=["--start-maximized"]    executablePath=${EXECUTABLE_PATH}
    New Page    ${URL}

Fill the login form
    Type Text    css=input[name="username"]    ${USERNAME}
    Type Text    css=input[name="password"]   ${PASSWORD}
    Click   css=.orangehrm-login-button

Verify error message is correct
    ${result}=    Get Text    css=.oxd-alert-content-text
    Should Be Equal    ${result}    Invalid credentials