*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary

*** Variables ***
${URL_WEB}    https://www.saucedemo.com/
${URL_API}    https://reqres.in/api
${NAVEGADOR}    chrome

*** Keywords ***
Configurar Entorno Web
    Open Browser    ${URL_WEB}    ${NAVEGADOR}
    Maximize Browser Window

Finalizar Prueba
    Close All Browsers