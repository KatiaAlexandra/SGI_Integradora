<%@ page import="mx.edu.utez.sgi.dao.BuildingDao" %>
<%@ page import="mx.edu.utez.sgi.entities.Building" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgi.dao.ClassroomDao" %>
<%@ page import="mx.edu.utez.sgi.entities.Classroom" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String context = request.getContextPath();
    int iteracion = 1;
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<%=context%>/css/style.css">
    <style>
        .botonesAcciones {
            background-color: transparent;
            border: none;
            padding: 0;
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
            <li class="nav-item">
                <img src="<%= context %>/imagenes/hogar.png">
                <a href="<%= context %>/InicioServlet">INICIO</a>
            </li>
            <li class="nav-item">
                <img src="<%= context %>/imagenes/articulo.png">
                <a href="<%= context %>/ArticuloServlet">ARTÍCULOS</a>
            </li>
            <li class="nav-item">
                <img src="<%= context %>/imagenes/usuarios.png">
                <a href="<%= context %>/AsignadosServlet">ASIGNADOS</a>
            </li>
            <li class="nav-item" style="background-color:#05264C">
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
            <li class="nav-item">
                <img src="<%= context %>/imagenes/usuarios.png">
                <a href="<%= context %>/AsignadosServlet">ASIGNADOS</a>
            </li>
            <li class="nav-item" style="background-color:#05264C">
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
<div class="container my-4" style="max-width: 95%;">
    <div class="card" style="width: 100%;">
        <p class="fs-4 fw-bold">Gestión de Ubicaciones</p>
        <div class="header-container">
            <p class="fs-5 fw-bold">Lista de edificios y aulas</p>
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#añadir">Añadir ubicación</button>
        </div>
        <div class="table-responsive mt-3">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Edificio</th>
                    <th>Aula</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // Instancia del DAO para obtener la lista de edificios
                    ClassroomDao ClassroomDao = new ClassroomDao();
                    List<Classroom> classrooms = ClassroomDao.viewClassrooms();
                    // Recorrer la lista de edificios y crear una opción para cada uno
                    for (Classroom classroom : classrooms) {
                %>
                <tr>
                    <td><%=iteracion%></td>
                    <td><%=classroom.getBuilding().getBuilding_name()%></td>
                    <td><%=classroom.getClassroom_name()%></td>
                    <td>
                        <div class="boton-modal" style="display: flex; justify-content: center;">
                            <div class="acciones">
                                <button class="botonesAcciones" onclick="putClassroomInformation(<%=classroom.getClassroom_id()%>)" data-bs-toggle="modal" data-bs-target="#editar">
                                    <img src="imagenes/editar.png" alt="Editar">
                                </button>
                                <button class="botonesAcciones" onclick="putIdOnForm(<%=classroom.getClassroom_id()%>)" data-bs-toggle="modal" data-bs-target="#deleteModal">
                                    <img src="imagenes/basura.png" alt="Eliminar">
                                </button>
                            </div>
                        </div>
                    </td>
                </tr>
                <%
                        iteracion++;
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
        </div>
    </div>


    <div class="modal" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Eliminar ubicación</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="<%=context%>/DeleteClassroomServlet" method="post">
                    <input type="hidden" id="d_id" name="d_id">
                    <div class="modal-body">
                        <label>¿Estás seguro de eliminar la siguiente ubicación?</label>
                        <label id="d_building" style="font-weight: bold"></label>
                        <label id="d_classroom" style="font-weight: bold"></label>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-danger">Eliminar</button>
                        <button type="reset" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal añadir-->
<div class="modal fade" id="añadir" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="añadirUbicacion">Añadir ubicacion</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="<%=context%>/CreateClassroomServlet" method="post">
                    <label for="aula">Aula</label>
                    <input type="text" name="aula" id="aula" placeholder="Ingrese el nombre del aula" required>
                    <br><br>
                    <!-- Lista desplegable para seleccionar edificio -->
                    <label for="building">Edificio</label>
                    <select name="building" id="building" required>
                        <%
                            // Instancia del DAO para obtener la lista de edificios
                            BuildingDao buildingDao = new BuildingDao();
                            List<Building> buildings = buildingDao.getAllBuildings();
                            // Recorrer la lista de edificios y crear una opción para cada uno
                            for (Building building : buildings) {
                        %>
                        <option value="<%= building.getBuilding_ID() %>"><%= building.getBuilding_name() %></option>
                        <%
                            }
                        %>
                    </select>
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-success">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal update-->
<div class="modal fade" id="editar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="editarUbicacion">Editar ubicacion</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="<%=context%>/UpdateClassroomServlet" method="post">
                    <input type="hidden" id="u_id" name="id">
                    <label for="aula">Aula</label>
                    <input type="text" name="aula" id="u_aula" placeholder="Ingrese el nombre del aula" required>
                    <br><br>
                    <!-- Lista desplegable para seleccionar edificio -->
                    <label for="building">Edificio</label>
                    <select name="building" id="u_building" required>
                        <%
                            // Instancia del DAO para obtener la lista de edificios
                            buildingDao.getAllBuildings();
                            // Recorrer la lista de edificios y crear una opción para cada uno
                            for (Building building : buildings) {
                        %>
                        <option value="<%= building.getBuilding_ID() %>"><%= building.getBuilding_name() %></option>
                        <%
                            }
                        %>
                    </select>
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-success">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="<%=context%>/js/script.js"></script>
<script src="<%=context%>/js/main.js"></script>
</body>
</html>