*** Settings ***
# Importamos la librería que nos permite controlar navegadores web
Library    SeleniumLibrary

*** Variables ***
# Definimos la página que vamos a probar
${URL}           https://www.saucedemo.com/
# Elegimos el navegador (Chrome es el estándar en la industria)
${NAVEGADOR}     chrome
# Datos de acceso para la prueba
${USUARIO}       standard_user
${PASSWORD}      secret_sauce

*** Test Cases ***
Login Exitoso En SauceDemo
    [Documentation]    Esta prueba abre el navegador, ingresa credenciales y valida el ingreso.
    
    # Paso 1: Abrimos el navegador en la dirección indicada
    Open Browser    ${URL}    ${NAVEGADOR}
    
    # Paso 2: Maximizamos la ventana para asegurar que todos los elementos sean visibles
    Maximize Browser Window
    
    # Paso 3: Buscamos el campo de usuario por su ID y escribimos el nombre
    Input Text        id=user-name    ${USUARIO}
    
    # Paso 4: Buscamos el campo de contraseña y escribimos el password
    Input Password    id=password     ${PASSWORD}
    
    # Paso 5: Hacemos clic en el botón de login
    Click Button      id=login-button
    
    # Paso 6: Verificamos que el título de la página interna sea 'Products'
    # Esto confirma que el login realmente funcionó
    Element Text Should Be    class=title    Products
    
    # Paso 7: Cerramos el navegador para limpiar la memoria de la computadora
    [Teardown]    Close Browser