package com.group7;

import com.mysql.cj.jdbc.Driver;
import java.sql.*;
import java.io.*;
import java.util.ArrayList;

public class Housing {

    public static void main(String[] args) {
        runProgram();
    }

    public static void runProgram() {
        System.out.println("****************************************************************************************");
        System.out.println("                              Welcome to the Housing System");
        System.out.println("                                         ************");
        System.out.println("****************************************************************************************");

        BufferedReader buff = new BufferedReader(new InputStreamReader(System.in));
        Boolean go = true;
        while (go) {
            System.out.println("                                  1. Resident Login");
            System.out.println("                           2. Applicant Registration/Apply ");
            System.out.println("                                      3. Admin");
            System.out.println("                                      4. Quit");
            System.out.print("Type in your option: ");

            try {
                int input = Integer.parseInt(buff.readLine());
                go = queries(input);
                System.out.println();
            }
            catch (NumberFormatException e) {
                System.out.println("Input is invalid");
                System.out.println();
            }
            catch (IOException e) {
            }
        }
    }

    public static Boolean queries(int option) {
        String query = "";
        Boolean result = false;
        switch(option) {
            case 1: option = 1;
                query = "SELECT * FROM housing.student";
                testDB(query);
                result = true;
                break;
            case 2: option = 2;
                query = "";
                testDB(query);
                result = true;
                break;
            case 3: option = 3;
                query = "";
                testDB(query);
                result = true;
                break;
            case 4: option = 4;
                break;
            default:
                System.out.println(String.format("Input %d is not a valid option", option));
                result = true;
                break;
        }

        return result;
    }


    public static void testDB(String query) {

        try {
            DriverManager.registerDriver(new Driver());
            String url = "jdbc:mysql://localhost:3306/housing?autoReconnect=true&useSSL=false";
            Connection con = DriverManager.getConnection(url, "student", "password");
            Statement st = con.createStatement();
            ResultSet result = st.executeQuery(query);
            ResultSetMetaData meta = result.getMetaData();
            int columns = meta.getColumnCount();
            ArrayList<String> columnNames = new ArrayList<String>();
            for (int i = 1; i <= columns; i++) {
                columnNames.add(meta.getColumnName(i));
            }

            String header = "";
            for (String cname : columnNames) {
                header += cname + " ";
            }

            System.out.println();
            System.out.println(header);

            int outputCount = 0;
            while (result.next() && outputCount < 5) {
                String output = "";
                outputCount++;
                for (String s : columnNames) {
                    output += result.getString(s) + " ";
                }

                System.out.println(output);
            }
            con.close();
        }
        catch (Exception e) {
            System.out.println(e.toString());
        }

    }
}
