*** Settings ***
Documentation       All the page objects and keywords of the dashboard page.

Library             Browser


*** Variables ***
${DASHBOARD_TITLE}      css=h6.oxd-topbar-header-breadcrumb-module


*** Keywords ***
Verify Dashboard Page Is Open
    [Documentation]    Verify that the dashboard page is open by checking the dashboard title.
    Get Text    ${DASHBOARD_TITLE}    should be    Dashboard
