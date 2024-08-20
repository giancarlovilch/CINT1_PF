document.addEventListener('DOMContentLoaded', function () {
    var modal = document.getElementById("mensajeModal");
    var span = document.getElementsByClassName("close")[0];
    var modalMensaje = document.getElementById("modalMensaje");

    document.querySelectorAll('.ver-mensaje').forEach(function (element) {
        element.addEventListener('click', function (event) {
            event.preventDefault();
            var mensaje = this.getAttribute('data-mensaje');
            modalMensaje.textContent = mensaje;
            modal.style.display = "block";
        });
    });

    span.onclick = function () {
        modal.style.display = "none";
    }

    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});
