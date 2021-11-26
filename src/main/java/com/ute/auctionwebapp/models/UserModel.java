package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.utills.DbUtills;
import org.sql2o.Connection;

import java.util.List;

public class UserModel {
    public static User findByUsername(String email) {
        final String query = "select * from users where email = :email";
        try (Connection con = DbUtills.getConnection()) {
            List<User> list = con.createQuery(query)
                    .addParameter("email", email)
                    .executeAndFetch(User.class);

            if (list.size() == 0) {
                return null;
            }

            return list.get(0);
        }
    }

    public static void add(User c) {
        String insertSql = "INSERT INTO users (name, email, password, request, dob, role, address) VALUES (:name,:email,:password,:request,:dob,:role,:address)";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("password", c.getPassword())
                    .addParameter("name", c.getName())
                    .addParameter("email", c.getEmail())
                    .addParameter("dob", c.getDob())
                    .addParameter("role",c.getRole())
                    .addParameter("request", c.getReQuest())
                    .addParameter("address", c.getAddress())
                    .executeUpdate();
        }
    }

    public static void resetPassword(String email, String password) {
        String insertSql = "UPDATE users SET password = :password WHERE email= :email";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("email", email)
                    .addParameter("password", password)
                    .executeUpdate();
        }
    }
}