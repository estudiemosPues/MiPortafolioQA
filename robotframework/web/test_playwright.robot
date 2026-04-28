*** Settings ***
Resource    ../resources/pages/login_browser.resource

*** Test Cases ***
Login Exitoso Con Playwright
    [Tags]    @modern_qa
    Iniciar Navegador Y SauceDemo
    Realizar Login Con Browser    standard_user    secret_sauce
    Validar Login Exitoso