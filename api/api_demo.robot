*** Settings ***
Documentation       This is a demo Robot Framework test suite for API testing.

Library             Collections
Library             RequestsLibrary
Library             FakerLibrary
Library             faker_airport.FakerAirport    AS    FakerAirport

Suite Setup         Test Suite Setup
Suite Teardown      Delete All Sessions


*** Variables ***
${BASE_URL}     https://airportgap.com/api
${PAGE_ID}      2
${TOKEN}        ${EMPTY}


*** Test Cases ***
Quick GET Request Test
    [Documentation]    Run a GET Request to test retrieving a page of airports
    ${response} =    GET On Session    airportgap    /airports    params=page=${PAGE_ID}    expected_status=200
    Length Should Be    ${response.json()}[data]    30
    Length Should Be    ${response.json()}[links]    5
    Should Contain    ${response.json()}[links][first]    ${BASE_URL}
    Log To Console    ${TOKEN}

POST Request Test
    [Documentation]    Run a POST Request to get the distance between two airports
    VAR    &{params} =    from=KIX    to=LOS
    ${response} =    POST On Session    airportgap    /airports/distance    params=${params}    expected_status=200
    Status Should Be    200    ${response}
    Should Be Equal As Strings    ${response.reason}    OK
    Dictionary Should Contain Item    ${response.json()}[data]    type    airport_distance
    Dictionary Should Contain Key    ${response.json()}[data][attributes]    kilometers
    Dictionary Should Contain Key    ${response.json()}[data][attributes]    miles

Create A Favorite Airport
    [Documentation]    Create an airport favorite
    ${id} =    FakerAirport.Airport IATA
    ${note} =    FakerLibrary.Sentence    nb_words=15    variable_nb_words=True
    ${response} =    Create Favorite Airport    ${id}    ${note}
    Status Should Be    201    ${response}
    Should Be Equal As Strings    ${response.reason}    Created
    Dictionary Should Contain Key    ${response.json()}[data]    id
    Dictionary Should Contain Key    ${response.json()}[data]    attributes
    Dictionary Should Contain Item    ${response.json()}[data]    type    favorite
    Dictionary Should Contain Item    ${response.json()}[data][attributes]    note    ${note}
    Dictionary Should Contain Item    ${response.json()}[data][attributes][airport]    iata    ${id}

Create Already Existing Favorite Airport
    [Documentation]    Create an airport favorite
    ${id} =    FakerAirport.Airport IATA
    ${note} =    FakerLibrary.Sentence    nb_words=15    variable_nb_words=True
    ${response} =    Create Favorite Airport    ${id}    ${note}
    Status Should Be    422    ${response}
    Should Be Equal As Strings    ${response.reason}    Unprocessable Entity
    Dictionary Should Contain Key    ${response.json()}    errors
    ${errors: list} =    Get From Dictionary    ${response.json()}    errors
    Dictionary Should Contain Key    ${errors}[0]    status
    Dictionary Should Contain Item    ${errors}[0]    title    Unable to process request
    Dictionary Should Contain Item    ${errors}[0]    detail    Airport This airport is already in your favorites

Update A Favorite Airport's Note
    [Documentation]    Update the notes of a favorite airport entry
    ${id} =    FakerAirport.Airport IATA
    ${note} =    FakerLibrary.Sentence    nb_words=15    variable_nb_words=True
    ${response} =    Update Favorite Airport    ${id}    ${note}
    Status Should Be    200    ${response}
    Should Be Equal As Strings    ${response.reason}    OK
    Dictionary Should Contain Item    ${response.json()}[data]    type    favorite
    Dictionary Should Contain Item    ${response.json()}[data][attributes][airport]    iata    ${id}
    Should Be Equal As Strings    ${response.json()}[data][attributes][note]    ${note}


*** Keywords ***
Test Suite Setup
    [Documentation]    Create a resuable HTTP session and token
    Create Session    alias=airportgap    url=${BASE_URL}
    Get Airport Gap Token

Create Favorite Airport
    [Documentation]    Create an airport favorite
    [Arguments]    ${id}    ${note}
    VAR    &{params} =    airport_id=${id}    note=${note}
    VAR    &{headers} =    Authorization=Bearer ${TOKEN}

    ${response} =    POST On Session
    ...    airportgap
    ...    /favorites
    ...    params=${params}
    ...    headers=${headers}
    ...    expected_status=anything
    RETURN    ${response}

Fetch Favorite Airport
    [Documentation]    Return a favorite airport specified by the ID
    [Arguments]    ${id}
    VAR    &{headers} =    Authorization=Bearer ${TOKEN}

    ${response} =    GET On Session    airportgap    /favorites/${id}    headers=${headers}    expected_status=anything
    RETURN    ${response}

Update Favorite Airport
    [Documentation]    Update the note of a favorite airport
    [Arguments]    ${id}    ${note}
    VAR    &{headers} =    Authorization=Bearer ${TOKEN}
    VAR    &{params} =    note=${note}

    ${response} =    PATCH On Session
    ...    airportgap
    ...    /favorites/${id}
    ...    headers=${headers}
    ...    params=${params}
    ...    expected_status=anything
    RETURN    ${response}

Delete Favorite Airport
    [Documentation]    DELETE a favorite airport by its ID
    [Arguments]    ${id}
    VAR    &{headers} =    Authorization=Bearer ${TOKEN}

    ${response} =    DELETE On Session
    ...    airportgap
    ...    /favorites/${id}
    ...    headers=${headers}
    ...    expected_status=anything
    Status Should Be    204    ${response}
    Should Be Equal As Strings    ${response.reason}    No Content
    RETURN    ${response}

Delete All Favorited Airports
    [Documentation]    Run the DELETE endpoint to clear all favorite records
    VAR    &{headers} =    Authorization=Bearer ${TOKEN}

    ${response} =    DELETE On Session
    ...    airportgap
    ...    /favorites/clear_all
    ...    headers=${headers}
    ...    expected_status=anything
    Status Should Be    204    ${response}
    Should Be Equal As Strings    ${response.reason}    No Content
    RETURN    ${response}

Get Airport Gap Token
    [Documentation]    Get the authorization token using valid credentials
    VAR    &{params} =    email=iaweepingsaint@gmail.com    password=veXL%q-^1n!^1ZUu
    ${response} =    POST On Session    airportgap    /tokens    params=${params}
    Status Should Be    200    ${response}
    Should Be Equal As Strings    ${response.reason}    OK
    Dictionary Should Contain Key    ${response.json()}    token
    VAR    ${TOKEN} =    ${response.json()}[token]    scope=SUITE
