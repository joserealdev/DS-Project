<%-- 
    Document   : modify
    Created on : 30-may-2018, 16:48:39
    Author     : casa
--%>

<%@page import="com.josereal.model.User"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.josereal.model.Question"%>
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
        <link rel="stylesheet" href="src/style/insert.css">
        <link rel="stylesheet" href="src/style/header.css">
        <title>Modificar pregunta</title>
    </head>
    <body>
        <div class="header">
            <a href="index.jsp">Modificar pregunta</a>
        </div>
        <%
            session=request.getSession();
            if((User)session.getAttribute("userdata")!=null){
                User loggeduser=(User)session.getAttribute("userdata");
                if(loggeduser.isIsAdmin()){
                    Integer id=null;
                    try{
                       id=Integer.parseInt(request.getParameter("id"));
                    }catch(Exception e){
                       response.sendRedirect("adminquestions.jsp?action=modify");
                    }
                    if(request.getParameter("pregunta")!="" && request.getParameter("pregunta")!=null){
                        boolean cleandata=true; //VALIDATE IDS AND DATA    
                        boolean modify=false;
                        //GET QUESTION AND CHECK IF IT IS CLEAR
                        String pregunta=request.getParameter("pregunta");
                        //convert String to UTF-8
                        byte[] bytes = pregunta.getBytes(StandardCharsets.ISO_8859_1);
                        pregunta=new String(bytes, StandardCharsets.UTF_8);
                        String preguntalimpia="";
                        for(int x=0;x<pregunta.length();x++){
                            char letter=pregunta.charAt(x);
                            String comilla="'";
                            if(letter==comilla.charAt(0)){
                                preguntalimpia+="\\";
                            }
                            preguntalimpia+=letter;
                        }
                        pregunta=preguntalimpia;
                        //CHECK HOW MANY INPUTS EXISTS
                        int i=0, cont=0;
                        while(request.getParameter("resp"+i)!=null){
                            cont++;
                            i++;
                        }
                        cont--;
                        //Verify answers content
                        String preguntas[]=new String[i];
                        int ids[]=new int[i];
                        for(int x=0;x<i;x++){
                            //GET ANSWER AND CONVERT TO UTF-8
                            bytes=null;
                            String getanswer=request.getParameter("resp"+x);
                            bytes = getanswer.getBytes(StandardCharsets.ISO_8859_1);
                            getanswer=new String(bytes, StandardCharsets.UTF_8);
                            String answer=Jsoup.parse(getanswer).text();

                            String cleananswer="";
                            for(int p=0;p<answer.length();p++){
                                char letter=answer.charAt(p);
                                String comilla="\"";
                                if(letter==comilla.charAt(0)){
                                    cleananswer+="\\";
                                }
                                cleananswer+=letter;
                            }

                            preguntas[x]=cleananswer; 
                            ids[x]=Integer.parseInt(request.getParameter("resp"+x+"i"));
                        }

                        //JSON Format

                        int correcto=0;
                        String answers="{\"answers\": [";
                        for(int x=0;x<preguntas.length;x++){
                            answers+="{ \"idanswer\": "+ids[x]+", \"answer\": \""+preguntas[x]+"\" }";
                            if(ids[x]==Integer.parseInt(request.getParameter("correct"))) correcto=ids[x];
                            if(x!=cont) answers+=",";

                        }
                        answers+="],\"correct\": "+correcto+"}";

                        //INSERT DB
                        if(cleandata){
                            AppController controller=new AppController();
                            controller.openConnection();
                            Question original=controller.getQuestion(id);
                            Question modifyquestion=new Question(original.getIdquestion(), pregunta, answers, original.getImage(), original.getNshowed(), original.getNsuccess(), original.getNfail());
                            modify=controller.modifyQuestion(modifyquestion);
                            controller.closeConnection();
                            %>
                            <script>
                                $(document).ready(function(){
                                    $('.resultado').html('<%if(modify) out.print("La pregunta ha sido modificada correctamente");else out.print("Hubo un error");%>');
                                    $('#modifymodal').modal();
                                });
                            </script>
                            <%
                        }else out.println("<script>alert('Se ha producido un error')</script>");
                    }
                if(id!=null){
                    AppController controller=new AppController();
                    controller.openConnection();
                    Question modify=controller.getQuestion(id);
                    controller.closeConnection();
                    String answers[]=new String[3];
                    int identify[]=new int[3];
                    String json=modify.getAnswers();
                    JSONObject obj=new JSONObject(json);
                    JSONArray array=obj.getJSONArray("answers");
                    for(int i=0;i<array.length();i++){
                        //CREATE A NEW JSONOBJECT FOR EACH ANSWER AND GET DATA
                        JSONObject obj2=new JSONObject(array.get(i).toString());
                        answers[i]=obj2.getString("answer");
                        identify[i]=obj2.getInt("idanswer");
                    }
                    int correcta=obj.getInt("correct");

                    %>

        <div class="modifyform">
            <form class="needs-validation" action="modify.jsp" method="post">
                <div class="insert">
                    <div class="question">Pregunta:</div>
                    <input class="form-control" type="text" name="pregunta" minlength="10" maxlength="100" value="<%out.print(modify.getQuestion());%>" required>
                    <ul>
                        <li>
                            Respuesta 1:
                            <label class="containerrb">
                                <input type="radio" name="correct" value="<%out.print(identify[0]);%>" <%if(identify[0]==correcta)out.print("checked");%>>
                                <span class="checkmark"></span>
                            </label>
                            <input class="form-control" type="text" name="resp0" minlength="2" maxlength="70" value="<%out.print(answers[0]);%>" required>
                            <input type="text" name="resp0i" value="<%out.print(identify[0]);%>" hidden>
                        </li>
                        <li>
                            Respuesta 2:
                            <label class="containerrb">
                                <input type="radio" name="correct" value="<%out.print(identify[1]);%>" <%if(identify[1]==correcta)out.print("checked");%>>
                                <span class="checkmark"></span>
                            </label>
                            <input class="form-control" type="text" name="resp1" minlength="2" maxlength="70" value="<%out.print(answers[1]);%>" required>
                            <input type="text" name="resp1i" value="<%out.print(identify[1]);%>" hidden>
                        </li>
                        <li>
                            Respuesta 3:
                            <label class="containerrb">
                                <input type="radio" name="correct" value="<%out.print(identify[2]);%>" <%if(identify[2]==correcta)out.print("checked");%>>
                                <span class="checkmark"></span>
                            </label>
                            <input class="form-control" type="text" name="resp2" minlength="2" maxlength="70" value="<%out.print(answers[2]);%>" required>
                            <input type="text" name="resp2i" value="<%out.print(identify[2]);%>" hidden>
                        </li>
                    </ul>
                    <input type="file" class="custom-file-input2" name="image" id="image" accept="image/x-png,image/gif,image/jpeg">
                    <input type="text" name="id" value="<%out.print(id);%>" hidden>
                </div>
                <br>
                <input type="submit" value="Modificar pregunta">
            </form>
        </div>
        <%      }

                }else{
                    %><h2>No tienes permiso para acceder a esta página</h2><a href="index.jsp">Volver</a><%
                }
            }else{
                %><h2>No tienes permiso para acceder a esta página</h2><a href="index.jsp">Volver</a><%
            }
        %>
        <!-- Modal -->
        <div class="modal fade" id="modifymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Modificar pregunta</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body resultado">
                ...
              </div>
            </div>
          </div>
        </div>
    </body>
</html>
