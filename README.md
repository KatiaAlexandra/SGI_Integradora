# SGI Integradora

## Tabla de Contenidos
- [Descripción](https://github.com/KatiaAlexandra/SGI_Integradora/edit/main/README.md#descripción)
- [Problema Identificado](https://github.com/KatiaAlexandra/SGI_Integradora/edit/main/README.md#problema-identificado)
- [Solución](https://github.com/KatiaAlexandra/SGI_Integradora/edit/main/README.md#solución)
- [Arquitectura](https://github.com/KatiaAlexandra/SGI_Integradora/edit/main/README.md#arquitectura)
- [Requerimientos](https://github.com/KatiaAlexandra/SGI_Integradora/edit/main/README.md#requerimientos)
- [Instalación](https://github.com/KatiaAlexandra/SGI_Integradora/edit/main/README.md#instalación)
- [Configuración](https://github.com/KatiaAlexandra/SGI_Integradora/edit/main/README.md#configuración)
- [Uso](https://github.com/KatiaAlexandra/SGI_Integradora/edit/main/README.md#uso)
- [Contribución](https://github.com/KatiaAlexandra/SGI_Integradora/edit/main/README.md#contribución)
  
## Descripción
SGI Integradora es un sistema de gestión integral diseñado para gestionar las operaciones diarias de la División Académica de Tecnologías de la Información y Diseño (DATID) en la Universidad Tecnológica Emiliano Zapata (UTEZ). Este proyecto tiene como objetivo mejorar la eficiencia y la productividad mediante la automatización de procesos clave.

## Problema Identificado
Las organizaciones enfrentan dificultades para gestionar sus operaciones diarias de manera eficiente debido a la falta de integración entre diferentes sistemas y procesos manuales que consumen mucho tiempo. Tradicionalmente, DATID ha utilizado hojas de cálculo de Excel para llevar a cabo esta tarea, lo que presenta varias limitaciones que afectan la productividad y la precisión de las operaciones.

## Solución
SGI Integradora soluciona estos problemas proporcionando una plataforma integrada que automatiza procesos clave, mejora la comunicación y reduce los errores humanos. El sistema de gestión de inventarios automatiza los procesos de registro, seguimiento y actualización de inventarios, facilitando la toma de decisiones informadas sobre la adquisición, redistribución y disposición de activos.

## Arquitectura
La arquitectura del sistema SGI Integradora está compuesta por los siguientes componentes principales:
- **Frontend**: Desarrollado utilizando HTML, CSS y JavaScript.
- **Backend**: Implementado con Java y Servlets.
- **Base de Datos**: MySQL para almacenar la información.
- **Servidor de Aplicaciones**: Apache Tomcat para servir las aplicaciones web.
- **APIs**: APIs RESTful para la comunicación entre el frontend y el backend.

## Requerimientos
### Servidores de Aplicación y Web
- Apache Tomcat 9.0

### Bases de Datos
- MySQL 8.0

### Paquetes Adicionales
- JDBC Driver para MySQL
- Servlets API

### Versión de Java
- Java SE 11

## Instalación
### ¿Cómo instalar el ambiente de desarrollo?
1. Clonar el repositorio:

   git clone [URL del repositorio]

2. Navegar al directorio del proyecto:
   cd SGI_Integradora
   
3. Instalar dependencias:
   mvn install

## Instalación
1.Configurar la base de datos y asegurarse de que el servidor MySQL esté en funcionamiento.
2.Ejecutar el servidor de aplicaciones Tomcat.
3.Desplegar la aplicación en Tomcat.
4.Acceder a la aplicación a través de un navegador web.

## Configuración
### Configuración del Producto
- config.properties: Contiene configuraciones clave como la URL de la base de datos, usuario y contraseña.
### Configuración de los Requerimientos
- Asegurarse de que los servidores de aplicaciones y bases de datos estén configurados correctamente según la documentación.

## Uso
### Sección de Referencia para Usuario Final
El manual de usuario final proporciona instrucciones detalladas sobre cómo utilizar las funcionalidades de SGI Integradora. A continuación se detallan las principales operaciones que pueden realizar los usuarios finales:

#### Iniciar Sesión
1. Abre el navegador web y navega a la URL del sistema de gestión de inventarios.
2. Ingresa tu correo electrónico institucional y contraseña en los campos proporcionados.
3. Haz clic en el botón "Iniciar Sesión".

#### Registro de Artículos
1. Navega a la sección de "Control de Artículos" en el menú principal.
2. Haz clic en "Registrar Nuevo Artículo".
3. Completa los campos requeridos como Serial, Fecha de Compra, Número de Artículo, y Código de Barras.
4. Revisa y confirma los datos ingresados.
5. Haz clic en "Registrar" para guardar el artículo en el sistema.
6. Un mensaje de "Artículo registrado exitosamente" confirmará que el artículo ha sido registrado.

#### Consulta de Inventario
1. Ve a la sección de "Consulta de Inventario".
2. Utiliza los filtros disponibles para buscar artículos por Serial, Nombre del Artículo, Fecha de Compra o Ubicación.
3. Haz clic en "Buscar".
4. Los resultados de la búsqueda se mostrarán en una tabla.
5. Puedes exportar los resultados a Excel o PDF si es necesario.

#### Generación de Reportes
1. Accede a la sección de "Reportes" en el menú principal.
2. Selecciona los parámetros deseados para el reporte.
3. Haz clic en "Generar Reporte" y selecciona el formato deseado (Excel o PDF).
4. El reporte se generará y estará disponible para descarga.

### Sección de Referencia para Usuario Administrador
El manual de usuario administrador incluye información sobre cómo gestionar y configurar el sistema SGI Integradora. Aquí se detallan las principales operaciones que pueden realizar los administradores:

#### Gestión de Usuarios
1. Navega a la sección de "Usuarios" en el menú principal.
2. Haz clic en "Registrar Nuevo Usuario".
3. Ingresa la información requerida como Correo Electrónico, Nombre, Apellido y Contraseña.
4. Haz clic en "Registrar" para añadir el nuevo usuario al sistema.
5. Los administradores pueden editar o eliminar usuarios existentes desde la misma sección.

#### Configuración del Sistema
1. Accede a la sección de "Configuración" en el menú principal.
2. Edita los valores en el archivo `config.properties` para ajustar la URL de la base de datos, el usuario y la contraseña.
3. Guarda los cambios y reinicia el servidor de aplicaciones para aplicar la nueva configuración.

#### Monitoreo del Sistema
1. Ve a la sección de "Monitoreo" en el menú principal.
2. Revisa los logs y registros del sistema para identificar posibles problemas o inconsistencias.
3. Los administradores pueden exportar los logs para análisis adicional.

Este manual proporciona una guía completa para que tanto los usuarios finales como los administradores puedan utilizar y gestionar el sistema SGI Integradora de manera efectiva.

## Contribución
### Guía de Contribución para Usuarios
1. Clonar el repositorio:
   git clone [URL del repositorio]
2.Crear un nuevo branch:
   git checkout -b [nombre-del-branch]
4. Realizar cambios y commitear:
   git add .
   git commit -m "[Descripción de los cambios]"
5. Esperar a que se haga el merge:
   Seguir las instrucciones y pautas del proyecto para el proceso de revisión de código.
