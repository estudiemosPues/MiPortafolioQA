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

## 🚀 Comandos Rápidos
* **Activar entorno:** `.\.venv\Scripts\activate`
* **Correr tests API:** `python -m robot robotframework/api/`
* **Actualizar lista de compras:** `pip freeze > requirements.txt`