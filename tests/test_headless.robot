*** Settings ***
Documentation       To validate the Login Form in headless mode

Library             Browser
Resource            keywords.resource


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
