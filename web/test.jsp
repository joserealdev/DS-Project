<%@page import="com.josereal.model.Question"%>
    <%@page import="java.util.ArrayList"%>
        <%@page import="com.josereal.controller.QuestionsController"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" type="image/png" href="src/favicon.ico">
    <link rel="stylesheet" href="src/owlcarousel/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="src/owlcarousel/assets/owl.theme.default.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
        crossorigin="anonymous">
    <link rel="stylesheet" href="src/style/main.css">
    <link rel="stylesheet" href="src/style/header.css">
    <link rel="stylesheet" href="src/style/footer.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
    <script src="src/owlcarousel/owl.carousel.min.js"></script>
    <script src="src/js/touch.js"></script>
    <script src="src/js/main.js"></script>

    <title>Test</title>
</head>

<body>
    <!--div id="loader"><script type="text/javascript" src="getQuestions.jsp"></script></div-->
    <h1>DS project
        <span class="user">Invitado</span>
    </h1>

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
            <img src="src/uploaded/images/default.jpg" class="img-responsive center-block"
                alt="">
        </div>
        <div class="question-container">
            <div class="question">
                <p>
                    <span id="number"></span>
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
</body>

</html>