<%@ page import="mx.edu.utez.sgi.dao.ManagerDao" %>
<%@ page import="mx.edu.utez.sgi.entities.Manager" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String context = request.getContextPath();
    if(request.getSession(false).getAttribute("user")==null){
        response.sendRedirect(context +"/index.jsp");
    }
    String usuario = request.getSession().getAttribute("user").toString().toLowerCase();
%>

<!DOCTYPE html>
<html lang="es" data-bs-theme="auto">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestor de Inventario - Lista de Asignados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="<%= context %>/vendor/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="<%= context %>/css/sb-admin-2.min.css">
    <link rel="stylesheet" href="<%= context %>/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="<%= context %>/js/color-modes.js"></script>
    <script src="<%= context %>/js/theme-toggle.js"></script>
</head>
<body id="page-top">
<svg xmlns="http://www.w3.org/2000/svg" class="d-none">
    <symbol id="check2" viewBox="0 0 16 16">
        <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
    </symbol>
    <symbol id="circle-half" viewBox="0 0 16 16">
        <path d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>
    </symbol>
    <symbol id="moon-stars-fill" viewBox="0 0 16 16">
        <path d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893"/>
        <path d="M10.794 3.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387a1.734 1.734 0 0 0-1.097 1.097l-.387 1.162a.217.217 0 0 1-.412 0l-.387-1.162A1.734 1.734 0 0 0 9.31 6.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387a1.734 1.734 0 0 0 1.097-1.097l.387-1.162zM13.863(.1a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732l-.774-.258a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L13.863.1z"/>
    </symbol>
    <symbol id="sun-fill" viewBox="0 0 16 16">
        <path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
    </symbol>
</svg>

<!-- Botón para cambiar de temas dark/light -->
<div class="dropdown theme-toggle-btn bd-mode-toggle">
    <button class="btn btn-custom-green py-2 dropdown-toggle d-flex align-items-center"
            id="bd-theme"
            type="button"
            aria-expanded="false"
            data-bs-toggle="dropdown"
            aria-label="Toggle theme">
        <svg class="bi my-1 theme-icon-active" width="1em" height="1em"><use href="#circle-half"></use></svg>
        <span class="visually-hidden" id="bd-theme-text"></span>
    </button>
    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="bd-theme-text">
        <li>
            <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="light" aria-pressed="false">
                <svg class="bi me-2 opacity-50 theme-icon" width="1em" height="1em"><use href="#sun-fill"></use></svg>
                Claro
                <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
            </button>
        </li>
        <li>
            <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="dark" aria-pressed="false">
                <svg class="bi me-2 opacity-50 theme-icon" width="1em" height="1em"><use href="#moon-stars-fill"></use></svg>
                Oscuro
                <svg class="bi ms-auto d-none" width="1em" height="1em"><use href="#check2"></use></svg>
            </button>
        </li>
    </ul>
</div>

<!-- Contenedor de la página -->
<div id="wrapper">
    <!-- Barra lateral -->
    <ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar">
        <!-- Barra lateral - Marca -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<%= context %>/InicioServlet">
            <div class="sidebar-brand-icon">
                <img id="sidebar-logo" src="<%= context %>/imagenes/logo-blanco-01.png" alt="Logo" style="width: 50px; height: 50px;">
            </div>
            <div class="sidebar-brand-text mx-3">SGI</div>
        </a>

        <!-- Elemento de navegación - Dashboard -->
        <li class="nav-item">
            <a class="nav-link" href="<%= context %>/InicioServlet">
                <i class="fas fa-fw fa-tachometer-alt"></i>
                <span>Inicio</span></a>
        </li>

        <!-- Elemento de navegación - Artículos -->
        <li class="nav-item">
            <a class="nav-link" href="<%= context %>/ArticuloServlet">
                <i class="fas fa-fw fa-box"></i>
                <span>Artículos</span></a>
        </li>

        <!-- Divisor -->
        <hr class="sidebar-divider my-0">

        <!-- Elemento de navegación - Asignados -->
        <li class="nav-item active">
            <a class="nav-link" href="<%= context %>/AsignadosServlet">
                <i class="fas fa-fw fa-user-check"></i>
                <span>Asignados</span></a>
        </li>

        <!-- Divisor -->
        <hr class="sidebar-divider">

        <!-- Elemento de navegación - Ubicaciones -->
        <li class="nav-item">
            <a class="nav-link" href="<%= context %>/UbicacionServlet">
                <i class="fas fa-fw fa-map-marker-alt"></i>
                <span>Ubicaciones</span></a>
        </li>

        <!-- Elemento de navegación - Movimientos -->
        <li class="nav-item">
            <a class="nav-link" href="<%= context %>/HistorialServlet">
                <i class="fas fa-fw fa-exchange-alt"></i>
                <span>Movimientos</span></a>
        </li>

        <!-- Elemento de navegación - Usuarios -->
        <% if (usuario.equals("20233tn166@utez.edu.mx") || usuario.equals("katia")) { %>
        <li id="ocultarUsuario" class="nav-item">
            <a class="nav-link" href="<%= context %>/UsuarioServlet">
                <i class="fas fa-fw fa-users"></i>
                <span>Usuarios</span></a>
        </li>
        <% } %>

        <!-- Elemento de navegación - Salir -->
        <li class="nav-item">
            <form action="<%= context %>/SalirServlet" method="post">
                <button class="btn btn-link nav-link">
                    <i class="fas fa-fw fa-sign-out-alt"></i>
                    <span>Salir</span>
                </button>
            </form>
        </li>

        <!-- Divisor -->
        <hr class="sidebar-divider d-none d-md-block">

        <!-- Botón de alternancia de la barra lateral -->
        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>
    </ul>
    <!-- Fin de la barra lateral -->

    <!-- Contenedor del contenido -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Contenido principal -->
        <div id="content">

            <!-- Barra superior -->
            <nav class="navbar navbar-expand topbar mb-4 static-top shadow">

                <!-- Botón de alternancia de la barra lateral (Barra superior) -->
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>

                <!-- Barra superior de navegación -->
                <ul class="navbar-nav ml-auto">
                    <!-- Elemento de navegación - Información del usuario -->
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%= usuario %></span>
                        </a>
                    </li>
                </ul>

            </nav>
            <!-- Fin de la barra superior -->

            <!-- Inicio del contenido de la página -->
            <div class="container-fluid content-wrapper">

                <!-- Encabezado de la página -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">Gestión de Asignados</h1>
                </div>

                <!-- Fila de contenido -->
                <div class="row">

                    <!-- Gestión de Asignados -->
                    <div class="col-xl-12 col-md-12 mb-4">
                        <div class="card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                                    <h1 class="h5 mb-0 text-gray-800">Lista de Asignados</h1>
                                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#añadir">Añadir asignado</button>
                                </div>
                                <div class="table-responsive mt-3">
                                    <table id="articlesTable" class="table table-hover">
                                        <thead>
                                        <tr>
                                            <th>No. del empleado</th>
                                            <th>Nombre</th>
                                            <th>Fecha de resguardo</th>
                                            <th>Estado</th>
                                            <th style="display: flex; justify-content: center; border-bottom: 1px;">Acciones</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%
                                            List<Manager> managers = new ManagerDao().findAllManagers();
                                            for (Manager manager : managers) {
                                        %>
                                        <tr>
                                            <td><%=manager.getEmployee_Num()%></td>
                                            <td><%=manager.getFirst_Name()%> <%=manager.getSecond_Name()%></td>
                                            <td><%=manager.getCustody_date()%></td>
                                            <%if(manager.getManager_Status()){%>
                                            <td>Activo</td>
                                            <%} else {%>
                                            <td>Inactivo</td>
                                            <%}%>
                                            <td>
                                                <div class="boton-modal" style="display: flex; justify-content: center;">
                                                    <div class="acciones">
                                                        <button class="btn btn-warning" onclick="putManagerInformation(<%=manager.getManager_ID()%>)" data-bs-toggle="modal" data-bs-target="#actualizar">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-info" onclick="putMangChangeIdOnForm(<%=manager.getManager_ID()%>)" data-bs-toggle="modal" data-bs-target="#changeStatusModal">
                                                            <i class="fas fa-sync-alt"></i>
                                                        </button>
                                                        <button class="btn btn-danger" onclick="putMangDeleteIdOnForm(<%=manager.getManager_ID()%>)" data-bs-toggle="modal" data-bs-target="#deleteModal">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- Fin de la fila de contenido -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- Fin del contenido principal -->

    </div>
    <!-- Fin del contenedor del contenido -->

</div>
<!-- Fin del contenedor de la página -->

<!-- Modal eliminar-->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Eliminar asignado</h5>
                <button type="button" class="btn-close-custom" data-bs-dismiss="modal" aria-label="Close">&times;</button>
            </div>
            <form action="<%=context%>/DeleteManager" method="post">
                <input type="hidden" id="d_id" name="d_id">
                <div class="modal-body">
                    <label>¿Estás seguro de eliminar al siguiente usuario?</label>
                    <label id="d_username" style="font-weight: bold"></label>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Eliminar</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal cambiar estatus-->
<div class="modal fade" id="changeStatusModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="ch_exampleModalLabel">Cambiar estatus del asignado</h5>
                <button type="button" class="btn-close-custom" data-bs-dismiss="modal" aria-label="Close">&times;</button>
            </div>
            <form action="<%=context%>/ChangeManagerStatusServlet" method="post">
                <input type="hidden" id="ch_id" name="ch_id">
                <div class="modal-body">
                    <label>¿Estás seguro de cambiar el estado al siguiente usuario?</label>
                    <label id="ch_username" style="font-weight: bold"></label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-info">Cambiar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal añadir-->
<div class="modal fade" id="añadir" tabindex="-1" aria-labelledby="añadirLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="añadirLabel">Añadir asignado</h5>
                <button type="button" class="btn-close-custom" data-bs-dismiss="modal" aria-label="Close">&times;</button>
            </div>
            <div class="modal-body">
                <form action="<%=context%>/CreateManagerServlet" method="post">
                    <input type="hidden" id="id" name="id">
                    <div class="mb-3">
                        <label for="nombre1A" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre1A" name="nombre1A" required>
                    </div>
                    <div class="mb-3">
                        <label for="nombre2A" class="form-label">Segundo nombre</label>
                        <input type="text" class="form-control" id="nombre2A" name="nombre2A">
                    </div>
                    <div class="mb-3">
                        <label for="apellido1A" class="form-label">Apellido paterno</label>
                        <input type="text" class="form-control" id="apellido1A" name="apellido1A" required>
                    </div>
                    <div class="mb-3">
                        <label for="apellido2A" class="form-label">Apellido materno</label>
                        <input type="text" class="form-control" id="apellido2A" name="apellido2A">
                    </div>
                    <div class="mb-3">
                        <label for="numEmpleado" class="form-label">Número del empleado</label>
                        <input type="text" class="form-control" id="numEmpleado" name="numEmpleado" required>
                    </div>
                    <div class="mb-3">
                        <label for="fechaResguardo" class="form-label">Fecha de resguardo</label>
                        <input type="text" class="form-control" id="fechaResguardo" name="fechaResguardo" required>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button type="submit" class="btn btn-success">Guardar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal actualizar-->
<div class="modal fade" id="actualizar" tabindex="-1" aria-labelledby="actualizarLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="actualizarLabel">Editar asignado</h5>
                <button type="button" class="btn-close-custom" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="<%=context%>/UpdateManager" method="post">
                    <input type="hidden" id="u_id" name="id">
                    <div class="mb-3">
                        <label for="u_nombre1A" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="u_nombre1A" name="nombre1A" required>
                    </div>
                    <div class="mb-3">
                        <label for="u_nombre2A" class="form-label">Segundo nombre</label>
                        <input type="text" class="form-control" id="u_nombre2A" name="nombre2A">
                    </div>
                    <div class="mb-3">
                        <label for="u_apellido1A" class="form-label">Apellido paterno</label>
                        <input type="text" class="form-control" id="u_apellido1A" name="apellido1A" required>
                    </div>
                    <div class="mb-3">
                        <label for="u_apellido2A" class="form-label">Apellido materno</label>
                        <input type="text" class="form-control" id="u_apellido2A" name="apellido2A">
                    </div>
                    <div class="mb-3">
                        <label for="u_numEmpleado" class="form-label">Número del empleado</label>
                        <input type="text" class="form-control" id="u_numEmpleado" name="numEmpleado" required>
                    </div>
                    <div class="mb-3">
                        <label for="u_fechaResguardo" class="form-label">Fecha de resguardo</label>
                        <input type="text" class="form-control" id="u_fechaResguardo" name="fechaResguardo" required>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button type="submit" class="btn btn-success">Guardar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="<%= context %>/vendor/jquery/jquery.min.js"></script>
<script src="<%= context %>/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<%= context %>/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="<%= context %>/js/sb-admin-2.min.js"></script>
<script src="<%= context %>/js/main.js"></script>
<script>
    $(document).ready(function() {
        $('#articlesTable').DataTable();
    });

    document.addEventListener('DOMContentLoaded', function () {
        const setLogo = () => {
            const theme = document.documentElement.getAttribute('data-bs-theme');
            const logo = document.getElementById('sidebar-logo');
            if (theme === 'light') {
                logo.src = '<%= context %>/imagenes/logo-color-01.png';
            } else {
                logo.src = '<%= context %>/imagenes/logo-blanco-01.png';
            }
        };

        setLogo();
        document.querySelectorAll('[data-bs-theme-value]').forEach(toggle => {
            toggle.addEventListener('click', () => {
                setTimeout(() => {
                    const themeValue = toggle.getAttribute('data-bs-theme-value');
                    document.documentElement.setAttribute('data-bs-theme', themeValue);
                    setLogo();
                }, 100);
            });
        });

        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
            setLogo();
        });
    });
</script>
</body>
</html>