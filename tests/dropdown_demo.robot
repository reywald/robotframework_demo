*** Settings ***
Documentation       Tests to handle a set of dropdown options

Library             Browser
Resource            keywords.resource

Test Setup          Set Browser Timeout    30
Test Teardown       Close Browser Session


*** Variables ***
${BROWSER}      chromium
${WEB_URL}      https://demo.automationtesting.in/Register.html


*** Test Cases ***
Select Options In Dropdown
    [Documentation]    Select multiple options
    Open The Browser With URL    ${BROWSER}    ${WEB_URL}
    Select A Dropdown Option By Value    APIs
    Select A Dropdown Option By Label    CSS
    Select A Dropdown Option By Index    43


*** Keywords ***
Select A Dropdown Option By Value
    [Documentation]    Select a dropdown option given the value
    [Arguments]    ${value}
    Select Options By    \#Skills    value    ${value}
    Get Selected Options    \#Skills    value    should be    ${value}

Select A Dropdown Option By Label
    [Documentation]    Select a dropdown option given the label
    [Arguments]    ${label}
    Select Options By    \#Skills    label    ${label}
    Get Selected Options    \#Skills    label    should be    ${label}

Select A Dropdown Option By Index
    [Documentation]    Select a dropdown option given the index
    [Arguments]    ${index}
    Select Options By    \#Skills    index    ${index}
    Get Selected Options    \#Skills    index    should be    ${index}
