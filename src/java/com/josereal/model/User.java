/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.josereal.model;

import java.util.Objects;

/**
 *
 * @author casa
 */
public class User {
    private int iduser;
    private String username;
    private String password;
    private boolean isAdmin;

    public User() {
    }

    public User(int iduser, String username, String password, Boolean isAdmin) {
        this.iduser = iduser;
        this.username = username;
        this.password = password;
        this.isAdmin = isAdmin;
    }

    public int getIduser() {
        return iduser;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public void setIduser(int iduser) {
        this.iduser = iduser;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public boolean isIsAdmin() {
        return isAdmin;
    }

    
    @Override
    public String toString() {
        return "User{" + "iduser=" + iduser + ", username=" + username + ", password=" + password + ", admin=" + isAdmin + '}';
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 43 * hash + this.iduser;
        hash = 43 * hash + Objects.hashCode(this.username);
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
        final User other = (User) obj;
        if (this.iduser != other.iduser) {
            return false;
        }
        if (!Objects.equals(this.username, other.username)) {
            return false;
        }
        return true;
    }


    
    
}
