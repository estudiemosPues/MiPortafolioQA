*** Settings ***
# Traemos la librería que nos permite hablar con páginas web (APIs)
Library    RequestsLibrary

*** Variables ***
# Guardamos la dirección de la API en una variable para no escribirla muchas veces
${URL_BASE}    https://jsonplaceholder.typicode.com

*** Test Cases ***
Validar Mi Primera API
    [Documentation]    Prueba simple para confirmar que la API responde.
    
    # Creamos la conexión con el servidor (como abrir el teléfono para llamar)
    Create Session    mi_conexion    ${URL_BASE}
    
    # Hacemos la llamada (GET) para pedir los datos del usuario 1
    ${respuesta}=    GET On Session    mi_conexion    /users/1
    
    # Revisamos que la respuesta sea 200 (el código universal de 'Todo OK')
    Status Should Be    200    ${respuesta}
    
    # Extraemos el nombre del usuario para leerlo nosotros
    ${nombre}=    Set Variable    ${respuesta.json()['name']}
    
    # Imprimimos el nombre en la consola de VS Code para celebrar el éxito
    Log To Console    \nEl usuario encontrado fue: ${nombre}