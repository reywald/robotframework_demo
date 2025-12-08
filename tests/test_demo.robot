*** Settings ***
Documentation       To validate the Login Form

Library             Browser
Resource            keywords.resource


*** Variables ***
${BROWSER}      chromium


*** Test Cases ***
Validate Unsuccessful Login
    [Documentation]    To validate unsuccessful login using the Login Form
    Open The Browser With URL    BROWSER=${BROWSER}    EXEC_PATH=${CHROME_EXECUTABLE_PATH}
    Fill The Login Form
    Verify Error Message Is Correct
