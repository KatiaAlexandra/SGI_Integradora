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
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestor de Inventario</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="<%=context%>/css/style.css">
    <style>
        .bg-custom {
            background-color: #029575 !important;
        }
        .radio-group {
            display: flex;
            align-items: center;
        }
    </style>
</head>

<body style="background-color: #B7BFC2;">

<header class="bg-custom text-white text-center py-2">
    <div class="container">
        <img src="imagenes/logo-blanco-01.png" style="width: 60px; height: 50px;">
        <h1>GESTIÓN DE INVENTARIO</h1>
    </div>
</header>

<% if (usuario.equals("20233tn166@utez.edu.mx") || usuario.equals("katia")){ %>
<nav class="navbar navbar-expand-lg navbar-light bg-custom1">
    <button class="navbar-toggler bg-custom" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mx-auto">
            <li class="nav-item" style="background-color:#05264C">
                <img src="<%= context %>/imagenes/hogar.png">
                <a href="<%= context %>/InicioServlet">INICIO</a>
            </li>
            <li class="nav-item">
                <img src="<%= context %>/imagenes/articulo.png">
                <a href="<%= context %>/ArticuloServlet">ARTÍCULOS</a>
            </li>
            <li class="nav-item" style="background-color:#05264C">
                <img src="<%= context %>/imagenes/usuarios.png">
                <a href="<%= context %>/AsignadosServlet">ASIGNADOS</a>
            </li>
            <li class="nav-item">
                <img src="<%= context %>/imagenes/ubicaciones.png">
                <a href="<%= context %>/UbicacionServlet">UBICACIONES</a>
            </li>
            <li class="nav-item">
                <img src="<%= context %>/imagenes/movimientos.png">
                <a href="<%= context %>/HistorialServlet">MOVIMIENTOS</a>
            </li>
            <li id="ocultarUsuario" class="nav-item">
                <img src="<%= context %>/imagenes/usuario.png">
                <a href="<%= context %>/UsuarioServlet">USUARIOS</a>
            </li>
            <li class="nav-item">
                <form action="<%= context %>/SalirServlet" method="post">
                    <button style="background: none; border: none">
                        <img src="<%= context %>/imagenes/salir.png">
                        <a style="color: #FFFFFF">SALIR</a>
                    </button>
                </form>
            </li>
        </ul>
    </div>
</nav>
<% } else { %>
<nav class="navbar navbar-expand-lg navbar-light bg-custom1">
    <button class="navbar-toggler bg-custom" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav1" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav1">
        <ul class="navbar-nav mx-auto">
            <li class="nav-item">
                <img src="<%= context %>/imagenes/hogar.png">
                <a href="<%= context %>/InicioServlet">INICIO</a>
            </li>
            <li class="nav-item">
                <img src="<%= context %>/imagenes/articulo.png">
                <a href="<%= context %>/ArticuloServlet">ARTÍCULOS</a>
            </li>
            <li class="nav-item" style="background-color:#05264C">
                <img src="<%= context %>/imagenes/usuarios.png">
                <a href="<%= context %>/AsignadosServlet">ASIGNADOS</a>
            </li>
            <li class="nav-item">
                <img src="<%= context %>/imagenes/ubicaciones.png">
                <a href="<%= context %>/UbicacionServlet">UBICACIONES</a>
            </li>
            <li class="nav-item">
                <img src="<%= context %>/imagenes/movimientos.png">
                <a href="<%= context %>/HistorialServlet">MOVIMIENTOS</a>
            </li>
            <li class="nav-item">
                <form action="<%= context %>/SalirServlet" method="post">
                    <button style="background: none; border: none">
                        <img src="<%= context %>/imagenes/salir.png">
                        <a style="color: #FFFFFF">SALIR</a>
                    </button>
                </form>
            </li>
        </ul>
    </div>
</nav>
<%}%>
<div id="content" class="container my-4" style="max-width: 95%;">
    <div class="card" style="width: 100%;">
        <p class="fs-4 fw-bold">Gestión de Asignados</p>
        <div class="header-container">
            <p class="fs-5 fw-bold">Lista de Asignados</p>
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
                    <th>Acciones</th>
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
                    <td><%=manager.getManager_Status()%></td>
                    <td>
                        <div class="boton-modal" style="display: flex; justify-content: center;">
                            <div class="acciones">
                                <button class="botonesAcciones" onclick="putManagerInformation(<%=manager.getManager_ID()%>)" data-bs-toggle="modal" data-bs-target="#actualizar">
                                    <img src="imagenes/editar.png" alt="Editar">
                                </button>
                                <button class="botonesAcciones" onclick="putManagerIdOnForm(<%=manager.getManager_ID()%>)" data-bs-toggle="modal" data-bs-target="#deleteModal">
                                    <img src="imagenes/basura.png" alt="Eliminar">
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

<!-- ELIMINAR -->
<div class="modal" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Eliminar asignado</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%=context%>/DeleteManager" method="post">
                <div class="modal-body">
                    <input type="hidden" id="d_id" name="d_id">
                    <label>¿Estás seguro de eliminar al siguiente usuario?</label>
                    <label id="d_username" style="font-weight: bold"></label>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Eliminar</button>
                    <button type="reset" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div> -->

<!-- AÑADIR -->
<div class="modal fade" id="añadir" tabindex="-1" aria-labelledby="añadir" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="añadirUbicacion">Añadir/Editar asignado</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="<%=context%>/CreateManagerServlet" method ="post">
                    <label for="nombre1A">Nombre</label>
                    <input type="text" name="nombre1A" id="nombre1A" placeholder="Ingrese el primer nombre del asignado" required>
                    <br><br>
                    <label for="nombre2A">Segundo nombre</label>
                    <input type="text" name="nombre2A" id="nombre2A" placeholder="Ingrese el segundo nombre del asignado (opcional)">
                    <br><br>
                    <label for="apellido1A">Apellido paterno</label>
                    <input type="text" name="apellido1A" id="apellido1A" placeholder="Ingrese el apellido paterno del asignado" required>
                    <br><br>
                    <label for="apellido2A">Apellido materno</label>
                    <input type="text" name="apellido2A" id="apellido2A" placeholder="Ingrese el apellido materno del asignado (opcional)">
                    <br><br>
                    <label for="numEmpleado">Número del empleado</label>
                    <input type="text" name="numEmpleado" id="numEmpleado" placeholder="Ingrese el numero del empleado" required>
                    <br><br>
                    <label for="fechaResguardo">Fecha de resguardo</label>
                    <input type="text" name="fechaResguardo" id="fechaResguardo" placeholder="Ingrese la fecha del resguardo" required>
                    <br><br>
                    <label>Estado</label>
                    <div class="radio-group">
                        <label for="activo">Activo</label>
                        <input type="radio" id="activo" name="activo" value="true" checked>
                        <br><br>
                        <label for="inactivo">Inactivo</label>
                        <input type="radio" id="inactivo" name="activo" value="false">
                    </div>
                    <br><br>
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-success">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ACTUALIZAR -->
<div class="modal fade" id="actualizar" tabindex="-1" aria-labelledby="añadir" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="u_añadirUbicacion">Editar asignado</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="<%=context%>/UpdateManager" method ="post">
                    <input type = "hidden" id ="u_id" name="id">
                    <label for="nombre1A">Nombre</label>
                    <input type="text" name="nombre1A" id="u_nombre1A" placeholder="Ingrese el primer nombre del asignado" required>
                    <br><br>
                    <label for="nombre2A">Segundo nombre</label>
                    <input type="text" name="nombre2A" id="u_nombre2A" placeholder="Ingrese el segundo nombre del asignado (opcional)">
                    <br><br>
                    <label for="apellido1A">Apellido paterno</label>
                    <input type="text" name="apellido1A" id="u_apellido1A" placeholder="Ingrese el apellido paterno del asignado" required>
                    <br><br>
                    <label for="apellido2A">Apellido materno</label>
                    <input type="text" name="apellido2A" id="u_apellido2A" placeholder="Ingrese el apellido materno del asignado (opcional)">
                    <br><br>
                    <label for="numEmpleado">Número del empleado</label>
                    <input type="text" name="numEmpleado" id="u_numEmpleado" placeholder="Ingrese el numero del empleado" required>
                    <br><br>
                    <label for="fechaResguardo">Fecha de resguardo</label>
                    <input type="text" name="fechaResguardo" id="u_fechaResguardo" placeholder="Ingrese la fecha del resguardo" required>
                    <br><br>
                    <label>Estado</label>
                    <div class="radio-group">
                        <label for="activo">Activo</label>
                        <input type="radio" id="u_activo" name="status" value="Activo">
                        <br><br>
                        <label for="inactivo">Inactivo</label>
                        <input type="radio" id="u_inactivo" name="status" value="Inactivo">
                    </div>
                    <br><br>
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-success">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
<script src="<%=context%>/js/script.js"></script>
<script src="<%=context%>/js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</html>