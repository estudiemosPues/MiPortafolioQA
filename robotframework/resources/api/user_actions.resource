*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
# Cambiamos la URL a JSONPlaceholder (Sin API Keys)
${API_BASE_URL}    https://jsonplaceholder.typicode.com

*** Keywords ***
Crear Sesion Global
    Create Session    json_place    ${API_BASE_URL}    verify=True

Obtener Usuario Por ID
    [Arguments]    ${user_id}
    # La ruta en esta API es /users/
    ${response}=    GET On Session    json_place    /users/${user_id}    expected_status=200
    RETURN    ${response.json()}

Validar Nombre De Usuario
    [Arguments]    ${json_response}    ${nombre_esperado}
    # En esta API, el campo se llama directamente 'name'
    Dictionary Should Contain Value    ${json_response}    ${nombre_esperado}