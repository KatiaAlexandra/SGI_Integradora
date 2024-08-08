document.addEventListener('DOMContentLoaded', function() {
    const setLogo = () => {
        const theme = document.documentElement.getAttribute('data-bs-theme');
        const logo = document.getElementById('logo');
        const contextPath = document.getElementById('contextPath').value;

        logo.style.width = '72px';
        logo.style.height = '72px';

        if (theme === 'light') {
            logo.src = contextPath + '/imagenes/logo-color-01.png';
        } else {
            logo.src = contextPath + '/imagenes/logo-blanco-01.png';
        }
    };

    setLogo();
    document.querySelectorAll('[data-bs-theme-value]').forEach(toggle => {
        toggle.addEventListener('click', () => {
            setTimeout(setLogo, 100); // Timeout para asegurar que el tema se aplique antes de cambiar el logo
        });
    });

    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
        setLogo();
    });
});