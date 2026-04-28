# 📓 Bitácora de Aprendizaje QA

Este documento es mi memoria técnica. Aquí anoto los "trucos" y soluciones a problemas que han surgido en este proyecto.

## 📦 Gestión de Librerías (requirements.txt)

En el archivo `requirements.txt` controlo qué herramientas usa mi proyecto:

* **Versión Fija (`nombre==1.0`):** Útil para que nada se rompa por cambios inesperados.
* **Última Versión (`nombre`):** Le indica a Python que descargue lo más reciente que exista.
* **Versión Mínima (`nombre>=1.0`):** Asegura que tengo las funciones nuevas pero permite actualizarse.

> **Nota:** Si cambio algo en este archivo, debo ejecutar `pip install -r requirements.txt` para que mi entorno local se actualice.

## 🆘 Solución de Errores (Troubleshooting)

### 1. El comando 'robot' no se reconoce
Ocurre si no has activado el ambiente virtual. 
* **Solución:** Verifica que en la terminal veas `(.venv)`. Si no, ejecuta: `.\.venv\Scripts\activate`

### 2. Error de permisos en PowerShell
Si Windows bloquea la activación del entorno.
* **Solución (Admin):** `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

### 3. Error: SessionNotCreatedException (Chrome instance exited)
* **Causa:** Intentar ejecutar pruebas web con interfaz gráfica en un entorno de CI (GitHub Actions) que no tiene monitor.
* **Solución:** Pasar el parámetro `--variable NAVEGADOR:headlesschrome` en el comando de ejecución del Workflow para que el navegador corra en segundo plano.

## 🚀 Comandos Rápidos
* **Activar entorno:** `.\.venv\Scripts\activate`
* **Correr tests API:** `python -m robot robotframework/api/`
* **Actualizar lista de compras:** `pip freeze > requirements.txt`

## 📁 Gestión de Directorios y Rutas

Para mantener el proyecto organizado y los comandos simples, se aplican las siguientes reglas de eficiencia:

### 1. Ejecución por Carpetas (Recursividad)
En lugar de llamar a cada archivo `.robot` de forma individual, es mejor ejecutar una carpeta completa. Robot Framework buscará automáticamente todos los archivos de prueba dentro de ella.
* **Todo el proyecto:** `python -m robot robotframework/`
* **Solo una categoría:** `python -m robot robotframework/api/`

### 2. Organización de Reportes (`-d`)
Para evitar que los archivos de resultados (`log.html`, `report.html`, `output.xml`) llenen la raíz del proyecto, se utiliza el parámetro `-d` (directory).
* **Comando profesional:** `python -m robot -d resultados robotframework/`
* **Beneficio:** Agrupa toda la "basura" y evidencias en una sola carpeta llamada `/resultados`.

### 3. Simplificación en GitHub Actions (`working-directory`)
Si un paso del asistente virtual tiene muchas tareas dentro de una carpeta específica, se puede definir un directorio de trabajo para no tener que escribir rutas largas en cada comando `run`.

```yaml
- name: Ejecutar Suite de UI
  working-directory: robotframework/web
  run: python -m robot test_web.robot
  ```

## 📦 Artefactos (Evidencias del Pipeline)

Los reportes generados en GitHub Actions son volátiles (se borran al terminar la sesión). Para conservarlos, usamos `actions/upload-artifact`.

* **Concepto:** Un "Artifact" es cualquier archivo generado durante el workflow que queremos descargar después.
* **Configuración Clave:** Usar `if: always()` para asegurar que, si la prueba falla, aún tengamos el `log.html` para analizar el error.


## 🛠️ Mantenimiento y Logs del Sistema

### ⚠️ Advertencia: Node.js Deprecation (Actions)
* **Observación:** Aparece un warning indicando que `actions/setup-python@v5` y `actions/upload-artifact@v4` usan Node.js 20 (depreciado).
* **Estado:** El pipeline se ejecuta con éxito (Success) porque GitHub fuerza la ejecución en Node.js 24.
* **Acción:** No requiere cambio inmediato por parte del usuario, ya que se están usando las versiones mayores más recientes. Se debe monitorear futuras versiones (@v6 o @v5 respectivamente) para limpiar el log.


## 🏗️ Reestructuración de Resources (Modularidad)
* **Objetivo:** Implementar una arquitectura desacoplada donde la lógica de negocio esté separada de la ejecución.
* **Carpetas creadas:** `api/`, `pages/`, `common/`, `data/`.
* **Beneficio:** Reutilización de código entre pruebas unitarias de UI/API y flujos complejos E2E.

## 🔧 Configuración de Variables Globales y Locales
* **Concepto:** Sobrescritura de variables (Overriding).
* **Uso:** Definimos `${NAVEGADOR} chrome` en el código como respaldo (fallback). 
* **CI/CD:** En el pipeline (YAML), pasamos `--variable NAVEGADOR:headlesschrome` para forzar el modo sin interfaz.
* **Lección:** Las variables pasadas por línea de comandos siempre tienen prioridad sobre las del código.

## 🔄 Ciclo de Vida: Setup y Teardown
* **Test Setup:** Configuración previa necesaria para que el test pueda existir (pre-condición).
* **Test Teardown:** Limpieza obligatoria después del test (post-condición). 
* **Regla de Oro:** El Teardown corre siempre, incluso si el test falla. Esto garantiza que el ambiente de pruebas quede limpio para el siguiente test.
* **Ubicación en Settings:** Permite que todos los tests del archivo compartan la misma rutina de inicio y fin, evitando repetir código (Principio DRY: Don't Repeat Yourself).

## 🧩 Independencia de Recursos (Scope)
* **Regla:** Cada archivo `.resource` debe declarar las librerías que utiliza internamente.
* **Razón:** Los recursos no "heredan" librerías de otros recursos ni del archivo `.robot` que los llama.
* **Beneficio:** Permite que los archivos sean reutilizables y que las herramientas de desarrollo (IntelliSense/Autocompletado) funcionen correctamente.
* **Mito:** Importar la misma librería en varios archivos NO afecta el rendimiento; Robot Framework gestiona la carga de forma eficiente.

## 🌐 Modularización de API (Backend)
* **Keyword Encapsulation:** Se movieron las peticiones GET/POST a archivos `.resource`.
* **Suite Setup:** Uso de `Suite Setup` para abrir la sesión de API una sola vez para todos los tests del archivo, optimizando el tiempo de ejecución.
* **Separación de Lógica:** El test solo se encarga de la validación (Assert), mientras que el recurso se encarga de la comunicación (HTTP).

## 🔄 Cambio de Proveedor de API (De ReqRes a JSONPlaceholder)
* **Motivo:** ReqRes comenzó a solicitar `x-api-key` obligatoria para consultas básicas, requiriendo registro previo.
* **Solución:** Migración a **JSONPlaceholder** para mantener el enfoque en la automatización pura sin gestión de credenciales externas.
* **Lección:** En QA, la flexibilidad para cambiar de entorno o herramientas cuando el costo de mantenimiento (o acceso) sube es vital.

## 🏆 Flujos E2E Híbridos (API + UI)
* **Definición:** Pruebas que integran la validación de servicios (API) con la experiencia de usuario (UI) en un solo caso de prueba.
* **Técnica de Inyección:** Los datos obtenidos de una respuesta JSON (Backend) se utilizan como variables de entrada para los Page Objects (Frontend).
* **Valor Senior:** Reducción de datos "hardcoded" (fijos) y validación de la integridad del flujo de información de extremo a extremo.

## ⚡ Evolución a Browser Library (Playwright)
* **Diferencia clave:** Eliminación de esperas manuales (Auto-wait) y mayor velocidad de ejecución en comparación con Selenium.
* **Seguridad:** Implementación de `Fill Secret` para manejo de datos sensibles en reportes.
* **Configuración:** Requiere el comando `rfbrowser init` para preparar los binarios de los navegadores en el entorno local y de CI.

## 🔐 Manejo de Secretos en Browser Library
* **Error:** `Direct assignment of values... is not allowed`.
* **Causa:** Uso de `${variable}` en keywords de tipo "Secret", lo que expone el dato en los logs (Variable Spoiling).
* **Solución:** Usar la sintaxis de referencia `$nombre_variable` (sin llaves).
* **Valor Senior:** Garantizar que credenciales y tokens nunca sean legibles en los reportes de ejecución, cumpliendo con estándares de seguridad de datos.

## ⚖️ Estrategia de Selección de Herramientas (Selenium vs Browser)
* **SeleniumLibrary:** Ideal para estabilidad en infraestructura clásica y compatibilidad total con drivers legacy.
* **Browser Library:** Preferida para desarrollo ágil, aplicaciones de una sola página (SPA) y ejecución de alta velocidad en CI/CD.
* **Decisión Técnica:** La elección depende del "Tech Stack" de la aplicación y la necesidad de herramientas avanzadas de depuración (Network tracking, Video, Tracing).

## ☁️ Testing en la Nube (Cloud Grids)
* **BrowserStack/SauceLabs:** Plataformas que eliminan la necesidad de un laboratorio físico de dispositivos.
* **Relación con Selenium:** Es el estándar nativo de la industria para grids. Utiliza el protocolo W3C para enviar comandos a dispositivos remotos.
* **Relación con Browser Library:** Requiere una conexión de tipo WebSocket (Playwright Connect). Es más rápido pero requiere una configuración de red más moderna.
* **Decisión Senior:** Usar Cloud Grids cuando el requerimiento de negocio exige certificar la aplicación en múltiples combinaciones de SO/Browser/Dispositivo real que no se pueden emular localmente.

## ❌ Error: Missing X server (Browser Library)
* **Causa:** Intento de ejecutar Browser Library con `headless=False` en un entorno de servidor (GitHub Actions) sin interfaz gráfica.
* **Solución:** Configurar `headless=True` en la keyword `New Browser`.
* **Lección:** Playwright es más estricto que Selenium con los logs de error y proporciona un "Call log" detallado que facilita el diagnóstico del fallo del sistema.