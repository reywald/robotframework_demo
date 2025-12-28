*** Settings ***
Documentation       Resource file with reusable keywords and variables.

Library             Browser


*** Variables ***
${VALID_USERNAME}       Admin
${VALID_PASSWORD}       admin123
${INVALID_USERNAME}     1234
${INVALID_PASSWORD}     45678
${BLANK_USERNAME}       ${EMPTY}
${BLANK_PASSWORD}       ${EMPTY}
${URL}                  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}              chromium


*** Keywords ***
Open The Browser With URL
    [Documentation]    Opens the browser and navigates to the specified URL
    New Browser
    ...    browser=${BROWSER}
    ...    executablePath=C:\\Users\\Ikechukwu Agbarakwe\\AppData\\Local\\ms-playwright\\chromium-1179\\chrome-win\\chrome.exe
    ...    headless=False
    New Page    ${URL}
    Set Viewport Size    width=1536    height=816

Close Browser Session
    [Documentation]    Closes the browser session
    Close Browser
