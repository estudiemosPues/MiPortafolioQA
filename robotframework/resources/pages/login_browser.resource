*** Settings ***
Library    Browser

*** Variables ***
# Los selectores en Browser Library suelen ser más potentes (texto, css, xpath)
${TXT_USUARIO}      id=user-name
${TXT_PASSWORD}     id=password
${BTN_LOGIN}        id=login-button
${HEADLESS_MODE}    True

*** Keywords ***
Iniciar Navegador Y SauceDemo
    New Browser    browser=chromium    headless=${HEADLESS_MODE}
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.saucedemo.com/

Realizar Login Con Browser
    [Arguments]    ${user}    ${pass}
    Fill Text      ${TXT_USUARIO}     ${user}
    Fill Secret    ${TXT_PASSWORD}    $pass   # 'Fill Secret' oculta el pass en los logs
    Click          ${BTN_LOGIN}

Validar Login Exitoso
    Get Text       .title    ==    Products