*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${TXT_USUARIO}      id=user-name
${TXT_PASSWORD}     id=password
${BTN_LOGIN}        id=login-button

*** Keywords ***
Realizar Login
    [Arguments]    ${user}    ${pass}
    Input Text     ${TXT_USUARIO}     ${user}
    Input Password     ${TXT_PASSWORD}    ${pass}
    Click Button   ${BTN_LOGIN}