*** Settings ***
Documentation       To validate the Textbox Alert

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
    Select The Prompt Alert And Enter Text
    Verify The Text Entered In Textbox
    Select The Prompt Alert But Cancel
    Verify No Text After Canceling The Prompt


*** Keywords ***
Select The Prompt Alert And Enter Text
    [Documentation]    Select the link and alert buttons
    ${link} =    Get Element By Role    LINK    name=Alert with Textbox    exact=True
    Click    ${link}
    ${promise} =    Promise To    Wait For Alert    action=accept    prompt_input=Hello World!
    ${button} =    Get Element    \#Textbox > button
    Click    ${button}
    Wait For    ${promise}

Select The Prompt Alert But Cancel
    [Documentation]    Select the Prompt alert but click the cancel button
    ${link} =    Get Element By Role    LINK    name=Alert with Textbox    exact=True
    Click    ${link}
    Handle Future Dialogs    dismiss
    ${button} =    Get Element    \#Textbox > button
    Click    ${button}

Verify The Text Entered In Textbox
    [Documentation]    Check the string from the alert box
    ${text} =    Get Text    \#demo1
    Should Be Equal    ${text}    Hello Hello World! How are you today
    Sleep    5 seconds

Verify No Text After Canceling The Prompt
    [Documentation]    Check the text generated after canceling the prompt
    ${text} =    Get Text    \#demo1
    Should Be Empty    ${text}
    Sleep    5 seconds
