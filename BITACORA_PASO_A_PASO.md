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