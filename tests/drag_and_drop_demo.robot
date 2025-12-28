*** Settings ***
Documentation       To drag and drop a box

Library             Browser
Resource            ../resources/keywords.resource

Test Setup          Set Browser Timeout    60
Test Teardown       Close Browser Session


*** Test Cases ***
Verify That The User Can Drag And Drop A Box
    [Documentation]    This test case verifies that the user can drag and drop a box successfully
    Load Browser
    ${draggable_container} =    Get Element    css=#div1
    ${draggable_image} =    Get Element    css=#dragMe
    Verify Before Drag    ${draggable_image}    ${draggable_container}

    ${droppable_container} =    Get Element    css=#div2
    Drag And Drop    ${draggable_image}    ${droppable_container}
    Verify After Drag    ${draggable_image}    ${droppable_container}
    Sleep    10s


*** Keywords ***
Load Browser
    [Documentation]    Loads the browser with specified viewport size
    Open The Browser With URL    chromium    https://practice-automation.com/gestures/
    Wait For Load State    domcontentloaded

Verify Before Drag
    [Documentation]    Verifies the position and size of the draggable image before drag and drop
    [Arguments]    ${draggable_image}    ${draggable_container}
    ${image_box} =    Get BoundingBox    ${draggable_image}
    ${parent_box} =    Get BoundingBox    ${draggable_container}

    Scroll To Element    ${draggable_container}
    Log Many    ${parent_box}    ${image_box}
    Should Be True    ${parent_box.x} < ${image_box.x} and ${parent_box.y} < ${image_box.y}
    Should Be True    ${parent_box.width} > ${image_box.width} and ${parent_box.height} > ${image_box.height}

Verify After Drag
    [Documentation]    Verifies the position and size of the draggable image after drag and drop
    [Arguments]    ${draggable_image}    ${droppable_container}
    ${new_image_box} =    Get BoundingBox    ${draggable_image}
    ${new_parent_box} =    Get BoundingBox    ${droppable_container}
    Log Many    ${new_parent_box}    ${new_image_box}

    Should Be True    ${new_parent_box.x} < ${new_image_box.x} and ${new_parent_box.y} < ${new_image_box.y}
    Should Be True
    ...    ${new_parent_box.width} > ${new_image_box.width} and ${new_parent_box.height} > ${new_image_box.height}
