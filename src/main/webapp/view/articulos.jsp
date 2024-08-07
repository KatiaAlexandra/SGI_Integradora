<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sgi.dao.ArticleDao" %>
<%@ page import="mx.edu.utez.sgi.entities.Article" %>
<%@ page import="mx.edu.utez.sgi.dao.ManagerDao" %>
<%@ page import="mx.edu.utez.sgi.entities.Manager" %>
<%@ page import="mx.edu.utez.sgi.dao.BuildingDao" %>
<%@ page import="mx.edu.utez.sgi.entities.Building" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String context = request.getContextPath();
    if (request.getSession(false).getAttribute("user") == null) {
        response.sendRedirect(context + "/index.jsp");
    }
    String usuario = request.getSession().getAttribute("user").toString().toLowerCase();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de artículos</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="<%= context %>/css/style.css">
    <link rel="stylesheet" href="<%=context%>/css/DataTables.css">
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
            <li class="nav-item" style="background-color:#05264C">
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
            <li class="nav-item" style="background-color:#05264C">
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
        <div class="header-container">
            <p class="fs-4 fw-bold">Lista de artículos</p>
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#añadir">Añadir artículo</button>
        </div>

        <div class="align-buttons">
            <button type="button" class="btn btn-success" id="exportExcel">Exportar a Excel</button>
            <button type="button" class="btn btn-danger" id="exportPDF" style="margin-right: 3px">Exportar a PDF</button>
        </div>
        <div class="table-responsive mt-3">
            <table id="articlesTable" class="table table-hover">
                <thead>
                <tr>
                    <th><input type="checkbox" id="select-all"></th>
                    <th>No. Inventario</th>
                    <th>Nombre</th>
                    <th>Marca y modelo</th>
                    <th>Serie</th>
                    <th>Especificaciones</th>
                    <th>Edificio</th>
                    <th>Aula</th>
                    <th>Asignado</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <%
                    ArticleDao articleDao = new ArticleDao();
                    List<Article> articles = articleDao.findArticles();
                    for (Article article : articles) {
                %>
                <tr>
                    <td><input type="checkbox" name="seleccionar"></td>
                    <td><%= article.getInventory_number() %></td>
                    <td><%= article.getArticle_name() %></td>
                    <td><%= (article.getBrand_model() == null) ? "S/M" : article.getBrand_model() %></td>
                    <td><%= (article.getSerial_num() == null) ? "S/N" : article.getSerial_num() %></td>
                    <td><%= (article.getSpecifications() == null) ? "S/E" : article.getSpecifications() %></td>
                    <td><%= article.getClassroom().getBuilding().getBuilding_name() %></td>
                    <td><%= article.getClassroom().getClassroom_name() %></td>
                    <td><%= article.getManager().getFirst_Name() %></td>
                    <td class="acciones">
                        <div class="boton-modal" style="display: flex; justify-content: center;">
                            <div class="acciones">
                                <button class="botonesAcciones" onclick="putArticleInformation(<%=article.getArticle_id()%>)" data-bs-toggle="modal" data-bs-target="#actualizar">
                                    <img src="imagenes/editar.png" alt="Editar">
                                </button>
                                <button class="botonesAcciones" onclick="putArticleIdOnForm(<%=article.getArticle_id()%>)" data-bs-toggle="modal" data-bs-target="#exampleModal">
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

<!-- Modal eliminar-->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Eliminar artículo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%= context %>/DeleteArticleServlet" method="post">
                <input type="hidden" id="d_id" name="d_id">
                <div class="modal-body">
                    <label>¿Estás seguro de eliminar el siguiente artículo?</label>
                    <label id="d_inventory_number" style="font-weight: bold"></label>
                    <label id="d_article_name" style="font-weight: bold"></label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-danger">Eliminar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal añadir-->
<div class="modal fade" id="añadir" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-sm-down">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="añadirUbicacion">Añadir/Editar artículo</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="<%= context %>/CreateArticleServlet" method="post">
                    <input type="hidden" id="id" name="id">
                    <label for="no_inventario">No. de Inventario</label>
                    <input type="text" id="no_inventario" name="no_inventario" required>
                    <br><br>
                    <label for="nombre_articulo">Nombre del Artículo</label>
                    <input type="text" id="nombre_articulo" name="nombre_articulo" required>
                    <br><br>
                    <label for="marca_modelo">Marca y Modelo</label>
                    <input type="text" id="marca_modelo" name="marca_modelo">
                    <br><br>
                    <label for="serie">Serie</label>
                    <input type="text" id="serie" name="serie">
                    <br><br>
                    <label for="especificaciones">Especificaciones</label>
                    <input type="text" id="especificaciones" name="especificaciones">
                    <br><br>
                    <label for="encargado">Encargado</label>
                    <select id="encargado" name="encargado" required>
                        <%
                            ManagerDao managerDao = new ManagerDao();
                            List<Manager> managers = managerDao.findAllManagers();
                            for (Manager manager : managers) {
                        %>
                        <option value="<%= manager.getManager_ID() %>"><%= manager.getFirst_Name() %> <%= manager.getFirst_Lastname() %></option>
                        <%
                            }
                        %>
                    </select>
                    <br><br>
                    <label for="edificio">Edificio</label>
                    <select id="edificio">
                        <option value="">--Selecciona un edificio--</option>
                        <%
                            BuildingDao BuildingDao = new BuildingDao();
                            List<Building> buildings = BuildingDao.getAllBuildings();
                            for (Building build : buildings) {
                        %>
                        <option value="<%=build.getBuilding_ID()%>"><%=build.getBuilding_name()%></option>
                        <%
                            }
                        %>
                    </select>
                    <br><br>
                    <label for="aula">Aula</label>
                    <select id="aula" name="aula">
                        <option value="">--Selecciona una opción--</option>
                    </select>
                    <br><br>
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-success">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Actualizar-->
<div class="modal fade" id="actualizar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen-sm-down">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="actualizarUbicacion">Editar artículo</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="<%= context %>/UpdateArticleServlet" method="post">
                    <input type="hidden" id="u_id" name="id">
                    <label for="no_inventario">No. de Inventario</label>
                    <input type="text" id="u_inventory_number" name="no_inventario" required>
                    <br><br>
                    <label for="nombre_articulo">Nombre del Artículo</label>
                    <input type="text" id="u_article_name" name="u_article_name" required>
                    <br><br>
                    <label for="marca_modelo">Marca y Modelo</label>
                    <input type="text" id="u_brand_model" name="u_brand_model">
                    <br><br>
                    <label for="serie">Serie</label>
                    <input type="text" id="u_serial_num" name="u_serial_num">
                    <br><br>
                    <label for="especificaciones">Especificaciones</label>
                    <input type="text" id="u_specifications" name="u_specifications">
                    <br><br>
                    <label for="encargado">Encargado</label>
                    <select id="u_manager" name="u_manager" required>
                        <%
                            managerDao.findAllManagers();
                            for (Manager manager : managers) {
                        %>
                        <option value="<%=manager.getManager_ID() %>"><%= manager.getFirst_Name() %> <%= manager.getFirst_Lastname() %></option>
                        <%
                            }
                        %>
                    </select>
                    <br><br>
                    <label for="u_edificio">Edificio</label>
                    <select id="u_edificio">
                        <option value="">--Selecciona el edificio--</option>
                        <%
                            BuildingDao.getAllBuildings();
                            for (Building build : buildings) {
                        %>
                        <option value="<%=build.getBuilding_ID()%>"><%=build.getBuilding_name()%></option>
                        <%
                            }
                        %>
                    </select>
                    <br><br>
                    <label for="u_aula">Aula</label>
                    <select id="u_aula" name="u_aula">
                        <option value="">--Selecciona una opción--</option>
                    </select>
                    <br><br>
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-success">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!--Modal detalles-->
<div class="modal fade" id="detallesArticulo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detalles">Detalles de artículo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div>
                    <h3>Información del Artículo</h3>
                    <p><strong>No. de Inventario:</strong> 5101AM-02-008</p>
                    <p><strong>Nombre:</strong> Armario con estantes</p>
                    <p><strong>Marca y Modelo:</strong> SIM</p>
                    <p><strong>Serie:</strong> S/N</p>
                    <p><strong>Especificaciones:</strong> Estante metálico</p>
                    <p><strong>Edificio:</strong> Dirección</p>
                    <p><strong>Instalación:</strong> Salón 1</p>
                    <p><strong>Encargado:</strong> Martha Fabiola</p>
                </div>
                <div class="card">
                    <h3>Historial</h3>
                    <div class="table-responsive mt-3">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Tipo de Movimiento</th>
                                <th>Usuario</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>05/04/2024</td>
                                <td>Asignación</td>
                                <td>Admin</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script src="<%=context%>/js/main.js"></script>
<script src="<%=context%>/js/jQuery.js"></script>
<script src="<%=context%>/js/DataTables.js"></script>
<script src="<%=context%>/js/pdf.js"></script>
<script src="<%=context%>/js/excel.js"></script>
<script src="<%=context%>/js/jsPDF.js"></script>
<script src="<%=context%>/js/popper.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="<%=context%>/js/script.js"></script>


<script>
    $(document).ready(function() {
        $('#articlesTable').DataTable();
    });

    document.getElementById('exportExcel').addEventListener('click', function() {
        var selectedRows = [];
        document.querySelectorAll('input[name="seleccionar"]:checked').forEach(function(checkbox) {
            var row = checkbox.closest('tr');
            var cells = row.querySelectorAll('td');
            var rowData = [];
            cells.forEach(function(cell, index) {
                if (index > 0) {
                    rowData.push(cell.textContent.trim());
                }
            });
            selectedRows.push(rowData);
        });
        if (selectedRows.length === 0) {
            alert("No hay filas seleccionadas para exportar.");
            return;
        }

        var wb = XLSX.utils.book_new();
        var ws = XLSX.utils.aoa_to_sheet([
            ["No. Inventario", "Nombre", "Marca y modelo", "Serie", "Especificaciones", "Edificio", "Instalación", "Asignado"]
        ].concat(selectedRows));
        XLSX.utils.book_append_sheet(wb, ws, "Sheet1");
        XLSX.writeFile(wb, 'ListaDeArticulos.xlsx');
    });

    document.getElementById('exportPDF').addEventListener('click', function() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        var selectedRows = [];
        document.querySelectorAll('input[name="seleccionar"]:checked').forEach(function(checkbox) {
            var row = checkbox.closest('tr');
            var cells = row.querySelectorAll('td');
            var rowData = [];
            cells.forEach(function(cell, index) {
                if (index > 0) {
                    rowData.push(cell.textContent.trim());
                }
            });
            selectedRows.push(rowData);
        });
        if (selectedRows.length === 0) {
            alert("No hay filas seleccionadas para exportar.");
            return;
        }

        doc.autoTable({
            head: [['No. Inventario', 'Nombre', 'Marca y modelo', 'Serie', 'Especificaciones', 'Edificio', 'Instalación', 'Asignado']],
            body: selectedRows,
            theme: 'grid',
            styles: { fontSize: 8 }
        });

        doc.save('ListaDeArticulos.pdf');
    });

    document.getElementById('select-all').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('input[name="seleccionar"]');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });


</script>
</body>
</html>