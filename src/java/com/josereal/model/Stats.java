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
public class Stats {
    private int idUser;
    private int completeTests;
    private int answered;
    private int success;
    private int wrong;
    private int showedquestions;

    public Stats() {
    }

    public Stats(int idUser, int completeTests, int answered, int success, int wrong, int showedquestions) {
        this.idUser = idUser;
        this.completeTests = completeTests;
        this.answered = answered;
        this.success = success;
        this.wrong = wrong;
        this.showedquestions = showedquestions;
    }

    public int getIdUser() {
        return idUser;
    }

    public int getCompleteTests() {
        return completeTests;
    }

    public int getAnswered() {
        return answered;
    }

    public int getSuccess() {
        return success;
    }

    public int getWrong() {
        return wrong;
    }
    
    public int getShowedquestions(){
        return showedquestions;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public void setCompleteTests(int completeTests) {
        this.completeTests = completeTests;
    }

    public void setAnswered(int answered) {
        this.answered = answered;
    }

    public void setSuccess(int success) {
        this.success = success;
    }

    public void setWrong(int wrong) {
        this.wrong = wrong;
    }
    
    public void setShowedquestions(int showedquestions){
        this.showedquestions = showedquestions;
    }

    @Override
    public String toString() {
        return "Stats{" + "idUser=" + idUser + ", completeTests=" + completeTests + ", answered=" + answered + ", success=" + success + ", wrong=" + wrong + '}';
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 73 * hash + this.idUser;
        hash = 73 * hash + this.completeTests;
        hash = 73 * hash + this.answered;
        hash = 73 * hash + this.success;
        hash = 73 * hash + this.wrong;
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
        final Stats other = (Stats) obj;
        if (this.idUser != other.idUser) {
            return false;
        }
        if (this.completeTests != other.completeTests) {
            return false;
        }
        if (this.answered != other.answered) {
            return false;
        }
        if (this.success != other.success) {
            return false;
        }
        if (this.wrong != other.wrong) {
            return false;
        }
        return true;
    }
    
    
    
}
