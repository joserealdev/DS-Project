<%@page import="com.josereal.model.User"%>
<%@page import="java.util.List"%>
<%@page import="com.josereal.model.Question"%>
    <%@page import="java.util.ArrayList"%>
        <%@page import="com.josereal.controller.AppController"%>
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta http-equiv="X-UA-Compatible" content="ie=edge">
                <link rel="icon" type="image/png" href="src/favicon.ico">
                <link rel="stylesheet" href="src/owlcarousel/assets/owl.carousel.min.css">
                <link rel="stylesheet" href="src/owlcarousel/assets/owl.theme.default.min.css">
                <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
                    crossorigin="anonymous"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
                    crossorigin="anonymous"></script>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
                    crossorigin="anonymous">
                <link rel="stylesheet" href="src/style/main.css">
                <link rel="stylesheet" href="src/style/header.css">
                <link rel="stylesheet" href="src/style/footer.css">
                <script src="src/owlcarousel/owl.carousel.min.js"></script>
                <script src="src/js/touch.js"></script>
                <script src="src/js/main.js"></script>
                <script src="src/js/correct.js"></script>

                <title>Test</title>
            </head>

            <body>
                <%
                if((User)session.getAttribute("userdata")!=null){
                    Integer id=null;
                    try{
                       id=Integer.parseInt(request.getParameter("nquestions"));
                    }catch(Exception e){
                       id=10;
                    }
                    if(id<10) id=10;
                    AppController controller=new AppController();
                    controller.openConnection();
                    List data=controller.getRandomTestBynumber(id);
                    controller.closeConnection();
                    ArrayList<Question> questions=(ArrayList)data.get(0);
                    int solutions[]=(int[])data.get(1);
                    session.setAttribute("questions", questions);
                    session.setAttribute("solutions", solutions);
                    User loggeduser=(User)session.getAttribute("userdata");
                %>
                <div id="loader">
                    <script type="text/javascript" src="getQuestions.jsp"></script>
                </div>
                <div class="header">
                    <a href="index.jsp">DS Project</a>
                    <span class="user">
                        <button class="btn-corr">Corregir</button>
                    </span>
                </div>

                <div class="maincontent">
                    <div class="leftarrow" id="btnleft">
                        <a class="arrowbtn">
                            <img src="src/images/left.png" alt="left arrow">
                        </a>
                    </div>
                    <div class="rightarrow" id="btnright">
                        <a class="arrowbtn">
                            <img src="src/images/right.png" alt="right arrow">
                        </a>
                    </div>
                    <div class="image">
                        <img id="imgquestion" width="576px" height="384px" src="src/uploaded/images/default.jpg" class="img-responsive center-block" alt="">
                    </div>
                    <div class="question-container">
                        <div class="question">
                            <p>
                                <span id="number">1.-</span>
                                <span id="question">Loading...</span>
                            </p>
                        </div>
                        <div class="answers-container">
                            <div class="answers">
                                <ul>
                                    <li>
                                        <label class="containerrb">
                                            <input type="radio" name="1" value="1"> Ejemplo 1
                                            <span class="checkmark"></span>
                                        </label>
                                    </li>
                                    <li>
                                        <label class="containerrb">
                                            <input type="radio" name="1" value="2"> Ejemplo 2.
                                            <span class="checkmark"></span>
                                        </label>
                                    </li>
                                    <li>
                                        <label class="containerrb">
                                            <input type="radio" name="1" value="3"> Ejemplo 3.
                                            <span class="checkmark"></span>
                                        </label>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="drag-controls"></div>

                <div class="selec-container row">
                    <div id="btns" class="owl-carousel owl-theme col-xl-12 col-lg-12 col-md-12"></div>
                </div>
                <div class="modal fade estadisticasmodal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle">Estadísticas</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body estadisticas">
                                <table>
                                    <tr><td>Preguntas totales:</td><td id="numbquestions"><%out.print(questions.size());%></td></tr>
                                    <tr><td>Aciertos:</td><td id="success"></td></tr>
                                    <tr><td>Fallos:</td><td id="fail"></td></tr>
                                    <tr><td>En blanco:</td><td id="blank"></td></tr>
                                    <tr style="border-top:2px solid black"><td>Porcentaje de aciertos:</td><td id="succent"></td></tr>
                                    <tr><td>Porcentaje de fallos:</td><td id="falcent"></td></tr>
                                    <tr><td>Porcentaje en blanco:</td><td id="blacent"></td></tr>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <div>Estás <span id="resultado"></span></div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                }else{
                    %><h2>Sólo los usuarios registrados pueden realizar tests</h2><a href="index.jsp">Volver</a><%
                }
                %>
            </body>

            </html>