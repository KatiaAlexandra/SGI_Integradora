<%@ page import="mx.edu.utez.sgi.dao.UserDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String context = request.getContextPath();
    if(request.getSession(false).getAttribute("user")!=null){
        response.sendRedirect(context +"/view/inicio.jsp");
    }
    boolean errorMessage = request.getAttribute("errorMessage") !=null &&
            !(boolean) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="es" data-bs-theme="auto">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestor de Inventario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= context %>/css/sign-in.css">
    <link rel="stylesheet" href="<%= context %>/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="<%= context %>/js/color-modes.js"></script>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f7f7f7;
        }

        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .form-signin {
            max-width: 380px;
            padding: 15px;
            margin: auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-signin img {
            margin-bottom: 20px;
        }

        .form-floating {
            margin-bottom: 1rem;
        }

        .forgot-password {
            text-align: end;
        }

        .alert {
            margin-bottom: 1rem;
        }

        .btn-custom-green {
            background-color: #28a745;
            color: #fff;
        }

        .btn-custom-green:hover {
            background-color: #218838;
            color: #fff;
        }

        [data-bs-theme="dark"] body {
            background-color: #121212;
        }

        [data-bs-theme="dark"] .form-signin {
            background-color: #1e1e1e;
            color: #ccc;
        }

        [data-bs-theme="dark"] .form-signin input {
            background-color: #333;
            color: #fff;
            border: 1px solid #555;
        }

        [data-bs-theme="dark"] .form-signin label {
            color: #bbb;
        }

        [data-bs-theme="dark"] .btn-custom-green {
            background-color: #28a745;
            border-color: #28a745;
        }

        [data-bs-theme="dark"] .btn-custom-green:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }

        [data-bs-theme="light"] .form-signin {
            background-color: #f7f7f7;
        }
        .dropdown-item.active, .dropdown-item:active {
            background-color: #28a745;
            color: #fff;
        }
    </style>
</head>
<body class="d-flex align-items-center py-4">
<svg xmlns="http://www.w3.org/2000/svg" class="d-none">
    <symbol id="check2" viewBox="0 0 16 16">
        <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
    </symbol>
    <symbol id="circle-half" viewBox="0 0 16 16">
        <path d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>
    </symbol>
    <symbol id="moon-stars-fill" viewBox="0 0 16 16">
        <path d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z"/>
        <path d="M10.794 3.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387a1.734 1.734 0 0 0-1.097 1.097l-.387 1.162a.217.217 0 0 1-.412 0l-.387-1.162A1.734 1.734 0 0 0 9.31 6.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387a1.734 1.734 0 0 0 1.097-1.097l.387-1.162zM13.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732l-.774-.258a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L13.863.1z"/>
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

<main class="form-signin w-100 m-auto">
    <form action="<%= context %>/LoginServlet" method="post">
        <input type="hidden" id="contextPath" value="<%= context %>">
        <div style="text-align: center;">
            <img class="mb-4" id="logo" src="<%= context %>/imagenes/logo-blanco-01.png" alt="Logo" width="72" height="72">
            <h1 class="h3 mb-3 fw-normal">GESTIÓN DE INVENTARIO</h1>
        </div>
        <div class="form-floating">
            <input type="text" class="form-control" id="name" placeholder="Ingrese su nombre" name="username" required>
            <label for="name">Nombre</label>
        </div>
        <div class="form-floating">
            <input type="email" class="form-control" id="email" placeholder="Correo electrónico" name="email" required>
            <label for="email">Correo electrónico</label>
        </div>
        <div class="form-floating">
            <input type="password" class="form-control" id="password" placeholder="Contraseña" name="password" required>
            <label for="password">Contraseña</label>
        </div>
        <% if (errorMessage) { %>
        <div class="alert alert-danger text-center">El usuario ingresado no existe</div>
        <% } %>
        <button class="btn btn-custom-green w-100 py-2" type="submit">Inicia Sesión</button>
        <div class="d-flex justify-content-between mt-3">
            <p class="mt-5 mb-3 text-center">&copy; SGI 2024</p>
        </div>
    </form>
</main>

<script src="<%= context %>/js/color-modes.js"></script>
<script src="<%= context %>/js/theme-logo-index.js"></script>
</body>
</html>