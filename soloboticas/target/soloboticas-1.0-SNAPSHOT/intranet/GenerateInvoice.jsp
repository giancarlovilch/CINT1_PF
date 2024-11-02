<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

        document.add(new Paragraph("Factura/Boleta"));
        document.add(new Paragraph("Orden ID: " + rsOrder.getInt("oid")));
        document.add(new Paragraph("ID Producto: " + rsOrder.getString("pid")));
        document.add(new Paragraph("Precio: " + rsOrder.getInt("price")));
        document.add(new Paragraph("Cantidad: " + rsOrder.getInt("quantity")));
        document.add(new Paragraph("ID Cliente: " + rsOrder.getString("uid")));
        document.add(new Paragraph("Fecha y Hora Orden: " + rsOrder.getTimestamp("orderdatetime")));
        document.add(new Paragraph("Total: " + (rsOrder.getInt("price") * rsOrder.getInt("quantity"))));

        document.close();
        
        out.println("Factura/Boleta generada exitosamente.");
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


