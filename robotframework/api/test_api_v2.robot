*** Settings ***
Resource          ../resources/api/user_actions.resource
Suite Setup       Crear Sesion Global

*** Test Cases ***
Consultar Usuario 2 Exitosamente
    ${datos_usuario}=    Obtener Usuario Por ID    2
    Validar Nombre De Usuario    ${datos_usuario}    Janet

Consultar Usuario 1 Exitosamente
    ${datos_usuario}=    Obtener Usuario Por ID    1
    Validar Nombre De Usuario    ${datos_usuario}    George