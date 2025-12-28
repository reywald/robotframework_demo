*** Settings ***
Documentation       To validate the Message Alert

Library             Browser
Resource            ../resources/keywords.resource

Test Setup          Set Browser Timeout    30
Test Teardown       Close Browser Session


*** Variables ***
${BROWSER}      chromium
${URL}          https://demo.automationtesting.in/Alerts.html


*** Test Cases ***
Handle Message Alert
    [Documentation]    Open an alert dialog
    Open The Browser With URL    ${BROWSER}    ${URL}
    ${promise} =    Select The Alert With OK Option
    Verify The Text On Alert Box    ${promise}


*** Keywords ***
Select The Alert With OK Option
    [Documentation]    Select the link and alert buttons
    ${link} =    Get Element By Role    LINK    name=Alert with OK    exact=True
    Click    ${link}
    ${promise} =    Promise To    Wait For Alert    action=accept
    ${button} =    Get Element    \#OKTab > button
    Click    ${button}
    RETURN    ${promise}

Verify The Text On Alert Box
    [Documentation]    Check the string from the alert box
    [Arguments]    ${promise}
    ${text} =    Wait For    ${promise}
    Should Be Equal    ${text}    I am an alert box!
    Sleep    5 seconds
