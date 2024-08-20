<div id="contacto" class="contacto">
    <h2>Contacto</h2>
    <form id="contactoForm" class="formulario" action="#" method="POST">
        <legend>Contáctanos</legend>

        <div class="contenedor-campos">
            <div class="campo">
                <label>Nombre</label>
                <input type="text" name="nombre" placeholder="Nombre" required>
            </div>
            <div class="campo">
                <label>Teléfono</label>
                <input type="tel" name="telefono" placeholder="Teléfono">
            </div>
            <div class="campo w-100">
                <label>Correo</label>
                <input type="mail" name="correo" placeholder="Mail">
            </div>
            <div class="campo w-100">
                <label>Mensaje:</label>
                <textarea name="mensaje"></textarea>
            </div>
        </div>
        <div class="enviar">
            <input class="boton" type="submit" value="Enviar">
        </div>
    </form>
    <div id="mensaje-exito" style="display: none; color: green; margin-top: 10px;"></div>
</div>