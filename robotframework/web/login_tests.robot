*** Settings ***
# 1. Importamos la receta y la configuración
Resource    ../resources/common/setup_global.resource
Resource    ../resources/pages/login_page.resource

# 2. Usamos las keywords de 'common' para preparar y limpiar
Test Setup       Configurar Entorno Web
Test Teardown    Finalizar Prueba

*** Test Cases ***
Login Exitoso
    # 3. Llamamos a la keyword de 'pages' y le pasamos los "Arguments"
    Realizar Login    standard_user    secret_sauce