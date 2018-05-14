<%@page import="java.util.ArrayList"%>
<%@page import="com.josereal.model.Question"%>
<%@page import="com.josereal.controller.QuestionsController"%>
<%@ page language="java" contentType="text/javascript" %>
    <%
        QuestionsController controller=new QuestionsController();
        controller.openConnection();
        ArrayList<Question> preguntas=controller.getRandomTestBynumber(30);
        controller.closeConnection();
        
        for(int x=0;x<preguntas.size();x++){
            Question sacar=(Question) preguntas.get(x);
            out.println("let pregunta"+x+"=new Array();");
            out.println("pregunta"+x+".push('"+sacar.getQuestion()+"')");
            out.println("pregunta"+x+".push("+sacar.getAnswers()+")");
            out.println("pregunta"+x+".push('"+sacar.getImage()+"')");
            out.println("preguntas.push(pregunta"+x+");");
        }
    %> 