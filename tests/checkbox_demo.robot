*** Settings ***
Documentation       Test to handle a set of checkboxes

Library             Browser
Resource            ../resources/keywords.resource

Test Setup          Set Browser Timeout    60 seconds    Test
Test Teardown       Close Browser Session


*** Variables ***
${BROWSER}      chromium
${WEB_URL}      https://demo.automationtesting.in/Register.html


*** Test Cases ***
Select An Option Of Checkbox
    [Documentation]    Select/deselect multiple checkboxes
    Open The Browser With URL    BROWSER=${BROWSER}    WEB_URL=${WEB_URL}
    Verify Page Contains Checkboxes
    Verify Page Contains A Checkbox    \#checkbox1
    Verify Page Contains A Checkbox    \#checkbox2
    Verify Page Contains A Checkbox    \#checkbox3

    Select Checkbox Option    \#checkbox1
    Select Checkbox Option    \#checkbox3
    Unselect A Checkbox Option    \#checkbox3
    Verify Checkbox Option Is Selected    \#checkbox1
    Verify Checkbox Option Is Not Selected    \#checkbox3


*** Keywords ***
Verify Page Contains A Checkbox
    [Documentation]    Verify that a checkbox exists
    [Arguments]    ${NAME}
    Get Element States    ${NAME}    validate    visible

Verify Page Contains Checkboxes
    [Documentation]    Check if there are 3 checkboxes
    Get Element Count    [type=checkbox]    ==    3

Select Checkbox Option
    [Documentation]    Selects a checkbox of given label
    [Arguments]    ${NAME}
    Check Checkbox    ${NAME}

Select Multiple Checkboxes
    [Documentation]    Select multiple checkboxes, given their labels
    [Arguments]    @{NAMES}
    FOR    ${NAME}    IN    @{NAMES}
        Select Checkbox Option    ${NAME}
    END

Unselect A Checkbox Option
    [Documentation]    Unselect a checkbox of a given lable
    [Arguments]    ${NAME}
    Uncheck Checkbox    ${NAME}

Verify Checkbox Option Is Selected
    [Documentation]    Ensure the checkbox's check state is true
    [Arguments]    ${NAME}
    Get Checkbox State    ${NAME}    ==    checked

Verify Checkbox Option Is Not Selected
    [Documentation]    Ensure the checkbox's check state is true
    [Arguments]    ${NAME}
    Get Checkbox State    ${NAME}    ==    unchecked
