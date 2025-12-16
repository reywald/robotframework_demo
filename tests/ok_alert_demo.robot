*** Settings ***
Documentation       To validate the Ok & Cancel Alert

Library             Browser
Resource            keywords.resource

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
    Verify The Text On Confirm Box On Selecting OK    ${promise}
    ${promise} =    Select The Alert With Cancel Option
    Verify The Text On Confirm Box On Selecting Cancel    ${promise}


*** Keywords ***
Select The Alert With OK Option
    [Documentation]    Select the link and alert buttons
    ${link} =    Get Element By Role    LINK    name=Alert with OK & Cancel    exact=True
    Click    ${link}
    ${promise} =    Promise To    Wait For Alert    action=accept
    ${button} =    Get Element    \#CancelTab > button
    Click    ${button}
    RETURN    ${promise}

Select The Alert With Cancel Option
    [Documentation]    Select the link and alert buttons
    ${link} =    Get Element By Role    LINK    name=Alert with OK & Cancel    exact=True
    Click    ${link}
    ${promise} =    Promise To    Wait For Alert    action=dismiss
    ${button} =    Get Element    \#CancelTab > button
    Click    ${button}
    RETURN    ${promise}

Verify The Text On Confirm Box On Selecting OK
    [Documentation]    Check the string from the alert box
    [Arguments]    ${promise}
    ${text} =    Wait For    ${promise}
    Should Be Equal    ${text}    Press a Button !
    Get Text    \#demo    ==    You pressed Ok
    Sleep    5 seconds

Verify The Text On Confirm Box On Selecting Cancel
    [Documentation]    Check the string from the alert box
    [Arguments]    ${promise}
    ${text} =    Wait For    ${promise}
    Should Be Equal    ${text}    Press a Button !
    Get Text    \#demo    ==    You Pressed Cancel
    Sleep    5 seconds
