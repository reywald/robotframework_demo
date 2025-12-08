*** Settings ***
Documentation       To validate the Login Form

Library             Browser


*** Variables ***
${BROWSER}              chromium
${URL}                  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}             Admin
${PASSWORD}             Admin
${EXECUTABLE_PATH}      C:\\Users\\Ikechukwu Agbarakwe\\AppData\\Local\\ms-playwright\\chromium-1179\\chrome-win\\chrome.exe


*** Test Cases ***
Validate Unsuccessful Login
    [Documentation]    To validate unsuccessful login using the Login Form
    Open The Browser With URL
    Fill The Login Form
    Verify Error Message Is Correct


*** Keywords ***
Open The Browser With URL
    [Documentation]    Opens the browser and navigates to the specified URL
    New Browser    ${BROWSER}    headless=False    args=["--start-maximized"]    executablePath=${EXECUTABLE_PATH}
    New Page    ${URL}

Fill The Login Form
    [Documentation]    Fills the login form with provided username and password
    Type Text    css=input[name="username"]    ${USERNAME}
    Type Text    css=input[name="password"]    ${PASSWORD}
    Click    css=.orangehrm-login-button

Verify Error Message Is Correct
    [Documentation]    Verifies that the error message displayed is correct
    ${result}=    Get Text    css=.oxd-alert-content-text
    Should Be Equal    ${result}    Invalid credentials
