*** Settings ***
Documentation       To handle the Male and Female radio buttons on a form

Library             Browser
Resource            keywords.resource

Test Teardown       Close Browser Session


*** Variables ***
${BROWSER}      chromium
${WEB_URL}      https://demo.automationtesting.in/Register.html


*** Test Cases ***
Select An Option Of Radio Button
    [Documentation]    Select a radio button
    Open The Browser With URL    BROWSER=${BROWSER}    EXEC_PATH=${CHROME_EXECUTABLE_PATH}    WEB_URL=${WEB_URL}
    Select Impressive Option From 3 Radio Buttons
    Verify That The Radio Button Is Selected


*** Keywords ***
Select Impressive Option From 3 Radio Buttons
    [Documentation]    Select radio button
    ${radio} =    Get Element By Role    RADIO    name=Male    exact=True
    Click    selector=${radio}

Verify That The Radio Button Is Selected
    [Documentation]    Verify the selected radio button
    ${radio} =    Get Element By Role    RADIO    checked=True
    Get Attribute    ${radio}    value    ==    Male
