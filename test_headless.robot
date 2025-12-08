*** Settings ***
Documentation       To validate the Login Form in headless mode

Library             Browser


*** Variables ***
${URL}                          https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}                     Admin
${PASSWORD}                     Admin
${CHROME_EXECUTABLE_PATH}       C:\\Users\\Ikechukwu Agbarakwe\\AppData\\Local\\ms-playwright\\chromium-1179\\chrome-win\\chrome.exe
${FIREFOX_EXECUTABLE_PATH}      C:\\Users\\Ikechukwu Agbarakwe\\AppData\\Local\\ms-playwright\\firefox-1488\\firefox\\firefox.exe


*** Test Cases ***
Validate Unsuccessful Login Headless Chrome
    [Documentation]    To validate unsuccessful login using the Login Form in headless chrome mode
    Open The Browser Headlessly With URL    BROWSER=chromium    EXEC_PATH=${CHROME_EXECUTABLE_PATH}
    Fill The Login Form
    Verify Error Message Is Correct

Validate Unsuccessful Login Headless Firefox
    [Documentation]    To validate unsuccessful login using the Login Form in headless firefox mode
    Open The Browser Headlessly With URL    BROWSER=firefox    EXEC_PATH=${FIREFOX_EXECUTABLE_PATH}
    Fill The Login Form
    Verify Error Message Is Correct


*** Keywords ***
Open The Browser Headlessly With URL
    [Documentation]    Opens the browser in headless mode and navigates to the specified URL
    [Arguments]    ${BROWSER}    ${EXEC_PATH}
    New Browser    ${BROWSER}    headless=True    args=["--start-maximized"]    executablePath=${EXEC_PATH}
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
