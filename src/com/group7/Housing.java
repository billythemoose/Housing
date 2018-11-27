package com.group7;

import com.mysql.cj.jdbc.Driver;
import java.sql.*;
import java.io.*;
import java.util.ArrayList;
import java.math.BigInteger;

public class Housing {

    // stores current user
    private static int UserID;

    // stores main buffered reader
    private static BufferedReader Buff;

    public static void main(String[] args) {
        runProgram();
    }

    // main handler for all housing actions
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
    // login for residents
    public static Boolean residentLogin() {
        try {
            System.out.print("Student ID: ");
            int input = Integer.parseInt(Buff.readLine());
            String query = "SELECT student_id FROM housing.resident WHERE student_id = " + input;
            executeLoginQuery(query, false);
            System.out.println();
            if (UserID != -1) {
                residentActions();
            }
            else {
                System.out.println("Failed to log in as resident");
            }
        }
        catch (Exception e){
            System.out.println("Failed to read Student ID");
        }
        return true;
    }

    // login for applicants
    // if login does not exist, prompts to create new application
    public static Boolean applicantLogin() {
        try {
            System.out.print("Student ID: ");
            int input = Integer.parseInt(Buff.readLine());
            String query = "SELECT student_id FROM housing.applicant WHERE student_id = " + input;
            Boolean result = executeLoginQuery(query, false);
            if (!result) {
                System.out.print("Would you like to start a new application? (Y/N): ");
                String startNew = Buff.readLine();
                if (startNew.equals("Y") || startNew.equals("y")) {
                    applicantCreateNew();
                }
            }
            else {
                applicantActions();
            }
        }
        catch (Exception e){
            System.out.println("Failed to read Application ID");
        }
        return true;
    }

    // login for administrators
    public static Boolean adminLogin() {
        try {
            System.out.print("Admin ID: ");
            int input = Integer.parseInt(Buff.readLine());
            String query = "SELECT admin_id FROM housing.admin WHERE admin_id = " + input;
            executeLoginQuery(query, true);
            System.out.println();
            if (UserID != -1) {
                adminActions();
            }
            else {
                System.out.println("Failed to log in as admin");
            }
        }
        catch (Exception e){
            System.out.println("Failed to read Admin ID");
        }
        return true;
    }

    //</editor-fold>



    //<editor-fold desc="User Actions>
    //<editor-fold desc="Admin Actions>
    // main container for administrator actions
    public static void adminActions() {
        Boolean go = true;
        while (go) {
            System.out.println("Administrator Actions:");
            try {
                System.out.println("    1. Manage Residents");
                System.out.println("    2. Manage Applicants");
                System.out.println("    3. Manage Maintenance Requests");
                System.out.println("    4. Administrative Reports");
                System.out.println("    5. Back");
                System.out.print("Type in your option: ");
                int input = Integer.parseInt(Buff.readLine());
                switch(input) {
                    case 1: input = 1;
                        adminManageResidents();
                        break;
                    case 2: input = 2;
                        adminManageApplicants();
                        break;
                    case 3: input = 3;
                        adminManageMaintenance();
                        break;
                    case 4: input = 4;
                        adminReports();
                        break;
                    case 5: input = 5;
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
    }

    // allows administrators to update resident information
    public static void adminManageResidents() {
        System.out.println();
        System.out.println("Manage Resident:");
        try {
            System.out.println("Resident Student ID: ");
            int input = Integer.parseInt(Buff.readLine());
            if (validateID(input, "student_id","housing.resident")) {
                Boolean go = true;
                while(go) {
                    try {
                        System.out.println("    1. Change Location");
                        System.out.println("    2. Adjust Rent");
                        System.out.println("    3. Back");
                        System.out.print("Type in your option: ");
                        int updateInput = Integer.parseInt(Buff.readLine());
                        switch (updateInput) {
                            case 1:
                                updateInput = 1;
                                System.out.print("New Building ID: ");
                                int newBuilding = Integer.parseInt(Buff.readLine());
                                System.out.print("New Room Number: ");
                                int newRoom = Integer.parseInt(Buff.readLine());
                                String queryLocation = "UPDATE housing.resident SET building_id = " + newBuilding
                                        + ", room_number= " + newRoom + " WHERE student_id = " + input;
                                String validateLocation = "SELECT * FROM housing.resident WHERE student_id = " + input;
                                testDBUpdate(queryLocation, validateLocation);
                                break;
                            case 2:
                                updateInput = 2;
                                System.out.print("New Outstanding Rent Amount: ");
                                int newRent = Integer.parseInt(Buff.readLine());
                                String queryRent = "UPDATE housing.resident SET outstanding_rent = " + newRent
                                        + " WHERE student_id = " + input;
                                String validateRent = "SELECT * FROM housing.resident WHERE student_id = " + input;
                                testDBUpdate(queryRent, validateRent);
                                break;
                            case 3:
                                updateInput = 3;
                                go = false;
                                break;
                            default:
                                System.out.println(String.format("Input %d is not a valid option", updateInput));
                                break;
                        }
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }
                }
            } else {
                System.out.println("Could not find Resident with ID " + input);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        System.out.println();
    }

    // allows administrators to update applicant information
    public static void adminManageApplicants() {
        System.out.println();
        System.out.println("Manage Applicant:");
        try {
            System.out.println("Applicant Student ID: ");
            int input = Integer.parseInt(Buff.readLine());
            if (validateID(input, "student_id", "housing.applicant")) {
                Boolean go = true;
                while (go) {
                    try {
                        System.out.println("    1. Check Application Status");
                        System.out.println("    2. Approve Application");
                        System.out.println("    3. Reject Application");
                        System.out.println("    4. Edit Application");
                        System.out.println("    5. Back");
                        System.out.print("Type in your option: ");
                        int updateInput = Integer.parseInt(Buff.readLine());
                        switch (updateInput) {
                            case 1:
                                updateInput = 1;
                                String queryStatus = "SELECT student_id, application_status FROM housing.applicant WHERE student_id = " + input;
                                testDB(queryStatus);
                                break;
                            case 2:
                                updateInput = 2;
                                String queryApprove = "UPDATE housing.applicant SET application_status = \"approved\""
                                        + " WHERE student_id = " + input;
                                String validateApprove = "SELECT * FROM housing.applicant WHERE student_id = " + input;
                                testDBUpdate(queryApprove, validateApprove);
                                break;
                            case 3:
                                updateInput = 3;
                                String queryReject = "UPDATE housing.applicant SET application_status = \"rejected\""
                                        + " WHERE student_id = " + input;
                                String validateReject = "SELECT * FROM housing.applicant WHERE student_id = " + input;
                                testDBUpdate(queryReject, validateReject);
                                break;
                            case 4:
                                updateInput = 4;
                                System.out.print("New Application Status: ");
                                String newStatus = Buff.readLine();
                                System.out.print("New Fee Amount: ");
                                int newFee = Integer.parseInt(Buff.readLine());
                                System.out.print("New Marriage Status: ");
                                String newMarriage = Buff.readLine();
                                System.out.print("New Roommate ID: ");
                                String newRoommate = Buff.readLine();
                                String queryLocation = "UPDATE housing.applicant SET"
                                        + " application_status = \"" + newStatus + "\""
                                        + ", fee = " + newFee
                                        + ", married = " + newMarriage
                                        + ", roommate_id = " + newRoommate
                                        + " WHERE student_id = " + input;
                                String validateLocation = "SELECT * FROM housing.applicant WHERE student_id = " + input;
                                testDBUpdate(queryLocation, validateLocation);
                                break;
                            case 5:
                                updateInput = 5;
                                go = false;
                                break;
                            default:
                                System.out.println(String.format("Input %d is not a valid option", updateInput));
                                break;
                        }
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }
                }
            } else {
                System.out.println("Could not find Applicant with ID " + input);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        System.out.println();
    }

    // allows administrators to update maintenance requests
    public static void adminManageMaintenance() {
        try {
            System.out.println();
            System.out.print("Maintenance Request ID: ");
            String req = Buff.readLine();
            int reqID = Integer.parseInt(req);
            if (validateID(reqID, "request_id", "housing.maintenance_request")) {
                System.out.print("New Student ID: ");
                String stu = Buff.readLine();
                int student_id = Integer.parseInt(stu);
                System.out.print("New Employee ID: ");
                String emp = Buff.readLine();
                int employee_id = Integer.parseInt(emp);
                System.out.print("New Building ID: ");
                String build = Buff.readLine();
                int building_id = Integer.parseInt(build);
                System.out.print("New Room Number: ");
                String room = Buff.readLine();
                int room_number = Integer.parseInt(room);
                System.out.print("New Description: ");
                String description = Buff.readLine();
                System.out.print("New Date Started (YYYY-MM-DD): ");
                String dateStarted = Buff.readLine();
                System.out.print("New Date Fixed (YYYY-MM-DD): ");
                String dateFixed = Buff.readLine();
                String updateQuery = "UPDATE housing.maintenance_request SET student_id = " + student_id
                        + ", employee_id = " + employee_id + ", building_id = " + building_id
                        + ", room_number = " + room_number + ", description = \"" + description + "\""
                        + ", date_started = \"" + dateStarted + "\", date_fixed = \"" + dateFixed + "\""
                        + " WHERE request_id = " + reqID;
                String validateQuery = "SELECT * FROM housing.maintenance_request WHERE request_id = " + reqID;
                testDBUpdate(updateQuery, validateQuery);
            }
        }
        catch (Exception e) {
            System.out.println(e.toString());
        }
    }

    // main container for all administrator reports
    public static void adminReports() {
        Boolean go = true;
        while (go) {
            System.out.println("Reports:");
            try {
                System.out.println("    1. Building Occupancy");
                System.out.println("    2. Open Application Count");
                System.out.println("    3. Open Maintenance Request Count");
                System.out.println("    4. Back");
                System.out.print("Type in your option: ");
                int input = Integer.parseInt(Buff.readLine());
                switch(input) {
                    case 1: input = 1;
                        String buildQuery = "SELECT building_id, Count(student_id) FROM housing.resident GROUP BY building_id";
                        testDB(buildQuery);
                        break;
                    case 2: input = 2;
                        String appQuery = "SELECT COUNT(student_id) FROM housing.applicant WHERE application_status NOT LIKE 'Accepted'" +
                                " AND application_status NOT LIKE 'Rejected'";
                        testDB(appQuery);
                        break;
                    case 3: input = 3;
                        String reqQuery = "SELECT COUNT(request_id) FROM housing.maintenance_request WHERE date_fixed != NULL";
                        testDB(reqQuery);
                        break;
                    case 4: input = 4;
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
    }

    //</editor-fold>

    //<editor-fold desc="Applicant Actions>
    // creates a new applicant
    public static void applicantCreateNew() {
        BigInteger sID, fee;
        String appDate;
        String query = "INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES (";
        boolean married;
        try {
            System.out.print("Student ID: ");
            sID = new BigInteger(Buff.readLine());
            System.out.print("Fee: ");
            fee = new BigInteger(Buff.readLine());
            System.out.print("Enter Date (YYYY-MM-DD): ");
            appDate = Buff.readLine();
            System.out.print("Married (TRUE or FALSE): ");
            married = Boolean.valueOf(Buff.readLine());
            query = query + sID + "," + "'In Progress'" + ", '" + appDate + "'," + fee + "," + married + ");" ;
            String validate = "SELECT * FROM housing.applicant WHERE student_id = " + sID;
            testDBUpdate(query, validate);
            createRoomPref(sID);
        } catch (IOException e) {
            e.printStackTrace();
        }
        catch (Exception e) {

        }
    }

    // main container for all current applicant actions
    public static void applicantActions() {
        Boolean go = true;
        while (go) {
            System.out.println("Applicant Actions:");
            try {
                System.out.println("    1. Check Application Status");
                System.out.println("    2. Edit Application");
                System.out.println("    3. Delete Application");
                System.out.println("    4. Back");
                System.out.print("Type in your option: ");
                int inputApp = Integer.parseInt(Buff.readLine());
                switch(inputApp) {
                    case 1: inputApp = 1;
                        String appStatus = "SELECT application_status FROM housing.applicant WHERE student_id = " + UserID;
                        testDB(appStatus);
                        break;
                    case 2: inputApp = 2;
                        System.out.println();
                        System.out.println("Information to Update: ");
                        System.out.print("Marriage Status: ");
                        Boolean married;
                        married = Boolean.valueOf(Buff.readLine());
                        System.out.print("New Roommate ID: ");
                        String roommate = Buff.readLine();
                        int roommateID = Integer.parseInt(roommate);
                        String appUpdate = "UPDATE housing.applicant SET married = " + married + ", roommate_id = " + roommateID
                                + " WHERE student_id = " + UserID;
                        String appValidate = "SELECT * FROM housing.applicant WHERE student_id = " + UserID;
                        testDBUpdate(appUpdate, appValidate);
                        break;
                    case 3: inputApp = 3;
                        String appDelete = "DELETE FROM housing.applicant WHERE student_id = " + UserID;
                        String appDeleteValidate = "SELECT * FROM housing.applicant WHERE student_id = " + UserID;
                        testDBUpdate(appDelete, appDeleteValidate);
                        go = false;
                        break;
                    case 4: inputApp = 4;
                        go = false;
                        break;
                    default:
                        System.out.println(String.format("Input %d is not a valid option", inputApp));
                        break;
                }
            }
            catch (Exception e) {
                System.out.println(e.toString());
            }

            System.out.println();
        }
    }
    //</editor-fold>

    //<editor-fold desc="Resident Actions>
    //  main container for all resident actions
    public static void residentActions() {
        Boolean go = true;
        while (go) {
            System.out.println("Resident Actions:");
            try {
                System.out.println("    1. Create New Maintenance Request");
                System.out.println("    2. Check Open Maintenance Requests");
                System.out.println("    3. Adjust Outstanding Rent");
                System.out.println("    4. Back");
                System.out.print("Type in your option: ");
                int inputApp = Integer.parseInt(Buff.readLine());
                switch(inputApp) {
                    case 1: inputApp = 1;
                        residentCreateMaintenance();
                        break;
                    case 2: inputApp = 2;
                        residentCheckMaintenance();
                        break;
                    case 3: inputApp = 3;
                        residentRent();
                        break;
                    case 4: inputApp = 4;
                        go = false;
                        break;
                    default:
                        System.out.println(String.format("Input %d is not a valid option", inputApp));
                        break;
                }
            }
            catch (Exception e) {
                System.out.println(e.toString());
            }

            System.out.println();
        }
    }

    // allows residents to create new maintenance requests
    public static void residentCreateMaintenance() {
        try {
            System.out.println();
            System.out.print("New Maintenance Request: ");
            int student_id = UserID;
            System.out.print("Building ID: ");
            String build = Buff.readLine();
            int building_id = Integer.parseInt(build);
            System.out.print("Room Number: ");
            String room = Buff.readLine();
            int room_number = Integer.parseInt(room);
            System.out.print("Description: ");
            String description = Buff.readLine();
            String updateQuery = "UPDATE housing.maintenance_request SET student_id = " + student_id
                    + ", building_id = " + building_id  + ", room_number = " + room_number
                    + ", description = \"" + description + "\"";
            String validateQuery = "SELECT * FROM housing.maintenance_request WHERE student_id = " + UserID;
            testDBUpdate(updateQuery, validateQuery);
        }
        catch (Exception e) {
            System.out.println(e.toString());
        }
    }

    // allows residents to check all open requests under their ID
    public static void residentCheckMaintenance() {
        // pull all maintenance requests that are open with current user ID
        System.out.println("Currently Open Maintenance Requests: ");
        String query = "SELECT * FROM housing.maintenance_request WHERE student_id = " + UserID;
        testDB(query);
    }

    // allows residents to update or "pay" outstanding rent
    public static void residentRent() {
        // change the value of outstanding rent
        System.out.println("Current Rent Value: ");
        String currentRent = "SELECT outstanding_rent FROM housing.resident WHERE student_id = " + UserID;
        testDB(currentRent);
        try {
            System.out.print("Updated Rent Value: ");
            String build = Buff.readLine();
            int newRent = Integer.parseInt(build);
            String updateRent = "UPDATE housing.resident SET outstanding_rent = " + newRent + " WHERE student_id = " + UserID;
            testDBUpdate(updateRent, currentRent);
        }
        catch (Exception e) {
            System.out.println(e.toString());
        }
    }

    //<editor-fold>
    //</editor-fold>



    //<editor-fold desc="Demographic Information">
    // main container for all demographic studies
    public static Boolean demographicStudies() {
        Boolean go = true;
        while (go) {
            System.out.println("Demographic Information Selection:");
            try {
                System.out.println("    1. Female Student Resident History");
                System.out.println("    2. Married Resident Major Information");
                System.out.println("    3. Occupancy Information");
                System.out.println("    4. Back");
                System.out.print("Type in your option: ");
                int input = Integer.parseInt(Buff.readLine());
                switch(input) {
                    case 1: input = 1;
                        queries(4);
                        break;
                    case 2: input = 2;
                        queries(5);
                        break;
                    case 3: input = 3;
                        queries(3);
                        break;
                    case 4: input = 4;
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

    //</editor-fold>



    //<editor-fold desc="Database Execution">
    // test to see if supplied UserID can log in as correct user type
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

    // validates if a given ID exists in a given table
    public static boolean validateID(int validationID, String columnName, String tableName) {
        ResultSet result = null;
        try {
            DriverManager.registerDriver(new Driver());
            String url = "jdbc:mysql://localhost:3306/housing?useSSL=false";
            Connection con = DriverManager.getConnection(url, "student", "password");
            Statement st = con.createStatement();
            result = st.executeQuery("SELECT * FROM " + tableName + " WHERE " + columnName + " = " + validationID);
            //
            // result.next();
            // String id = result.getString("student_id");
            // int sid = Integer.parseInt(id);

            ResultSetMetaData meta = result.getMetaData();
            int columns = meta.getColumnCount();
            ArrayList<String> columnNames = new ArrayList<String>();
            for (int i = 1; i <= columns; i++) {
                columnNames.add(meta.getColumnName(i));
            }

            while (result.next()) {

                for (String s : columnNames) {
                    String output = s + ": ";
                    output += result.getString(s) + " ";
                    System.out.println(output);
                }
            }

            System.out.println();
            con.close();
            return true;
        }
        catch (Exception e) {
            System.out.println("Failed to log user in");
            return false;
        }
    }

    // adds room preferences when creating new applicants
    public static void createRoomPref(BigInteger sid) throws SQLException {
        String desRoom;
        System.out.println();
        System.out.println("Available Room Types:");
        testDB("SELECT DISTINCT room_type FROM room;");
        BufferedReader buff = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Select Desired Room Type: ");
        try {
            desRoom = buff.readLine();

            String lonngq = "SELECT application_id FROM housing.applicant WHERE student_id = " + sid;
            String applicationString = testDBString(lonngq, "application_id");
            int applicationID = Integer.parseInt(applicationString);
            if (applicationID > -1) {
                String queryRoom = "INSERT INTO preferred_room (application_id, room_type_1) VALUES (" + applicationID + ", \"" + desRoom + "\")";
                String validationQuery = "SELECT * FROM preferred_room WHERE application_id = " + applicationID;
                testDBUpdate(queryRoom, validationQuery);
            }
            // ResultSet set = testDBString("SELECT application_id FROM applicant WHERE applicant.student_id = '" + sid + "'");
        } catch (IOException e) {
            e.printStackTrace();
        }
        catch (Exception e) {
            System.out.println(e.toString());
        }
    }

    // execute a single query and check if a value was found using the column name
    public static String testDBString(String query, String resultColumnName) {
        String resultString = "-1";
        try {
            DriverManager.registerDriver(new Driver());
            String url = "jdbc:mysql://localhost:3306/housing?autoReconnect=true&useSSL=false";
            Connection con = DriverManager.getConnection(url, "student", "password");
            Statement st = con.createStatement();
            ResultSet result = st.executeQuery(query);
            result.next();
            resultString = result.getString(resultColumnName);
            con.close();
            return resultString;
        }
        catch (Exception e) {
            System.out.println(e.toString());
        }
        return resultString;
    }

    //  main container for stored queries
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
                query = "Select * from housing.room where room.occupancy < room. capacity AND"
                + " (room_type = 'Two Bedroom Apartment' OR room_type = 'Four Bedroom Apartment' OR"
                + " room_type = 'One Bedroom Suit' or room_type = 'Two Bedroom Suit') order by address";
                testDB(query);
                result = true;
                break;
            case 4: option = 4;
                //System.out.println("Press 1 to view the number of female residents (per year)");
                //System.out.println("Press 2 to view the list of married residents who study the same majors");

                query = "Select count(student.student_id) as 'number_of_female_residents', YEAR(graduation_date) as 'Year'"
                    + " From housing.student Where housing.student.student_id in (SELECT student_id FROM housing.student"
                    + " Where gender = 'Female' AND YEAR(graduation_date) = 2018 OR YEAR(graduation_date) = 2017 OR"
                    + " YEAR(graduation_date) = 2016 OR YEAR(graduation_date) = 2015 OR YEAR(graduation_date) = 2014)"
                    + " group by YEAR(graduation_date)";
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

    // executes an update query then validates the information was changed
    public static void testDBUpdate(String update, String validation) {
        try {
            DriverManager.registerDriver(new Driver());
            String url = "jdbc:mysql://localhost:3306/housing?useSSL=false";

            //String url = "jdbc:mysql://localhost:3306/housing?autoReconnect=true&useSSL=false";
            Connection con = DriverManager.getConnection(url, "student", "password");
            Statement st = con.createStatement();
            int resultRowChange = st.executeUpdate(update);
            ResultSet result = st.executeQuery(validation);

            ResultSetMetaData meta = result.getMetaData();
            int columns = meta.getColumnCount();
            ArrayList<String> columnNames = new ArrayList<String>();
            for (int i = 1; i <= columns; i++) {
                columnNames.add(meta.getColumnName(i));
            }

            System.out.println("Results: ");
            while (result.next()) {
                for (String s : columnNames) {
                    String output = s + ": ";
                    output += result.getString(s) + " ";
                    System.out.println(output);
                }
            }

            System.out.println();
        }
        catch (Exception e) {
            System.out.println(e.toString());
        }

    }

    // executes a single query and prints all columns and results
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
