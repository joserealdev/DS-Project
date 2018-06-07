<%-- 
    Document   : signin
    Created on : 26-may-2018, 12:20:10
    Author     : casa
--%>

<%@page import="com.josereal.controller.AppController"%>
<%@page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="com.josereal.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="icon" type="image/png" href="src/favicon.ico">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
                    crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
            crossorigin="anonymous">
        <link rel="stylesheet" href="src/style/main.css">
        <link rel="stylesheet" href="src/style/header.css">
        <link rel="stylesheet" href="src/style/footer.css">
        <link rel="stylesheet" href="src/style/form.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
        <title>Registro</title>
    </head>
    <body>
        <div class="header">
            <a href="index.jsp">Formulario de registro</a>
        </div>
        <%
            if(request.getParameter("user")!=null && !request.getParameter("user").equals("") && request.getParameter("pass")!=null && !request.getParameter("pass").equals("")){
                String user=request.getParameter("user");
                String pass=request.getParameter("pass");
                MessageDigest md = MessageDigest.getInstance("MD5");
                md.update(pass.getBytes());
                byte[] digest = md.digest();
                pass=DatatypeConverter.printHexBinary(digest).toUpperCase();
                User newuser=new User(0, user, pass, false);
                AppController controller=new AppController();
                controller.openConnection();
                try{    
                    if(controller.addUser(newuser)){
                        %>
                        <div class="main-menu">
                            Se ha registrado correctamente.
                            <p>Haga click <a href="index.jsp">aquí</a> si su navegador no le redirige automáticamente</p>
                        </div>
                        <script>
                            setTimeout(function() {
                                document.location = "index.jsp";
                            }, 2000); // <-- this is the delay in milliseconds
                        </script>
                        <%
                    }else{
                        %>
                        <div class="main-menu">
                            Hubo un error
                        </div>
                        <%
                    }
                }catch(SQLIntegrityConstraintViolationException e) 
                {
                    %>
                    <div class="login-page">
                        <div class="form">
                            <form class="register-form" action="signin.jsp" method="post">
                                <div class="group">
                                    <input type="text" name="user" required>
                                    <span class="highlight"></span>
                                    <span class="bar"></span>
                                    <label>Introduzca su usuario</label>
                                </div><span style="color:red"> * El usuario ya existe</span>
                                <br>
                                <div class="group">
                                    <input type="password" name="pass" required>
                                    <span class="highlight"></span>
                                    <span class="bar"></span>
                                    <label>Introduzca su contraseña</label>
                                </div>
                                <br>
                                <input type="submit" value="Registrarse">
                                <p class="message">¿Ya tienes cuenta?
                                    <a href="login.jsp">Iniciar sesion</a>
                                </p>
                            </form>
                        </div>
                    </div>
                    <%
                }
                catch(Exception e)
                {
                    %>
                    <div class="main-menu">
                        Hubo un error
                        <a href="index.jsp">Volver</a>
                    </div>
                    <%
                }
                
                controller.closeConnection();   
            }else{
        %>
        <div class="login-page">
            <div class="form">
                <form class="register-form" action="signin.jsp" method="post">
                    <div class="group">
                        <input type="text" name="user" required>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Introduzca su usuario</label>
                    </div>
                    <br>
                    <div class="group">
                        <input type="password" name="pass" required>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label>Introduzca su contraseña</label>
                    </div>
                    <br>
                    <input type="submit" value="Registrarse">
                    <p class="message">¿Ya tienes cuenta?
                        <a href="login.jsp">Iniciar sesion</a>
                    </p>
                </form>
            </div>
        </div>
        <%
            }
        %>
    </body>
</html>
