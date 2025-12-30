*** Settings ***
Documentation       This is a demo Robot Framework test suite for API testing.

Library             Collections
Library             RequestsLibrary

Suite Setup         Create Session    airportgap    ${BASE_URL}
Suite Teardown      Delete All Sessions


*** Variables ***
${BASE_URL}     https://airportgap.com/api
${PAGE_ID}      2


*** Test Cases ***
Quick GET Request Test
    [Documentation]    Run a GET Request to test retrieving a page of airports
    ${response} =    GET On Session    airportgap    /airports    params=page=${PAGE_ID}    expected_status=200
    Length Should Be    ${response.json()}[data]    30
    Length Should Be    ${response.json()}[links]    5
    Should Contain    ${response.json()}[links][first]    ${BASE_URL}

POST Request Test
    [Documentation]    Run a POST Request to get the distance between two airports
    VAR    &{params} =    from=KIX    to=LOS
    ${response} =    POST On Session    airportgap    /airports/distance    params=${params}    expected_status=200
    Status Should Be    200    ${response}
    Should Be Equal As Strings    ${response.reason}    OK
    Dictionary Should Contain Item    ${response.json()}[data]    type    airport_distance
    Dictionary Should Contain Key    ${response.json()}[data][attributes]    kilometers
    Dictionary Should Contain Key    ${response.json()}[data][attributes]    miles

# Create Favorite Airport
#     [Documentation]    Flag an airport as a favorite with an optional note
