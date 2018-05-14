package com.josereal.controller;

import com.josereal.model.*;
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

public class QuestionsController {

    //Driver para poder establecer conexi�n para la bbdd
    private final static String drv = "com.mysql.jdbc.Driver";
    //Cadena de conexi�n
    private final static String db = "jdbc:mysql://localhost:3306/proyecto";
    private final static String user = "proyecto";
    private final static String pass = "proyecto";

    Connection cn; //Se importa la librer�a de java.sql
    PreparedStatement pst;
    ResultSetMetaData rsmd;

    public ResultSet rs;
    private ArrayList<Question> questions;

    public QuestionsController() {
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
        //El objeto preparedStatement solo lee y lo hace en una direccion
        rs = preparedStatement.executeQuery();
        while (rs.next()) {

            int idquestion = rs.getInt("idquestion");
            String tquestion = rs.getString("question");
            String answers = rs.getString("answers");
            String image = rs.getString("image");
            int nshowed = rs.getInt("nshowed");
            int nsuccess = rs.getInt("nsuccess");
            Question question = new Question(idquestion, tquestion, answers, image, nshowed, nsuccess);
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
        //El objeto preparedStatement solo lee y lo hace en una direccion
        rs = preparedStatement.executeQuery();
        Question getQuestion=new Question();
        while (rs.next()) {

            int idquestion = rs.getInt("idquestion");
            String tquestion = rs.getString("question");
            String answers = rs.getString("answers");
            String image = rs.getString("image");
            int nshowed = rs.getInt("nshowed");
            int nsuccess = rs.getInt("nsuccess");
            getQuestion = new Question(idquestion, tquestion, answers, image, nshowed, nsuccess);
        }
        rs = null;
        preparedStatement = null;

        return getQuestion;
    }
    
    public ArrayList<Question> getRandomTestBynumber(int numberofquestions) throws SQLException, ParseException {

        PreparedStatement preparedStatement = cn.prepareStatement("SELECT * FROM questions");
        //El objeto preparedStatement solo lee y lo hace en una direccion
        rs = preparedStatement.executeQuery();
        ArrayList<Question> getquestions=new ArrayList<>();
        ArrayList<Question> randomQuestions=new ArrayList<>();
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
                Question question = new Question(idquestion, tquestion, answers, image, nshowed, nsuccess);
                getquestions.add(question);

                question = null;
            }
            //REORDER QUESTIONS
            Collections.shuffle(getquestions);
            if(tam<numberofquestions) numberofquestions=tam;
            
            for(int x=0;x<numberofquestions;x++){
                randomQuestions.add(getquestions.get(x));
            }
        }
        rs = null;
        preparedStatement = null;

        return randomQuestions;
    }
    

    public boolean addQuestion(Question question) throws SQLException {

        boolean added = false;
        String sql = "insert into questions values (?,?,?,?,?,?)";
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

        int borrados = preparedStatement.executeUpdate();

        rs = null;
        preparedStatement = null;

        if (borrados > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean modifyQuestion(Question question) throws SQLException {

        String sql = "Update questions Set question=?, answers=?, image=?, nshowed=?, nsuccess=? Where idquestion=?";

        PreparedStatement preparedStatement = cn.prepareStatement(sql);
        preparedStatement.setString(1, question.getQuestion());
        preparedStatement.setString(2, question.getAnswers());
        preparedStatement.setString(3, question.getImage());
        preparedStatement.setInt(4, question.getNshowed());
        preparedStatement.setInt(5, question.getNsuccess());
        preparedStatement.setInt(6, question.getIdquestion());

        int afectadas = preparedStatement.executeUpdate();
        if (afectadas > 0) {
            return true;
        } else {
            return false;
        }
    }
}
