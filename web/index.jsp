<%-- 
    Document   : newjsp
    Created on : 24-mar-2018, 11:25:53
    Author     : casa
--%>

<%@page import="com.josereal.model.Question"%>
<%@page import="com.josereal.controller.QuestionsController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            QuestionsController test=new QuestionsController();
            String answers="[{\"respuestas\": [{ \"idrespuesta\": 3, \"respuesta\": \"Sí, siempre\" },{ \"idrespuesta\": 4, \"respuesta\": \"No\" },{ \"idrespuesta\": 5, \"respuesta\": \"A veces\" }],\"correcta\": 5}]";
            Question newq=new Question("This is a question", answers, null, 0, 0);
            test.openConnection();
            if(test.addQuestion(newq)) out.print("<h1>Success");
            else out.print("<h1>FAIL");
            test.closeConnection();
        %>
    </body>
</html>
