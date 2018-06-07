<%@page import="com.josereal.model.User"%>
<!DOCTYPE html>
<html lang="en">

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
    <link rel="stylesheet" href="src/style/menu.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
                    crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp"
        crossorigin="anonymous">
    <script src="src/js/menu.js"></script>
    <title>DS project</title>
</head>

<body>
    <div class="header">
        <a href="index.jsp">DS Project</a>
    </div>
     <div class="main-menu">
        <!-- Contenedor -->
        <ul id="accordion" class="accordion">
    <%
        if(request.getParameter("close")!=null) {
            if(request.getParameter("close").equals("yes")) session.invalidate();
        }
        session=request.getSession();
        if((User)session.getAttribute("userdata")==null){
        %>
    
            <li>
                <div class="link">
                    <i class="fa fa-cog"></i>Cuenta
                    <i class="fa fa-chevron-down"></i>
                </div>
                <ul class="submenu">
                    <li>
                        <a href="login.jsp">Iniciar sesión</a>
                    </li>
                    <li>
                        <a href="signin.jsp">Registrarse</a>
                    </li>
                </ul>
            </li>
            <li>
                <ul class="link directlink">
                    <li>
                        <i class="fa fa-link"></i>
                        <a href="#">Sobre nosotros</a>
                    </li>
                </ul>
            </li>
    
    
        <%
        
        }else{
            User loggeduser=(User)session.getAttribute("userdata");

            if(loggeduser.isIsAdmin()){
                
            %>
            <li>
                <div class="link">
                    <i class="fa fa-database"></i>Administrar preguntas
                    <i class="fa fa-chevron-down"></i>
                </div>
                <ul class="submenu">
                    <li>
                        <a href="insert.jsp">Insertar pregunta</a>
                    </li>
                    <li>
                        <a href="adminquestions.jsp?action=modify">Modificar pregunta</a>
                    </li>
                    <li>
                        <a href="adminquestions.jsp?action=delete">Eliminar pregunta</a>
                    </li>
                </ul>
            </li>
            <%
            }
            %>
            <li>
                <ul class="link directlink">
                    <li>
                        <i class="fa fa-play"></i>
                        <button type="button" data-toggle="modal" data-target="#startmodal">Realizar test</button>
                    </li>
                </ul>
            </li>
            <li>
                <ul class="link directlink">
                    <li>
                        <i class="fa fa-chart-bar"></i>
                        <a href="viewstats.jsp">Ver estadisticas</a>
                    </li>
                </ul>
            </li>
            <li>
                <ul class="link directlink">
                    <li>
                        <i class="fa fa-link"></i>
                        <a href="#">Sobre nosotros</a>
                    </li>
                </ul>
            </li>
            <li class="cerrar">
                <ul class="link directlink">
                    <li>
                        <i class="fa fa-window-close"></i>
                        <a href="#">
                            <form action="index.jsp" method="post">
                            <input type="text" name="close" value="yes" hidden>
                            <input type="submit" value="Cerrar sesión">
                            </form>
                        </a>
                    </li>
                </ul>
            </li>
        <!-- Modal -->
        <div class="modal fade" id="startmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Comenzar test</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                ¿Cuántas preguntas desea responder?
                <form action="test.jsp" method="post">
                    <input type="number" name="nquestions" value="10" required>
                    <input id="starttest" type="submit" hidden>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="startbtn">Comenzar test</button>
              </div>
            </div>
          </div>
        </div>
        <script>
        $(document).ready(function(){
            $("#startbtn").click(function(){
                $('#starttest').click();
            });
        });
        </script>
    <%
        }
    %>
        </ul>
    </div>
</body>

</html>