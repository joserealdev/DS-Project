<%@page import="java.util.ArrayList"%>
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
            if(request.getParameter("pregunta")!="" && request.getParameter("pregunta")!=null){
                out.print(request.getParameter("pregunta"));
                int i=0, cont=0;
                while(request.getParameter("resp"+i)!=null){
                    cont++;
                    i++;
                }
                cont--;
                String preguntas[]=new String[i];
                for(int x=0;x<i;x++){
                    preguntas[x]=request.getParameter("resp"+x);//VALIDAR LA CADENA ' "
                }
                    QuestionsController controller=new QuestionsController();
                    controller.openConnection();
                    int je=controller.getLastId();
                    int correcto=0;
                    je=je*4;
                    String answers="'{\"answers\": [";
                    for(int x=0;x<preguntas.length;x++){
                        answers+="{ \"idanswer\": "+je+", \"answer\": \""+preguntas[x]+"\" }";
                        if(x==Integer.parseInt(request.getParameter("correct"))) correcto=je;
                        je++;
                        if(x!=cont) answers+=",";
                    
                    }
                    answers+="],\"correct\": "+correcto+"}'";
                    Question newquestion=new Question(0, request.getParameter("pregunta"), answers, null, 0, 0);
                    controller.addQuestion(newquestion);
                    controller.closeConnection();
            
            }else{
                %>
        
        
                <form action="ainsert.jsp" method="post">
                    Pregunta: <input type="text" name="pregunta" required><br>
                    Respuesta1: <input type="radio" name="correct" value="0" checked><input type="text" name="resp0" required><br>
                    Respuesta2: <input type="radio" name="correct" value="1"><input type="text" name="resp1" required><br>
                    Respuesta3: <input type="radio" name="correct" value="2"><input type="text" name="resp2" required><br>
                    <input type="submit" value="Enviar">
                </form>
        
        <%
            
            
            }
        
        %>
        
    </body>
</html>
