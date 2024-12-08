<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="com.mycompany.soloboticas.jdbc.JdbcConnection" %>
<%@ page import="com.itextpdf.text.*" %>
<%@ page import="com.itextpdf.text.pdf.*" %>

<%
String orderId = request.getParameter("orderId");

Connection conn = null;
PreparedStatement psInvoice = null;
ResultSet rsOrder = null;

try {
    conn = JdbcConnection.getConncetion();

    // Obtener detalles de la orden
    String queryOrder = "SELECT * FROM Orders WHERE oid = ?";
    psInvoice = conn.prepareStatement(queryOrder);
    psInvoice.setString(1, orderId);
    rsOrder = psInvoice.executeQuery();

    if (rsOrder.next()) {
        // Crear PDF de factura/boleta
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=factura_" + orderId + ".pdf");
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Encabezado
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
        document.add(new Paragraph("Factura/Boleta", titleFont));
        document.add(new Paragraph("Orden ID: " + rsOrder.getInt("oid")));
        document.add(new Paragraph(" ")); // Espaciado

        // Información del cliente y detalles de la orden
        Font headerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        PdfPTable table = new PdfPTable(2); // Tabla con 2 columnas
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(10f);

        // Agregar encabezados a la tabla
        table.addCell(new PdfPCell(new Phrase("Campo", headerFont)));
        table.addCell(new PdfPCell(new Phrase("Valor", headerFont)));

        // Agregar detalles de la orden
        table.addCell("ID Producto");
        table.addCell(rsOrder.getString("pid"));
        table.addCell("Precio");
        table.addCell(String.valueOf(rsOrder.getInt("price")));
        table.addCell("Cantidad");
        table.addCell(String.valueOf(rsOrder.getInt("quantity")));
        table.addCell("ID Cliente");
        table.addCell(rsOrder.getString("uid"));
        table.addCell("Fecha y Hora Orden");
        table.addCell(rsOrder.getTimestamp("orderdatetime").toString());
        table.addCell("Total");
        table.addCell(String.valueOf(rsOrder.getInt("price") * rsOrder.getInt("quantity")));

        // Agregar la tabla al documento
        document.add(table);

        // Pie de página
        document.add(new Paragraph("Gracias por su compra.", headerFont));
        document.add(new Paragraph("SOLO BOTICAS, SJL, LIMA, PERU, 935812267.", new Font(Font.FontFamily.HELVETICA, 10, Font.ITALIC)));

        document.close();
    } else {
        out.println("Orden no encontrada.");
    }   
} catch (Exception e) {
    out.println("Error: " + e);
} finally {
    if (rsOrder != null) try { rsOrder.close(); } catch (Exception e) { e.printStackTrace(); }
    if (psInvoice != null) try { psInvoice.close(); } catch (Exception e) { e.printStackTrace(); }
    if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
}
%>
