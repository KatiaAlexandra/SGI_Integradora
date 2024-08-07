<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgi.entities.History" %>
<%@ page import="mx.edu.utez.sgi.dao.HistoryDao" %>
<% String context = request.getContextPath();
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
            <li class="nav-item">
                <img src="<%= context %>/imagenes/ubicaciones.png">
                <a href="<%= context %>/UbicacionServlet">UBICACIONES</a>
            </li>
            <li class="nav-item" style="background-color:#05264C">
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
            <li class="nav-item">
                <img src="<%= context %>/imagenes/ubicaciones.png">
                <a href="<%= context %>/UbicacionServlet">UBICACIONES</a>
            </li>
            <li class="nav-item" style="background-color:#05264C">
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
<div id="content" class="container my-4">
    <div class="card">
        <p class="fs-4 fw-bold">Historial de Movimientos</p>
        <div class="table-responsive mt-3">
            <table id="articlesTable" class="table table-hover">
                <thead>
                <tr>
                    <th>Fecha</th>
                    <th>No. inventario</th>
                    <th>Artículo</th>
                    <th>Tipo de movimiento</th>
                </tr>
                </thead>
                <tbody>
                <%
                    HistoryDao HistorialDao = new HistoryDao();
                    List<History> historyList = HistorialDao.getAllHistory();
                        for (History history : historyList) {
                %>
                <tr>
                    <td><%= history.getDate_creation() %></td>
                    <td><%= history.getInventory_number() %></td>
                    <td><%= history.getArticle() %></td>
                    <td><%= history.getType_transaction() %></td>
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
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="<%=context%>/js/script.js"></script>
<script src="<%=context%>/js/main.js"></script>
</html>