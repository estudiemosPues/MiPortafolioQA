*** Settings ***
Resource          ../resources/api/user_actions.resource
Suite Setup       Crear Sesion Global

*** Test Cases ***
Consultar Usuario 1 Exitosamente
    ${datos}=    Obtener Usuario Por ID    1
    # El usuario 1 en JSONPlaceholder se llama 'Leanne Graham'
    Validar Nombre De Usuario    ${datos}    Leanne Graham

Consultar Usuario 2 Exitosamente
    ${datos}=    Obtener Usuario Por ID    2
    # El usuario 2 se llama 'Ervin Howell'
    Validar Nombre De Usuario    ${datos}    Ervin Howell