<%-- 
    Document   : Peticiones
    Created on : 2/10/2021, 2:08:26 p. m.
    Author     : Leandro
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="logica.Usuario"%>
<%@page import="com.google.gson.Gson"%>

<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"  %>

<%

    String respuesta = "{";

    List<String> tareas = Arrays.asList(new String[]{
        "listarusuario",
        "eliminarusuario",
        "guardarUsuario",
        "actualizarusuario"
    });

       String proceso = request.getParameter("proceso");

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\":true, ";
        if (proceso.equals("guardarUsuario")) {

            String tdoc = request.getParameter("tipo_documento");
            String ndoc = request.getParameter("num_documento");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String telefono = request.getParameter("telefono");
            String correo = request.getParameter("correo");
            String tvehi = request.getParameter("tipo_vehiculo");
            String placa = request.getParameter("placa");

            Usuario c = new Usuario();
            c.setTipo_documento(tdoc);
            c.setNum_documento(ndoc);
            c.setNombre(nombre);
            c.setApellido(apellido);
            c.setTelefono(telefono);
            c.setCorreo(correo);
            c.setTipo_vehiculo(tvehi);
            c.setPlaca(placa);

            if (c.guardarUsuario()) {
                respuesta += " \"guardarUsuario\":true";
            } else {

                respuesta += " \"guardarUsuario\":false";
            }

        } else if (proceso.equals("eliminarusuario")) {
            String ident = request.getParameter("identificacion");
            Usuario c = new Usuario();

            if (c.borrarUsuario(ident)) {
                respuesta += " \"eliminarcontacto\":true";

            } else {
                respuesta += " \"eliminarcontacto\":false";
            }
        } else if (proceso.equals("listarusuario")) {

            Usuario c = new Usuario();
            ArrayList<Usuario> lista= c.listaUsuarios();
            respuesta += " \"listarusuario\":true, \"Contactos\":" + new Gson().toJson(lista);
        } else if (proceso.equals("actualizarusuario")) {

            String ident = request.getParameter("identificacion");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String genero = request.getParameter("genero");
            String tipoIdentificacion = request.getParameter("tipoIdentificacion");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String correo = request.getParameter("correo");

            Usuario c = new Usuario();
            c.setIdentificacion(ident);
            c.setNombre(nombre);
            c.setApellido(apellido);
            c.setGenero(genero);
            c.setTipoIdentificacion(tipoIdentificacion);
            c.setTelefono(telefono);
            c.setDireccion(direccion);
            c.setCorreo(correo);

            if (c.actualizarContacto()) {
                respuesta += " \"actualizarcontacto\":true";
            } else {

                respuesta += " \"actualizarcontacto\":false";
            }

        }
        //-----------------------------------------------------------------------------------------------------------
    } else {

        respuesta += "\"ok\":false, ";

        respuesta += "\"errorMsg\": \"Proceso no v�lido\" ";

    }

    respuesta += "}";

    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);

%>
