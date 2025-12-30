*** Settings ***
Documentation       Generate Airport details

Library             FakerLibrary

*** Keywords ***
Add Airport Provider
    FakerLibrary.Add Provider    ${None}    