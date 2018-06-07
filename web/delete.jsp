<%-- 
    Document   : delete
    Created on : 30-may-2018, 16:49:55
    Author     : casa
--%>

<%@page import="com.josereal.model.User"%>
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
        <title>Eliminar pregunta</title>
    </head>
    <body>
        <div class="header">
            <a href="index.jsp">Eliminar pregunta</a>
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
                   response.sendRedirect("adminquestions.jsp?action=delete");
                }
                if(request.getParameter("pregunta")!="" && request.getParameter("pregunta")!=null){
                    AppController controller=new AppController();
                    controller.openConnection();
                    Question toDelete=controller.getQuestion(id);
                    boolean deleted=controller.deleteQuestion(toDelete);
                    controller.closeConnection();
                    %>
                    <script>
                        $(document).ready(function(){
                            $('.resultado').html('<%if(deleted) out.print("La pregunta ha sido eliminada correctamente");else out.print("Hubo un error");%>');
                            $('.resultadomodal').modal();
                        });
                    </script>
                    <%

                }else if(id!=null){
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
                        <div class="deleteform">
                            <form class="needs-validation" action="delete.jsp" method="post">
                                <div class="insert">
                                    <div class="question">Pregunta:</div>
                                    <input class="form-control" type="text" name="pregunta" minlength="10" maxlength="100" value="<%out.print(modify.getQuestion());%>" readonly>
                                    <ul>
                                        <li>
                                            Respuesta 1:
                                            <label class="containerrb">
                                                <input type="radio" name="correct" value="<%out.print(identify[0]);%>" <%if(identify[0]==correcta)out.print("checked");%> disabled>
                                                <span class="checkmark"></span>
                                            </label>
                                            <input class="form-control" type="text" name="resp0" minlength="2" maxlength="70" value="<%out.print(answers[0]);%>" readonly>
                                        </li>
                                        <li>
                                            Respuesta 2:
                                            <label class="containerrb">
                                                <input type="radio" name="correct" value="<%out.print(identify[1]);%>" <%if(identify[1]==correcta)out.print("checked");%> disabled>
                                                <span class="checkmark"></span>
                                            </label>
                                            <input class="form-control" type="text" name="resp1" minlength="2" maxlength="70" value="<%out.print(answers[1]);%>" readonly>
                                            <input type="text" name="resp1i" value="<%out.print(identify[1]);%>" hidden>
                                        </li>
                                        <li>
                                            Respuesta 3:
                                            <label class="containerrb">
                                                <input type="radio" name="correct" value="<%out.print(identify[2]);%>" <%if(identify[2]==correcta)out.print("checked");%> disabled>
                                                <span class="checkmark"></span>
                                            </label>
                                            <input class="form-control" type="text" name="resp2" minlength="2" maxlength="70" value="<%out.print(answers[2]);%>" readonly>
                                            <input type="text" name="resp2i" value="<%out.print(identify[2]);%>" hidden>
                                        </li>
                                    </ul>
                                        <!--mostrar imagen aqui-->
                                    <input type="text" name="id" value="<%out.print(id);%>" hidden>
                                </div>
                                <br>
                                <button type="button" class="btndelete" data-toggle="modal" data-target="#confirmmodal">Eliminar pregunta</button>
                                <input type="submit" value="Eliminar pregunta" hidden>
                            </form>
                        </div>
                    <%
                }else{
                    out.println("<h1>Hubo un error</h1>");
                }
            }else{
                %><h2>No tienes permiso para acceder a esta página</h2><a href="index.jsp">Volver</a><%
            }
        }else{
            %><h2>No tienes permiso para acceder a esta página</h2><a href="index.jsp">Volver</a><%
        }
        %>
        <!-- Modal -->
        <div class="modal fade" id="confirmmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Eliminar pregunta</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                ¿Desea eliminar esta pregunta? Esta acción es irreversible.
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-primary" id="deletebtn">Eliminar pregunta</button>
              </div>
            </div>
          </div>
        </div>
        <div class="modal fade resultadomodal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Resultado</h5>
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
        <script>
        $(document).ready(function(){
            $("#deletebtn").click(function(){
                $('input[type="submit"]').click();
            });
        });
        </script>
    </body>
</html>
