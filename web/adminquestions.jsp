<%-- 
    Document   : modify
    Created on : 30-may-2018, 15:06:12
    Author     : casa
--%>

<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.josereal.model.Question"%>
<%@page import="com.josereal.controller.AppController"%>
<%@page import="java.util.Arrays"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="com.josereal.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            String action="";
            if(request.getParameter("action").equals("modify")) action="Modificar preguntas";
            else if(request.getParameter("action").equals("delete")) action="Eliminar preguntas";
            else action="404";
        %>
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
        <link rel="stylesheet" href="src/style/insert.css">
        <link rel="stylesheet" href="src/style/header.css">
        <title><%out.print(action);%></title>
    </head>
    <body>
        <div class="header">
            <a href="index.jsp"><%out.print(action);%></a>
        </div>
        <%
        session=request.getSession();
        if((User)session.getAttribute("userdata")!=null){
            User loggeduser=(User)session.getAttribute("userdata");
            if(loggeduser.isIsAdmin() && (request.getParameter("action").equals("modify") || request.getParameter("action").equals("delete"))){
                
                AppController controller=new AppController();
                controller.openConnection();
                ArrayList<Question> questions=controller.getQuestions();
                controller.closeConnection();
                
                %>
                <div class="tablecontainer">
                    <table>
                        <th>Pregunta</th><th>Respuestas</th>

                        <%
                            for(int x=0;x<questions.size();x++){
                                Question getQuestion=questions.get(x);
                                String json=getQuestion.getAnswers();
                                JSONObject obj=new JSONObject(json);
                                JSONArray array=obj.getJSONArray("answers");
                                %>
                                    <tr id="<%out.print(getQuestion.getIdquestion());%>">
                                        <td><%out.print(getQuestion.getQuestion());%></td>
                                        <%
                                            for(int i=0;i<array.length();i++){
                                                JSONObject obj2=new JSONObject(array.get(i).toString());
                                                String pregunta=obj2.getString("answer");
                                                %><td><%out.print(pregunta);%></td><%
                                            }
                                            if(request.getParameter("action").equals("modify")){
                                        %>
                                        <td><form action="modify.jsp" method="post"><input type="text" name="id" value="<%out.print(getQuestion.getIdquestion());%>" hidden><input type="submit" value="Modificar"></form></td>
                                        <%  }else{ %>
                                        <td><form action="delete.jsp" method="post"><input type="text" name="id" value="<%out.print(getQuestion.getIdquestion());%>" hidden><input type="submit" value="Borrar"></form></td>
                                        <%  }      %>
                                    </tr>
                                <%
                            }
                        %>

                    </table>
                </div>    
        
                <%
                
            }else{
                %><h2>La página que está solicitando no existe</h2><a href="index.jsp">Volver</a><%
            }

        }else{
            %><h2>No tienes permiso para acceder a esta página</h2><a href="index.jsp">Volver</a><%
        }
        
        %>
        
    </body>
</html>
