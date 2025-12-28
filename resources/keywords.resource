*** Settings ***
Documentation       This resource file contains keywords for browser operations

Library             Browser


*** Variables ***
${URL}                          https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${CHROME_EXECUTABLE_PATH}       C:\\Users\\Ikechukwu Agbarakwe\\AppData\\Local\\ms-playwright\\chromium-1179\\chrome-win\\chrome.exe
${FIREFOX_EXECUTABLE_PATH}      C:\\Users\\Ikechukwu Agbarakwe\\AppData\\Local\\ms-playwright\\firefox-1488\\firefox\\firefox.exe
${LOGIN_ERROR_MESSAGE}          css=.oxd-alert-content--error
${DASHBOARD_TEXT}               css=.oxd-topbar-header-breadcrumb-module


*** Keywords ***
Get Window Dimensions
    [Documentation]    Retrieves the current window dimensions
    ${width} =    Evaluate JavaScript    ${None}    () => window.screen.availWidth
    ${height} =    Evaluate JavaScript    ${None}    () => window.screen.availHeight
    RETURN    ${width}    ${height}

Open The Browser With URL
    [Documentation]    Opens the browser and navigates to the specified URL
    [Arguments]    ${BROWSER}='chromium'    ${WEB_URL}=${None}
    IF    $BROWSER == 'chromium'
        New Browser    browser=${BROWSER}    headless=False    executablePath=${CHROME_EXECUTABLE_PATH}
    ELSE IF    $BROWSER == 'firefox'
        New Browser    browser=${BROWSER}    headless=False    executablePath=${FIREFOX_EXECUTABLE_PATH}
    END

    IF    $WEB_URL    New Page    ${WEB_URL}    ELSE    New Page    ${URL}
    ${width}    ${height} =    Get Window Dimensions
    Set Viewport Size    width=1536    height=816

Open The Browser Headlessly With URL
    [Documentation]    Opens the browser in headless mode and navigates to the specified URL
    [Arguments]    ${BROWSER}='chromium'    ${WEB_URL}=${None}
    IF    $BROWSER == 'chromium'
        New Browser    browser=${BROWSER}    executablePath=${CHROME_EXECUTABLE_PATH}
    ELSE IF    $BROWSER == 'firefox'
        New Browser    browser=${BROWSER}    executablePath=${FIREFOX_EXECUTABLE_PATH}
    END

    IF    $WEB_URL    New Page    ${WEB_URL}    ELSE    New Page    ${URL}

Fill The Login Form
    [Documentation]    Fills the login form with provided username and password
    [Arguments]    ${username}    ${password}
    Type Text    css=input[name="username"]    ${username}
    Type Text    css=input[name="password"]    ${password}
    Click    css=.orangehrm-login-button

Verify Error Message Is Correct
    [Documentation]    Verifies that the error message displayed is correct
    ${result} =    Get Text    css=.oxd-alert-content-text
    Should Be Equal    ${result}    Invalid credentials

Verify Dashboard Page Opens
    [Documentation]    Verifies that the user logged in successfully by checking for the dashboard
    Get Text    ${DASHBOARD_TEXT}    ==    Dashboard

Close Browser Session
    [Documentation]    Closes the browser's page, context and window
    Close Browser    CURRENT
