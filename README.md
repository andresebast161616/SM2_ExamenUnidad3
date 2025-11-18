# Informe Examen Unidad 3

## 1. Datos del curso y estudiante
- **Nombre del curso:** Soluciones Moviles II
- **Fecha:** 18/11/2025
- **Estudiante:** Andree Sebastian Flores Melendez

## 2. URL del repositorio
- [SM2_ExamenUnidad3 en GitHub](https://github.com/andresebast161616/SM2_ExamenUnidad3)

## 3. Evidencias (capturas de pantalla)

### a) Estructura de carpetas `.github/workflows/`
![Estructura de carpetas](img/1.png)

### b) Contenido del archivo `quality-check.yml`
![Contenido quality-check.yml](img/2.png)

### c) Ejecución del workflow en la pestaña Actions
![Ejecución workflow Actions](img/3.png)

## 4. Explicación de lo realizado

## 4.1. **Creación del repositorio público:**
	- Se creó un repositorio en GitHub con el nombre exacto `SM2_ExamenUnidad3`, cumpliendo con la indicación de que fuera público para facilitar la revisión y ejecución de los workflows.
![Repositorio](img/4.png)

## 4.2. **Carga del proyecto móvil:**
	- Se copió todo el contenido del proyecto móvil desarrollado durante el curso, incluyendo archivos y carpetas, asegurando que la estructura original se mantuviera intacta.
![App Parque PeruFest](img/5.png)

## 4.3. **Configuración de carpetas y archivos para automatización:**
	- Se creó la carpeta `.github/workflows/` en la raíz del repositorio, que es la ubicación estándar para los workflows de GitHub Actions.
	- Dentro de esta carpeta se agregó el archivo `quality-check.yml`, el cual define el flujo de trabajo automatizado para análisis y pruebas del proyecto.
	- Se creó la carpeta `test/` y dentro de ella el archivo `main_test.dart`, donde se implementaron cinco pruebas unitarias que validan la funcionalidad principal del proyecto, como el login y la creación de usuarios.
![.github/workflows/](img/6.png)
![test/](img/7.png)


## 4.4. **Implementación del workflow de calidad:**
	- El archivo `quality-check.yml` está configurado para ejecutarse automáticamente cada vez que se realiza un commit o un pull request sobre la rama `main`. Este workflow realiza varias tareas:
	  - Instala las dependencias necesarias del proyecto.
	  - Ejecuta el análisis de código (`flutter analyze`) para verificar buenas prácticas, convenciones y detectar posibles errores o advertencias.
	  - Ejecuta las pruebas unitarias definidas en la carpeta `test/` para asegurar que las funciones críticas del proyecto siguen funcionando correctamente tras cada cambio.
![test/](img/8.png)

## 4.5. **Verificación de la ejecución automática:**
	- Se comprobó que el workflow se ejecuta correctamente en la pestaña Actions del repositorio en GitHub. En esta sección se pueden visualizar todas las ejecuciones recientes, revisar los pasos realizados, los resultados de las pruebas, advertencias y posibles errores.
![test/](img/9.png)
