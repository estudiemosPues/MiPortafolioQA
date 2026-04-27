*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${API_BASE_URL}    https://reqres.in/api

*** Keywords ***
Crear Sesion Global
    Create Session    reqres    ${API_BASE_URL}    verify=True

Obtener Usuario Por ID
    [Arguments]    ${user_id}
    ${response}=    GET On Session    reqres    /users/${user_id}    expected_status=200
    RETURN    ${response.json()}

Validar Nombre De Usuario
    [Arguments]    ${json_response}    ${nombre_esperado}
    Dictionary Should Contain Value    ${json_response['data']}    ${nombre_esperado}