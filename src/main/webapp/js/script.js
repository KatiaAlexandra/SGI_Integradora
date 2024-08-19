document.querySelectorAll('.nav-item').forEach(item => {
    item.addEventListener('click', event => {
        // Remover la clase 'active' de todos los nav-items
        document.querySelectorAll('.nav-item').forEach(navItem => {
            navItem.classList.remove('active');
        });

        // Añadir la clase 'active' al nav-item clicado
        event.currentTarget.classList.add('active');

        // Redirigir a la URL del enlace dentro del nav-item
        const link = item.querySelector('a');
        if (link) {
            window.location.href = link.href;
        }
    });
});
