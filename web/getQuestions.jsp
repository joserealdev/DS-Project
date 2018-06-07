<%@page import="java.util.ArrayList"%>
    <%@page import="com.josereal.model.Question"%>
            <%@ page language="java" contentType="text/javascript" %>
    <%
            ArrayList<Question> preguntas=(ArrayList)session.getAttribute("questions");
            out.println("let pregunta=new Array();");
            for(int x=0;x<preguntas.size();x++){
                Question sacar=preguntas.get(x);
                out.println("pregunta.push('"+sacar.getIdquestion()+"')");
                out.println("pregunta.push('"+sacar.getQuestion()+"')");
                out.println("pregunta.push("+sacar.getAnswers()+")");
                out.println("pregunta.push('"+sacar.getImage()+"')");
                out.println("preguntas.push(pregunta);");
                out.println("pregunta=new Array();");
            }
            int total=preguntas.size();
            total++;
            out.println("usersanswers=null");
            out.println("usersanswers=new Array("+total+")");
            for(int x=0;x<total;x++){
                out.println("usersanswers["+x+"]=\"0\"");
            }
    %>