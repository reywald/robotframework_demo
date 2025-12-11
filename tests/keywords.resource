*** Settings ***
Documentation       This resource file contains keywords for browser operations

Library             Browser


*** Variables ***
${URL}                          https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${USERNAME}                     Admin
${PASSWORD}                     Admin
${VALID_USERNAME}               Admin
${VALID_PASSWORD}               admin123
${CHROME_EXECUTABLE_PATH}       C:\\Users\\Ikechukwu Agbarakwe\\AppData\\Local\\ms-playwright\\chromium-1179\\chrome-win\\chrome.exe
${FIREFOX_EXECUTABLE_PATH}      C:\\Users\\Ikechukwu Agbarakwe\\AppData\\Local\\ms-playwright\\firefox-1488\\firefox\\firefox.exe


*** Keywords ***
Open The Browser With URL
    [Documentation]    Opens the browser and navigates to the specified URL
    [Arguments]    ${BROWSER}    ${WEB_URL}=${None}
    IF    $BROWSER == 'chromium'
        New Browser    browser=${BROWSER}    headless=False    executablePath=${CHROME_EXECUTABLE_PATH}
    ELSE IF    $BROWSER == 'firefox'
        New Browser    browser=${BROWSER}    headless=False    executablePath=${FIREFOX_EXECUTABLE_PATH}
    END

    IF    $WEB_URL    New Page    ${WEB_URL}    ELSE    New Page    ${URL}

Open The Browser Headlessly With URL
    [Documentation]    Opens the browser in headless mode and navigates to the specified URL
    [Arguments]    ${BROWSER}    ${WEB_URL}=${None}
    IF    $BROWSER == 'chromium'
        New Browser    browser=${BROWSER}    headless=True    executablePath=${CHROME_EXECUTABLE_PATH}
    ELSE IF    $BROWSER == 'firefox'
        New Browser    browser=${BROWSER}    headless=True    executablePath=${FIREFOX_EXECUTABLE_PATH}
    END

    IF    $WEB_URL    New Page    ${WEB_URL}    ELSE    New Page    ${URL}

Fill The Login Form
    [Documentation]    Fills the login form with provided username and password
    Type Text    css=input[name="username"]    ${USERNAME}
    Type Text    css=input[name="password"]    ${PASSWORD}
    Click    css=.orangehrm-login-button

Fill The Login Form Successfully
    [Documentation]    Fills the login form with provided username and password
    Type Text    css=input[name="username"]    ${VALID_USERNAME}
    Type Text    css=input[name="password"]    ${VALID_PASSWORD}
    Click    css=.orangehrm-login-button

Verify Error Message Is Correct
    [Documentation]    Verifies that the error message displayed is correct
    ${result} =    Get Text    css=.oxd-alert-content-text
    Should Be Equal    ${result}    Invalid credentials

Close Browser Session
    [Documentation]    Closes the browser's page, context and window
    Close Browser    CURRENT
