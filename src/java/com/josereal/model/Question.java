/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.josereal.model;

/**
 *
 * @author casa
 */
public class Question {
    
    //ANSWERS WILL BE SAVE IN DB WITH THE JSON FORMAT!
    
    private int idquestion;
    private String question;
    private String answers;
    private String image;
    private int nshowed;
    private int nsuccess;
    private int nfail;

    public Question() {
    }

    public Question(int idquestion, String question, String answers, String image, int nshowed, int nsuccess, int nfail) {
        this.idquestion = idquestion;
        this.question = question;
        this.answers = answers;
        this.image = image;
        this.nshowed = nshowed;
        this.nsuccess = nsuccess;
        this.nfail = nfail;
    }

    public Question(String question, String answers, String image, int nshowed, int nsuccess, int fail) {
        this.question = question;
        this.answers = answers;
        this.image = image;
        this.nshowed = nshowed;
        this.nsuccess = nsuccess;
        this.nfail = nfail;
    }

    public int getIdquestion() {
        return idquestion;
    }

    public String getQuestion() {
        return question;
    }

    public String getAnswers() {
        return answers;
    }

    public String getImage() {
        return image;
    }

    public int getNshowed() {
        return nshowed;
    }

    public int getNsuccess() {
        return nsuccess;
    }
    
    public int getNfail() {
        return nfail;
    }

    public void setIdquestion(int idquestion) {
        this.idquestion = idquestion;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public void setAnswers(String answers) {
        this.answers = answers;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setNshowed(int nshowed) {
        this.nshowed = nshowed;
    }

    public void setNsuccess(int nsuccess) {
        this.nsuccess = nsuccess;
    }
    
    public void setNfail(int nfail) {
        this.nfail = nfail;
    }

    @Override
    public String toString() {
        return "Question{" + "idquestion=" + idquestion + ", question=" + question + ", answers=" + answers + ", image=" + image + ", nshowed=" + nshowed + ", nsuccess=" + nsuccess + '}';
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 83 * hash + this.idquestion;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Question other = (Question) obj;
        if (this.idquestion != other.idquestion) {
            return false;
        }
        return true;
    }
    
    
    
}
