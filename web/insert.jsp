<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.util.Arrays"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="com.josereal.model.User"%>
<%@page import="java.util.ArrayList"%>
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
        <title>Insertar pregunta</title>
    </head>
    <body>
        <%!
        private static String getFileExtension(String fileName) {
            if(fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0)
            return "."+fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
            else return "";
        }
        private static String getRandomFilename(){
            String palabra="";

            for(int x=0;x<10;x++){

                String [] abecedario = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", 
                                "K", "L", "M","N","O","P","Q","R","S","T","U","V","W", "X","Y","Z"};

                int num=(int) (Math.random()*(25-0+1));
                int up=(int) (Math.random()*(1-0+1));
                if(up==0)
                palabra+=abecedario[num].toLowerCase();
                else
                palabra+=abecedario[num];
            }

            return palabra;
        }
        private static boolean checkExtension(String ex){
            boolean exist=false;
            if(ex.equals(".jpg")) exist=true;
            if(ex.equals(".jpeg")) exist=true;
            if(ex.equals(".png")) exist=true;
            if(ex.equals(".gif")) exist=true;
            return exist;
        }
        %>
        <div class="header">
            <a href="index.jsp">Inserte la pregunta</a>
        </div>
        <%
        
        session=request.getSession();
        if((User)session.getAttribute("userdata")!=null){
            User loggeduser=(User)session.getAttribute("userdata");
            if(loggeduser.isIsAdmin()){
                
                    File file ;
                    int maxFileSize = 5000 * 1024;
                    int maxMemSize = 5000 * 1024;
                    ServletContext context = pageContext.getServletContext();
                    String filePath="//opt//tomcat//webapps//proyecto//src//uploaded//images//";
                    String tablePath="src/uploaded/images/";
                    /*Variables to store the information of the questions*/
                    String pregunta="";
                    ArrayList<String> nanswers=new ArrayList();
                    String correct="-1";
                    String rutaimagen="";
                    // Verify the content type
                    String contentType = request.getContentType();
                    
                    if(contentType!=null){

                        if ((contentType.indexOf("multipart/form-data") >= 0)) {
                           DiskFileItemFactory factory = new DiskFileItemFactory();
                           // maximum size that will be stored in memory
                           factory.setSizeThreshold(maxMemSize);

                           // Location to save data that is larger than maxMemSize.
                           factory.setRepository(new File("//opt//tomcat//webapps//proyecto//src//uploaded//"));

                           // Create a new file upload handler
                           ServletFileUpload upload = new ServletFileUpload(factory);

                           // maximum file size to be uploaded.
                           upload.setSizeMax( maxFileSize );

                           try { 
                              // Parse the request to get file items.
                              List fileItems = null;

                              fileItems=upload.parseRequest(request);
                              if(fileItems!=null){
                                // Process the uploaded file items
                                Iterator i = fileItems.iterator();
                                
                                while ( i.hasNext () ) {
                                   FileItem fi = (FileItem)i.next();
//GET FORM FIELDS
                                   if ( !fi.isFormField () ) {
                                      // Get the uploaded file parameters
                                      String fieldName = fi.getFieldName();
                                      String fileName = fi.getName();
                                      if(fileName.equals("")) break;
                                      String ex=getFileExtension(fileName);
                                      //CHECK IF IT IS A IMAGE
                                      if(!checkExtension(ex)) break;
                                      boolean isInMemory = fi.isInMemory();
                                      long sizeInBytes = fi.getSize();
                                      String palabra=getRandomFilename();
                                      // Write the file
                                      if( fileName.lastIndexOf("\\") >= 0 ) {
                                         file = new File( filePath + palabra + ex) ;
                                      } else {
                                         file = new File( filePath + palabra + ex) ;
                                      }
                                      rutaimagen=tablePath + palabra + ex;
                                      fi.write( file ) ;
                                      //out.println("Uploaded Filename: " + filePath + 
                                      //fileName + "<br>");
                                   }else if(fi.getFieldName().equals("pregunta")){
                                       pregunta=fi.getString();
                                       //CONVERT TO UTF8 TO AVOID STRANGE CHARACTERS
                                        byte[] bytes = pregunta.getBytes(StandardCharsets.ISO_8859_1);
                                        pregunta=new String(bytes, StandardCharsets.UTF_8);
                                        String preguntalimpia="";
                                        //VALIDATE STRING TO AVOID CRASHS
                                        for(int x=0;x<pregunta.length();x++){
                                            char letter=pregunta.charAt(x);
                                            String comilla="'";
                                            if(letter==comilla.charAt(0)){
                                                preguntalimpia+="\\";
                                            }
                                            preguntalimpia+=letter;
                                        }
                                        pregunta=preguntalimpia;
                                   }else if(fi.getFieldName().equals("correct")){
                                       correct=fi.getString();
                                   }else if(fi.getFieldName().contains("resp")){
                                        String getanswer=fi.getString();
                                        byte[] bytes = getanswer.getBytes(StandardCharsets.ISO_8859_1);
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
                                       nanswers.add(cleananswer);
                                       
                                   }
                                }
                                
                              }
                            }catch(Exception ex) {
                                %>
                                <script>
                                    alert('<%out.print(ex);%>');
                                </script>
                                <% 
                            }
                            
//IF ALL VALUES ARE FILL, INSERT
                            if(!pregunta.equals("") && nanswers.size()>0 && !correct.equals("-1")){
                                int cont=nanswers.size();
                                cont--;
                                //JSON Format
                                AppController controller=new AppController();
                                controller.openConnection();
                                int je=controller.getLastId();
                                int correcto=0;
                                je=je*4;//GET THE LAST ID AND MULTIPLY BY 4 FOR SURE A UNIQUE IDANSWER 
                                String answers="{\"answers\": [";
                                for(int x=0;x<nanswers.size();x++){
                                    answers+="{ \"idanswer\": "+je+", \"answer\": \""+nanswers.get(x)+"\" }";
                                    if(x==Integer.parseInt(correct)) correcto=je;
                                    je++;
                                    if(x!=cont) answers+=",";

                                }
                                answers+="],\"correct\": "+correcto+"}";
                                
                                //INSERT DB
                                if(rutaimagen.equals("")) rutaimagen=null;
                                Question newquestion=new Question(0, pregunta, answers, rutaimagen, 0, 0, 0);
                                boolean insert=controller.addQuestion(newquestion);
                                controller.closeConnection();
                                %>
                                <script>
                                    $(document).ready(function(){
                                        $('.resultado').html('<%if(insert) out.print("La pregunta ha sido insertada correctamente");else out.print("Hubo un error");%>');
                                        $('#insertmodal').modal();
                                    });
                                </script>
                                <%
                            }
                        } else {
                        %>
                            <script>
                            alert("Ocurrió un error");
                            </script>
                        <% 
                        }

                    }

                %>

               <div class="insertform">
                    <form class="needs-validation" action="insert.jsp" method="post" enctype="multipart/form-data">
                        <div class="insert">
                            <div class="question">Pregunta:</div>
                            <input class="form-control" type="text" name="pregunta" minlength="10" maxlength="100" value="" required>
                            <ul>
                                <li>
                                    Respuesta 1:
                                    <label class="containerrb">
                                        <input type="radio" name="correct" value="0" checked>
                                        <span class="checkmark"></span>
                                    </label>
                                    <input class="form-control" type="text" name="resp0" minlength="2" maxlength="70" value="" required>
                                </li>
                                <li>
                                    Respuesta 2:
                                    <label class="containerrb">
                                        <input type="radio" name="correct" value="1">
                                        <span class="checkmark"></span>
                                    </label>
                                    <input class="form-control" type="text" name="resp1" minlength="2" maxlength="70" value="" required>
                                </li>
                                <li>
                                    Respuesta 3:
                                    <label class="containerrb">
                                        <input type="radio" name="correct" value="2">
                                        <span class="checkmark"></span>
                                    </label>
                                    <input class="form-control" type="text" name="resp2" minlength="2" maxlength="70" value="" required>
                                </li>
                            </ul>
                            <input type="file" class="custom-file-input2" name="image" id="image" accept="image/x-png,image/gif,image/jpeg">
                        </div>
                        <br>
                        <input type="submit" value="Insertar pregunta">
                        <p class="message">Las respuestras se mostrarán de forma aleatoria
                        </p>
                    </form>
                </div>

                <%
            }else{
                %><h2>No tienes permiso para acceder a esta página</h2><a href="index.jsp">Volver</a><%
            }

        }else{
            %><h2>No tienes permiso para acceder a esta página</h2><a href="index.jsp">Volver</a><%
        }
        
        %>
        <!-- Modal -->
        <div class="modal fade" id="insertmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Insertar pregunta</h5>
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
