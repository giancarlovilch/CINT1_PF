document.addEventListener('DOMContentLoaded', () => {
    const contactoForm = document.getElementById('contactoForm');
    const mensajeExito = document.getElementById('mensaje-exito');

    contactoForm.addEventListener('submit', function(event) {
        event.preventDefault(); // Prevenir el envío del formulario por defecto

        // Limpiar cualquier mensaje previo
        mensajeExito.style.display = 'none';
        mensajeExito.textContent = '';
        

        const nombre = document.querySelector('input[name="nombre"]').value.trim();
        const telefono = document.querySelector('input[name="telefono"]').value.trim();
        const correo = document.querySelector('input[name="correo"]').value.trim();
        const mensaje = document.querySelector('textarea[name="mensaje"]').value.trim();

        if (!nombre || !telefono || !correo || !mensaje) {
            mensajeExito.style.display = 'block';
            mensajeExito.style.color = 'red';
            mensajeExito.textContent = 'Por favor, complete todos los campos antes de enviar.';
            return;
        }

        const formData = new FormData(contactoForm);

        fetch('./src/php/contacto.php', { // Ruta del archivo PHP que maneja el envío
            method: 'POST',
            body: formData
        })
        .then(response => response.text())
        .then(result => {
            console.log(result);  // Registrar la respuesta en la consola
            if (result.trim() === 'Mensaje recibido') {
                mensajeExito.style.display = 'block';
                mensajeExito.style.color = 'green';
                mensajeExito.textContent = '¡Mensaje enviado con éxito!';
                contactoForm.reset(); // Limpiar el formulario
            } else {
                mensajeExito.style.display = 'block';
                mensajeExito.style.color = 'red';
                mensajeExito.textContent = 'Hubo un error al enviar el mensaje. ' + result;
            }
        })
        .catch(error => {
            console.error('Error:', error);
            mensajeExito.style.display = 'block';
            mensajeExito.style.color = 'red';
            mensajeExito.textContent = 'Hubo un error al enviar el mensaje.';
        });
    });
});
