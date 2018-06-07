package com.josereal.controller;

import com.josereal.model.*;
import com.josereal.utilities.Fecha;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.json.JSONObject;

public class AppController {

    
    private final static String drv = "com.mysql.jdbc.Driver";
    
    private final static String db = "jdbc:mysql://localhost:3306/DB";
    private final static String user = "user";
    private final static String pass = "pass";

    Connection cn;
    PreparedStatement pst;
    ResultSetMetaData rsmd;

    public ResultSet rs;
    private ArrayList<Question> questions;

    public AppController() {
        super();
        questions = new ArrayList<Question>();
    }

    public void openConnection() throws ClassNotFoundException, SQLException {

        Class.forName(drv);
        cn = DriverManager.getConnection(db, user, pass);

    }

    public void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }

        if (pst != null) {
            pst.close();
        }

        if (cn != null) {
            cn.close();
        }
    }

    public ArrayList<Question> getQuestions() throws SQLException, ParseException {

        PreparedStatement preparedStatement = cn.prepareStatement("SELECT * FROM questions");
        
        rs = preparedStatement.executeQuery();
        while (rs.next()) {

            int idquestion = rs.getInt("idquestion");
            String tquestion = rs.getString("question");
            String answers = rs.getString("answers");
            String image = rs.getString("image");
            int nshowed = rs.getInt("nshowed");
            int nsuccess = rs.getInt("nsuccess");
            int nfail = rs.getInt("nfail");
            Question question = new Question(idquestion, tquestion, answers, image, nshowed, nsuccess, nfail);
            questions.add(question);

            question = null;
        }
        rs = null;
        preparedStatement = null;

        return questions;
    }
    
    public Question getQuestion(int id) throws SQLException, ParseException {

        PreparedStatement preparedStatement = cn.prepareStatement("SELECT * FROM questions WHERE idquestion =?");
        preparedStatement.setInt(1, id);
        
        rs = preparedStatement.executeQuery();
        Question getQuestion=new Question();
        while (rs.next()) {

            int idquestion = rs.getInt("idquestion");
            String tquestion = rs.getString("question");
            String answers = rs.getString("answers");
            String image = rs.getString("image");
            int nshowed = rs.getInt("nshowed");
            int nsuccess = rs.getInt("nsuccess");
            int nfail = rs.getInt("nfail");
            getQuestion = new Question(idquestion, tquestion, answers, image, nshowed, nsuccess, nfail);
        }
        rs = null;
        preparedStatement = null;

        return getQuestion;
    }
    
    public List getRandomTestBynumber(int numberofquestions) throws SQLException, ParseException {

        PreparedStatement preparedStatement = cn.prepareStatement("SELECT * FROM questions");
        
        rs = preparedStatement.executeQuery();
        ArrayList<Question> getquestions=new ArrayList<>();
        ArrayList<Question> randomQuestions=new ArrayList<>();
        List data=new ArrayList();
        rs.last();
        int tam=rs.getRow();
        if(tam>0){
            rs.beforeFirst();
            while (rs.next()) {
                int idquestion = rs.getInt("idquestion");
                String tquestion = rs.getString("question");
                String answers = rs.getString("answers");
                String image = rs.getString("image");
                int nshowed = rs.getInt("nshowed");
                int nsuccess = rs.getInt("nsuccess");
                int nfail = rs.getInt("nfail");
                Question question = new Question(idquestion, tquestion, answers, image, nshowed, nsuccess, nfail);
                getquestions.add(question);

                question = null;
            }
            //REORDER QUESTIONS
            Collections.shuffle(getquestions);
            if(tam<numberofquestions) numberofquestions=tam;
            int solution[]=new int[numberofquestions];
           
            for(int x=0;x<numberofquestions;x++){
                preparedStatement=null;
                Question question=getquestions.get(x);
                preparedStatement = cn.prepareStatement("Update questions Set nshowed=nshowed+1 Where idquestion=?");
                preparedStatement.setInt(1, question.getIdquestion());
                preparedStatement.executeUpdate();
                randomQuestions.add(getquestions.get(x));
                solution[x]=getCorrectAnswer(question);
            }
            
            data.add(randomQuestions);
            data.add(solution);
        }
        rs = null;
        preparedStatement = null;

        return data;
    }
    

    public boolean addQuestion(Question question) throws SQLException {

        boolean added = false;
        String sql = "insert into questions values (?,?,?,?,?,?,?)";
        PreparedStatement preparedStatement = cn.prepareStatement(sql);

        String newquestion = question.getQuestion();
        String answers = question.getAnswers();
        String image = question.getImage();

        preparedStatement.setInt(1, 0);
        preparedStatement.setString(2, newquestion);
        preparedStatement.setString(3, answers);
        preparedStatement.setString(4, image);
        preparedStatement.setInt(5, 0);
        preparedStatement.setInt(6, 0);
        preparedStatement.setInt(7, 0);
        preparedStatement.executeUpdate();
        preparedStatement = null;
        added = true;

        return added;
    }

    public boolean deleteQuestion(Question question) throws SQLException, ParseException {

        String field = "idquestion";
        String sql = "delete from questions where " + field + " =?";
        PreparedStatement preparedStatement = cn.prepareStatement(sql);
        preparedStatement.setInt(1, question.getIdquestion());

        int deleted = preparedStatement.executeUpdate();

        rs = null;
        preparedStatement = null;

        if (deleted > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean modifyQuestion(Question question) throws SQLException {

        String sql = "Update questions Set question=?, answers=?, image=?, nshowed=?, nsuccess=?, nfail=? Where idquestion=?";

        PreparedStatement preparedStatement = cn.prepareStatement(sql);
        preparedStatement.setString(1, question.getQuestion());
        preparedStatement.setString(2, question.getAnswers());
        preparedStatement.setString(3, question.getImage());
        preparedStatement.setInt(4, question.getNshowed());
        preparedStatement.setInt(5, question.getNsuccess());
        preparedStatement.setInt(6, question.getNfail());
        preparedStatement.setInt(7, question.getIdquestion());

        int modified = preparedStatement.executeUpdate();
        if (modified > 0) {
            return true;
        } else {
            return false;
        }
    }
    
    public int getLastId() throws SQLException{
        PreparedStatement preparedStatement = cn.prepareStatement("SELECT MAX(idquestion) FROM questions");
        rs = preparedStatement.executeQuery();
        rs.last();
        if(rs.getRow()==0) return 1;
        rs.beforeFirst();
        rs.next();
        int maxid=rs.getInt("MAX(idquestion)");
        rs=null;
        return maxid;
    }
    
    public int getCorrectAnswer(Question question){
        String json=question.getAnswers();
        JSONObject obj=new JSONObject(json);
        int correct=obj.getInt("correct");
    
        return correct;
    }
    
    public boolean correctTest(int[] solutions, String[] useranswers, ArrayList<Question> questions, int idUser) throws SQLException{
        boolean result=false;
        Question question=null;
        PreparedStatement preparedStatement=null;
        int correct=0, fail=0, blank=0, answered=0, showedquestions=questions.size();
        for(int x=0;x<solutions.length;x++){
            question=questions.get(x);
            
            if(solutions[x]==Integer.parseInt(useranswers[x])) {
                correct++; 
                answered++;
                preparedStatement = cn.prepareStatement("Update questions Set nsuccess=nsuccess+1 Where idquestion=?");
                preparedStatement.setInt(1, question.getIdquestion());
                preparedStatement.executeUpdate();
            }else if(solutions[x]!=Integer.parseInt(useranswers[x]) && Integer.parseInt(useranswers[x])!=0) {
                fail++; 
                answered++;
                preparedStatement = cn.prepareStatement("Update questions Set nfail=nfail+1 Where idquestion=?");
                preparedStatement.setInt(1, question.getIdquestion());
                preparedStatement.executeUpdate();
            }
            else blank++;
            
            preparedStatement=null;
            question=null;
        }
        
        preparedStatement = cn.prepareStatement("SELECT * FROM userstats WHERE idUser =?");
        preparedStatement.setInt(1, idUser);
        rs = preparedStatement.executeQuery();
        rs.last();
        preparedStatement=null;
        if(rs.getRow()>0){
            preparedStatement = cn.prepareStatement("Update userstats Set completeTest=completeTest+1, answered=answered+?, success=success+?, wrong=wrong+?, showedquestions=showedquestions+? Where idUser=?");
            preparedStatement.setInt(1, answered);
            preparedStatement.setInt(2, correct);
            preparedStatement.setInt(3, fail);
            preparedStatement.setInt(4, showedquestions);
            preparedStatement.setInt(5, idUser);
            preparedStatement.executeUpdate();
        }else{
            preparedStatement = cn.prepareStatement("insert into userstats values (?,?,?,?,?,?)");
            preparedStatement.setInt(1, idUser);
            preparedStatement.setInt(2, 1);
            preparedStatement.setInt(3, answered);
            preparedStatement.setInt(4, correct);
            preparedStatement.setInt(5, fail);
            preparedStatement.setInt(6, showedquestions);
            preparedStatement.executeUpdate();
        }
        rs=null;
        preparedStatement=null;
        
        return result;
    }
    
    public boolean addUser(User newuser) throws SQLException{
        boolean successful=false;
        
        String sql = "insert into users values (?,?,?,?,?)";
        PreparedStatement preparedStatement = cn.prepareStatement(sql);

        String user=newuser.getUsername();
        String password=newuser.getPassword();
        boolean isAdmin=newuser.isIsAdmin();
        
        Fecha today=new Fecha();
        java.sql.Date todaydatabase= new java.sql.Date(today.getDate().getTime());

        preparedStatement.setInt(1, 0);
        preparedStatement.setString(2, user);
        preparedStatement.setString(3, password);
        preparedStatement.setBoolean(4, isAdmin);
        preparedStatement.setDate(5, todaydatabase);
        preparedStatement.executeUpdate();
        preparedStatement = null;
        successful = true;
    
        return successful;
    }
    
    public List checkLogin(String user, String password) throws SQLException{
        List data=new ArrayList();
        boolean userexist=false, logincorrect=false;
        User userdata=null;
        PreparedStatement preparedStatement = cn.prepareStatement("SELECT * FROM users WHERE user =?");
        preparedStatement.setString(1, user);
        rs = preparedStatement.executeQuery();
        rs.last();
        if(rs.getRow()>0){
            userexist=true;
            preparedStatement=null;
            preparedStatement = cn.prepareStatement("SELECT * FROM users WHERE user =? AND password=?");
            preparedStatement.setString(1, user);
            preparedStatement.setString(2, password);
            rs = preparedStatement.executeQuery();
            rs.last();
            if(rs.getRow()>0) {
                logincorrect=true;
                rs.beforeFirst();
                rs.next();
                int dataiduser = rs.getInt("iduser");
                String datauser = rs.getString("user");
                boolean dataadmin = rs.getBoolean("admin");
                userdata=new User(dataiduser, datauser, "", dataadmin);
            }
        }
        data.add(userexist);
        data.add(logincorrect);
        data.add(userdata);
        rs=null;
        preparedStatement=null;
        
        return data;
    }
    
    public Stats getStats(int userid) throws SQLException{
        Stats userstats=null;
        
        PreparedStatement preparedStatement = cn.prepareStatement("SELECT * FROM userstats WHERE idUser =?");
        preparedStatement.setInt(1, userid);
        rs = preparedStatement.executeQuery();
        rs.last();
        if(rs.getRow()>0) {
            rs.beforeFirst();
            rs.next();
            int iduser=rs.getInt("idUser");
            int completeTest=rs.getInt("completeTest");
            int answered=rs.getInt("answered");
            int success=rs.getInt("success");
            int wrong=rs.getInt("wrong");
            int showedquestions=rs.getInt("showedquestions");
            
            userstats=new Stats(iduser, completeTest, answered, success, wrong, showedquestions);
        }
        rs=null;
        preparedStatement=null;
        return userstats;
    }
}
