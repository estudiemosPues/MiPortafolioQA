*** Settings ***
# Importamos ambos "departamentos"
Resource          ../resources/api/user_actions.resource
Resource          ../resources/pages/login_page.resource
Resource          ../resources/common/setup_global.resource

# Preparamos la API y la Web antes de empezar
Suite Setup       Crear Sesion Global
Test Setup        Configurar Entorno Web
Test Teardown     Finalizar Prueba

*** Test Cases ***
Flujo Hibrido: Obtener Usuario De API Y Validar En Web
    [Documentation]    Este test simula un flujo donde los datos vienen del 
    ...                backend y se usan para una operacion en el frontend.
    [Tags]             @e2e    @full_regression

    # 1. PASO DE API: Extraemos el nombre de un usuario real del servidor
    ${usuario_api}=    Obtener Usuario Por ID    1
    # Guardamos el username: 'Bret' (es el username de Leanne Graham en JSONPlaceholder)
    ${username_ficticio}=    Set Variable    ${usuario_api['username']}

    # 2. PASO DE WEB: Usamos ese dato para intentar un login
    # Nota: Usaremos la password de siempre porque SauceDemo es cerrada
    Realizar Login    ${username_ficticio}    secret_sauce
    
    # 3. VALIDACIÓN: Como 'Bret' no existe en SauceDemo, validamos el mensaje de error
    # Esto demuestra que el robot sabe reaccionar a los datos que recibe
    Page Should Contain    Epic sadface: Username and password do not match