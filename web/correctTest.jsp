<%@page import="com.josereal.model.User"%>
<%@page import="com.josereal.controller.AppController"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.josereal.model.Question"%>
<%@page import="java.util.Arrays"%>
<%

    int solutions[]=(int[])session.getAttribute("solutions");
    out.println(Arrays.toString(solutions));
    String useranswers[]=request.getParameter("usersanswers").split(",");
    ArrayList<Question> questions=(ArrayList)session.getAttribute("questions");
    out.println(Arrays.toString(useranswers));
    User loggeduser=(User)session.getAttribute("userdata");

    AppController controller=new AppController();
    controller.openConnection();
        controller.correctTest(solutions, useranswers, questions, loggeduser.getIduser());
    controller.closeConnection();
    out.println("todook");
%>
