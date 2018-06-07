<%-- 
    Document   : login
    Created on : 26-may-2018, 13:48:23
    Author     : casa
--%>

<%@page import="com.josereal.model.User"%>
<%@page import="java.util.List"%>
<%@page import="com.josereal.controller.AppController"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.security.MessageDigest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="icon" type="image/png" href="src/favicon.ico">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
            crossorigin="anonymous">
        <link rel="stylesheet" href="src/style/main.css">
        <link rel="stylesheet" href="src/style/header.css">
        <link rel="stylesheet" href="src/style/footer.css">
        <link rel="stylesheet" href="src/style/form.css">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
                crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
        <title>Iniciar sesión</title>
    </head>
    <body>
        <div class="header">
            <a href="index.jsp">Iniciar sesión</a>
        </div>
        <%
            if(request.getParameter("user")!=null && !request.getParameter("user").equals("") && request.getParameter("pass")!=null && !request.getParameter("pass").equals("")){
                String user=request.getParameter("user");
                String pass=request.getParameter("pass");
                MessageDigest md = MessageDigest.getInstance("MD5");
                md.update(pass.getBytes());
                byte[] digest = md.digest();
                pass=DatatypeConverter.printHexBinary(digest).toUpperCase();
                AppController controller=new AppController();
                controller.openConnection();
                List logindata=controller.checkLogin(user, pass);                
                controller.closeConnection();
                boolean correctuser=(boolean) logindata.get(0);
                if(!correctuser){
                    %>
                    <div class="login-page">
                        <div class="form">
                            <form class="register-form" action="login.jsp" method="post">
                                <div class="group">
                                    <input type="text" name="user" required>
                                    <span class="highlight"></span>
                                    <span class="bar"></span>
                                    <label>Introduzca su usuario</label>
                                </div><span style="color:red"> * El usuario no existe</span>
                                <br>
                                <div class="group">
                                    <input type="password" name="pass" required>
                                    <span class="highlight"></span>
                                    <span class="bar"></span>
                                    <label>Introduzca su contraseña</label>
                                </div>
                                <br>
                                <input type="submit" value="Iniciar sesión">
                                <p class="message">¿No tienes cuenta?
                                    <a href="signin.jsp">Crear una cuenta</a>
                                </p>
                            </form>
                        </div>
                    </div>
                    <%
                }else{
                    boolean correctpassword=(boolean) logindata.get(1);
                    if(!correctpassword){
                        %>
                        <div class="login-page">
                            <div class="form">
                                <form class="register-form" action="login.jsp" method="post">
                                    <div class="group">
                                        <input type="text" name="user" value="<%out.print(user);%>" required>
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
                                    </div><span style="color:red"> * La contraseña no es correcta</span>
                                    <br>
                                    <input type="submit" value="Iniciar sesión">
                                    <p class="message">¿No tienes cuenta?
                                        <a href="signin.jsp">Crear una cuenta</a>
                                    </p>
                                </form>
                            </div>
                        </div> 
                        <%
                    }else{
                        User loggeduser=(User) logindata.get(2);
                        session.setAttribute("userdata", loggeduser);
                        %>
                        <div class="main-menu">
                            <p>Bienvenido <%out.print(loggeduser.getUsername());%></p>
                            <p>Haga click <a href="index.jsp">aquí</a> si su navegador no le redirige automáticamente</p>
                        </div>
                        <script>
                            setTimeout(function() {
                                document.location = "index.jsp";
                            }, 2000); // <-- this is the delay in milliseconds
                        </script>
                        <%
                    }
                    
                }
            }else{
            
        %>
                <div class="login-page">
                    <div class="form">
                        <form class="register-form" action="login.jsp" method="post">
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
                            <input type="submit" value="Iniciar sesión">
                            <p class="message">¿No tienes cuenta?
                                <a href="signin.jsp">Crear una cuenta</a>
                            </p>
                        </form>
                    </div>
                </div>
        <%
            }
        %>
    </body>
</html>
