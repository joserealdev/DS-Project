<%@page import="java.util.ArrayList"%>
    <%@page import="com.josereal.model.Question"%>
        <%@page import="com.josereal.controller.QuestionsController"%>
            <%@ page language="java" contentType="text/javascript" %>
                <%
        QuestionsController controller=new QuestionsController();
        controller.openConnection();
        ArrayList<Question> preguntas=controller.getRandomTestBynumber(30);
        controller.closeConnection();
        out.println("let pregunta=new Array();");
        for(int x=0;x<preguntas.size();x++){
            Question sacar=(Question) preguntas.get(x);
            out.println("pregunta.push('"+sacar.getIdquestion()+"')");
            out.println("pregunta.push('"+sacar.getQuestion()+"')");
            out.println("pregunta.push("+sacar.getAnswers()+")");
            out.println("pregunta.push('"+sacar.getImage()+"')");
            out.println("preguntas.push(pregunta);");
            out.println("pregunta=new Array();");
        }
    %>