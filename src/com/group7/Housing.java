package com.group7;

import com.mysql.cj.jdbc.Driver;
import javafx.util.converter.BigIntegerStringConverter;

import java.math.BigInteger;
import java.sql.*;
import java.io.*;
import java.util.ArrayList;
import java.lang.Boolean;

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
            catch (NumberFormatException | SQLException e) {
                System.out.println("Input is invalid");
                System.out.println();
            }
            catch (IOException e) {
            }
        }
    }

    public static Boolean queries(int option) throws SQLException {
        String query = "";
        Boolean result = false;
        switch(option) {
            case 1: option = 1;
                query = "SELECT * FROM housing.student";
                testDB(query);
                result = true;
                break;
            case 2: option = 2; // Horrendous I know, I'm sorry Micheal
                testDB("SELECT DISTINCT room_type FROM room;");
                BufferedReader buff = new BufferedReader(new InputStreamReader(System.in));
                BigInteger sID, fee;
                String appDate;
                query = "INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES (";
                boolean married;
                try {
                    System.out.print("Student ID: ");
                    sID = new BigInteger(buff.readLine());
//          System.out.println(input);
                    System.out.print("Fee: ");
                    fee = new BigInteger(buff.readLine());
                    System.out.print("Enter Date (YYYY-MM-DD): ");
                    appDate = buff.readLine();
                    System.out.print("Married (True or False): ");
                    married = Boolean.valueOf(buff.readLine());
                    query = query + sID + "," + "'In Progress'" + ", '" + appDate + "'," + fee + "," + married + ");" ;
                    testDBUpdate(query);
                    createRoomPref(sID);
                } catch (IOException e) {
                    e.printStackTrace();
                }

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

    public static void createRoomPref(BigInteger sid) throws SQLException {
        String desRoom;
        String queryRoom = "INSERT INTO preferred_room (room_type_1) VALUES (";
        BufferedReader buff = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Select Desired Room Type: ");
        try {
            desRoom = buff.readLine();
            queryRoom += desRoom + ");";
            ResultSet set = testDB("SELECT application_id FROM applicant WHERE applicant.student_id = '" +
                    sid + "';);");
            String id = set.getString("application_id");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void testDBUpdate(String query){
        try {
            DriverManager.registerDriver(new Driver());
            String url = "jdbc:mysql://localhost:3306/housing?autoReconnect=true&useSSL=false";
            Connection con = DriverManager.getConnection(url, "student", "password");
            Statement st = con.createStatement();
            st.executeUpdate(query);
            con.close();
        }
        catch (Exception e) {
            System.out.println(e.toString());
        }
    }

    public static ResultSet testDB(String query) {

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
            return result;
        }
        catch (Exception e) {
            System.out.println(e.toString());
        }
        return null;
    }
}
