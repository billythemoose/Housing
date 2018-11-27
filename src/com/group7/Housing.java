package com.group7;

import com.mysql.cj.jdbc.Driver;
import java.sql.*;
import java.io.*;
import java.util.ArrayList;

public class Housing {

    private static int UserID;
    private static BufferedReader Buff;

    public static void main(String[] args) {
        runProgram();
    }

    public static void runProgram() {
        System.out.println("****************************************************************************************");
        System.out.println("                        Welcome to the Housing System");
        System.out.println("****************************************************************************************");

        Buff = new BufferedReader(new InputStreamReader(System.in));
        Boolean go = true;
        while (go) {
            UserID = -1;
            System.out.println("                                Main Menu");
            System.out.println("                                    1. Resident Login");
            System.out.println("                                    2. Applicant Login");
            System.out.println("                                    3. Administrator Login");
            System.out.println("                                    4. Demographic Studies");
            System.out.println("                                    5. Quit");
            System.out.print("Type in your option: ");

            // System.out.println("                    5. List of female residents (per year) past 5 years");
            // System.out.println("                  6. List of married residents who study the same majors");


            try {
                int input = Integer.parseInt(Buff.readLine());
                System.out.println();
                switch(input) {
                    case 1: input = 1;
                        go = residentLogin();
                        break;
                    case 2: input = 2;
                        go = applicantLogin();
                        break;
                    case 3: input = 3;
                        go = adminLogin();
                        break;
                    case 4: input = 4;
                        go = demographicStudies();
                        break;
                    case 5: input = 5;
                        System.out.println("Exiting application...");
                        go = false;
                        break;
                    default:
                        System.out.println(String.format("Input %d is not a valid option", input));
                        break;
                }

                System.out.println();
            }
            catch (NumberFormatException e) {
                System.out.println("Input is invalid");
                System.out.println();
            }
            catch (IOException e) {
            }
        }

        if (Buff != null) {
            try {
                Buff.close();
            }
            catch (Exception e) {}
        }
    }


    //<editor-fold desc="User Logins">
    public static Boolean residentLogin() {
        try {
            System.out.print("Student ID: ");
            int input = Integer.parseInt(Buff.readLine());
            String query = "SELECT student_id FROM housing.resident WHERE student_id = " + input;
            executeLoginQuery(query, false);
        }
        catch (Exception e){
            System.out.println("Failed to read Student ID");
        }
        return true;
    }

    public static Boolean applicantLogin() {
        try {
            System.out.print("Student ID: ");
            int input = Integer.parseInt(Buff.readLine());
            String query = "SELECT student_id FROM housing.applicant WHERE student_id = " + input;
            Boolean result = executeLoginQuery(query, false);
            if (!result) {
                System.out.print("Would you like to start a new application? (Y/N)");
                String startNew = Buff.readLine();
                if (startNew == "Y" || startNew == "y") {

                }
            }
            else {

            }
        }
        catch (Exception e){
            System.out.println("Failed to read Application ID");
        }
        return true;
    }

    public static Boolean adminLogin() {
        try {
            System.out.print("Admin ID: ");
            int input = Integer.parseInt(Buff.readLine());
            String query = "SELECT admin_id FROM housing.admin WHERE admin_id = " + input;
            executeLoginQuery(query, true);
        }
        catch (Exception e){
            System.out.println("Failed to read Admin ID");
        }
        return true;
    }

    //</editor-fold>



    //<editor-fold desc="Demographic Information">
    public static Boolean demographicStudies() {
        Boolean go = true;
        while (go) {
            System.out.println("Demographic Information Selection:");
            try {
                System.out.println("    1. Female Student Resident History");
                System.out.println("    2. Married Resident Major Information");
                System.out.println("    3. Back");
                System.out.print("Type in your option: ");
                int input = Integer.parseInt(Buff.readLine());
                switch(input) {
                    case 1: input = 1;
                        females();
                        break;
                    case 2: input = 2;
                        married();
                        break;
                    case 3: input = 3;
                        go = false;
                        break;
                    default:
                        System.out.println(String.format("Input %d is not a valid option", input));
                        break;
                }
            }
            catch (Exception e) {
                System.out.println(e.toString());
            }

            System.out.println();
        }

        return true;
    }

    public static void females() {
        queries(4);
    }

    public static void married() {
        queries(5);
    }

    //</editor-fold>



    //<editor-fold desc="Database Execution">
    public static Boolean executeLoginQuery(String query, Boolean isAdmin ) {
        ResultSet result = null;
        String columnName;
        if (isAdmin) {
            columnName = "admin_id";
        }
        else {
            columnName = "student_id";
        }
        try {
            DriverManager.registerDriver(new Driver());
            String url = "jdbc:mysql://localhost:3306/housing?useSSL=false";
            Connection con = DriverManager.getConnection(url, "student", "password");
            Statement st = con.createStatement();
            result = st.executeQuery(query);
            result.next();
            String id = result.getString(columnName);
            UserID = Integer.parseInt(id);
            con.close();
            System.out.println("Logged in with " + columnName + " = " + UserID);
        }
        catch (Exception e) {
            System.out.println("Failed to log user in");
            return false;
        }

        return true;
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
                query = "Select * from room where room.occupancy < room. capacity AND"
                        + " (room_type = 'Two Bedroom Apartment' OR "
                        + "room_type = 'Four Bedroom Apartment' OR "
                        + "room_type = 'One Bedroom Suit' OR "
                        + "room_type = 'Two Bedroom Suit') ";
                //+ "order by building_id";
                testDB(query);
                result = true;
                break;
            case 3: option = 3;
                query = "";
                testDB(query);
                result = true;
                break;
            case 4: option = 4;
                //System.out.println("Press 1 to view the number of female residents (per year)");
                //System.out.println("Press 2 to view the list of married residents who study the same majors");

                query = "Select count(resident.student_id) as 'number_of_female_residents', YEAR(graduation_date) as 'Year'"
                        + "From housing.resident, housing.student "
                        + "Where housing.resident.student_id = housing.student.student_id AND housing.student.student_id in (SELECT student_id  "
                        + "FROM housing.student "
                        + "Where gender = 'Female' AND  "
                        + "YEAR(graduation_date) = 2018 OR "
                        + "YEAR(graduation_date) = 2017 OR "
                        + "YEAR(graduation_date) = 2016 OR "
                        + "YEAR(graduation_date) = 2015 OR "
                        + "YEAR(graduation_date) = 2014) "
                        + "GROUP BY YEAR(graduation_date);";
                testDB(query);
                result = true;
                break;
            case 5: option = 5;
                query = "select s1.student_id, a1.roommate_id, s1.major_department "
                        + "from student s1, student s2 , applicant a1, applicant a2 "
                        + "where s1.student_id = s2.student_id AND "
                        + "s1.major_department = s2.major_department AND "
                        + "s1.student_id = a1.student_id AND "
                        + "a1.student_id = a2.roommate_id AND "
                        + "a1.married = 1";
                testDB(query);
                result = true;
                break;
            case 6: option = 6;
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
            String url = "jdbc:mysql://localhost:3306/housing?useSSL=false";

            //String url = "jdbc:mysql://localhost:3306/housing?autoReconnect=true&useSSL=false";
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

    //</editor-fold>
}
