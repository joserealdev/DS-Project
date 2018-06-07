<%-- 
    Document   : viewstats
    Created on : 01-jun-2018, 14:25:35
    Author     : casa
--%>

<%@page import="com.josereal.model.User"%>
<%@page import="com.josereal.model.Stats"%>
<%@page import="com.josereal.controller.AppController"%>
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
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
            crossorigin="anonymous">
        <link rel="stylesheet" href="src/style/stats.css">
        <link rel="stylesheet" href="src/style/header.css">
        <script src="src/js/stats.js"></script>
        <title>Estadísticas</title>
    </head>
    <body>
        <div class="header">
            <a href="index.jsp">Estadísticas</a>
        </div>
        <%
            session=request.getSession();
            if((User)session.getAttribute("userdata")!=null){
                User loggeduser=(User)session.getAttribute("userdata");
                Stats userstats=null;
                AppController controller=new AppController();
                controller.openConnection();
                userstats=controller.getStats(loggeduser.getIduser());
                controller.closeConnection();
                
                if(userstats!=null){
        %>
                    <div class="statsframe">
                        <div class="wrapper">
                            <div class="pie-charts">
                              <div class="pieID--operations pie-chart--wrapper">
                                <h2>Estadísticas de <%out.print(loggeduser.getUsername());%></h2>
                                <div class="pie-chart">
                                  <div class="pie-chart__pie"></div>
                                  <ul class="pie-chart__legend">
                                    <li><em>Aciertos</em><span><%out.print(userstats.getSuccess());%></span></li>
                                    <li><em>Fallos</em><span><%out.print(userstats.getWrong());%></span></li>
                                    <li><em>En blanco</em><span><%out.print(userstats.getShowedquestions()-userstats.getAnswered());%></span></li>
                                  </ul>
                                </div>
                              </div>
                            </div>
                        </div>
                    </div>
        <%      }else{
                    %><h2>No existen estadísticas de <%out.print(loggeduser.getUsername());%></h2><a href="index.jsp">Volver</a><%
                }
            }else{
                %><h2>Debe de estar registrado para poder ver las estadísticas</h2><a href="index.jsp">Volver</a><%
            }           
        %>
    </body>
</html>
