-- drop database housing;

-- Create new database
CREATE DATABASE housing;

-- drop table housing.student;
-- create student 
CREATE TABLE housing.student (
	student_id bigint(10) NOT NULL PRIMARY KEY,
    ssn int(9) NOT NULL,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    gender varchar(50) NOT NULL,
    marital_status bool,
    address varchar(255) NOT NULL,
    phone_number bigint(11) NOT NULL,
	undergraduate_level varchar(10) NOT NULL,
    major_college varchar(100),
    major_department varchar(100),
    graduation_date date
);

-- drop table housing.employee;
-- create employee 
CREATE TABLE housing.employee (
	employee_id bigint(10) NOT NULL PRIMARY KEY,
    ssn int(9) NOT NULL,
    first_name varchar(100),
    last_name varchar(100),
    address varchar(255),
    phone bigint(11)
);

-- create admin 
CREATE TABLE housing.admin (
	admin_id bigint(10) NOT NULL PRIMARY KEY,
    FOREIGN KEY (admin_ID) REFERENCES housing.employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- create building
CREATE TABLE housing.building (
	building_id int(2) NOT NULL PRIMARY KEY,
    building_name varchar(50)
);

-- create room 
CREATE TABLE housing.room (
	room_number int(5) NOT NULL,
    building_id int(2) NOT NULL,
    address varchar(255) NOT NULL,
    bedroom_count int(2) NOT NULL,
    bed_size varchar(50) NOT NULL,
    capacity int(2) NOT NULL,
    occupancy int(2) NOT NULL,
    room_type varchar(50) NOT NULL,
    marriage bool,
    married_resident bool,
    cost int(5) NOT NULL,
    INDEX(room_type),
    PRIMARY KEY (room_number, building_id),
    FOREIGN KEY (building_id) REFERENCES housing.building(building_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- drop table housing.applicant
-- create applicant 
CREATE TABLE housing.applicant (
	application_id bigint(10) NOT NULL PRIMARY KEY auto_increment,
    student_id bigint(10) NOT NULL,
    application_status varchar(50) NOT NULL,
    submission_date date,
    fee bigint(10), 
    married bool,
    roommate_id bigint(10),
    FOREIGN KEY (student_id) REFERENCES housing.student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (roommate_id) REFERENCES housing.student(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE housing.applicant auto_increment = 1000000000;

-- create preferred building
CREATE TABLE housing.preferred_building (
	application_id bigint(10) NOT NULL PRIMARY KEY,
    building_number_1 int(2),
    building_number_2 int(2),
    building_number_3 int(2),
    FOREIGN KEY (application_id) REFERENCES housing.applicant(application_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (building_number_1) REFERENCES housing.building(building_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (building_number_2) REFERENCES housing.building(building_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (building_number_3) REFERENCES housing.building(building_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- create preferred room 
CREATE TABLE housing.preferred_room (
	application_id bigint(10) NOT NULL PRIMARY KEY,
    room_type_1 varchar(50),
    room_type_2 varchar(50),
    room_type_3 varchar(50),
    FOREIGN KEY (application_id) REFERENCES housing.applicant(application_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (room_type_1) REFERENCES housing.room(room_type) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (room_type_2) REFERENCES housing.room(room_type) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (room_type_3) REFERENCES housing.room(room_type) ON DELETE CASCADE ON UPDATE CASCADE
);
 

-- create resident
CREATE TABLE housing.resident (
	student_id bigint(10) NOT NULL PRIMARY KEY, 
    building_id int(2) NOT NULL,
    room_number int(5) NOT NULL,
    outstanding_rent bigint(10),
    FOREIGN KEY (student_id) REFERENCES housing.student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (building_id) REFERENCES housing.building(building_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (room_number) REFERENCES housing.room(room_number) ON DELETE CASCADE ON UPDATE CASCADE
);
 
-- create room residents
CREATE TABLE housing.room_residents (
	room_number int(5) NOT NULL,
    building_id int(2) NOT NULL,
    resident_1 bigint(10) NOT NULL,
    resident_2 bigint(10),
    resident_3 bigint(10),
    resident_4 bigint(10),
    PRIMARY KEY (room_number, building_id),
    FOREIGN KEY (room_number) REFERENCES housing.room(room_number) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (building_id) REFERENCES housing.building(building_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (resident_1) REFERENCES housing.student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (resident_2) REFERENCES housing.student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (resident_3) REFERENCES housing.student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (resident_4) REFERENCES housing.student(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- create maintenance request
CREATE TABLE housing.maintenance_request (
	request_id bigint(10) NOT NULL PRIMARY KEY,
    student_id bigint(10) NOT NULL,
    employee_id bigint(10) NOT NULL,
    building_id int(2) NOT NULL,
    room_number int(5) NOT NULL,
    description varchar(255) NOT NULL,
    date_submitted date,
    date_started date,
    date_fixed date,
    FOREIGN KEY (student_id) REFERENCES housing.student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES housing.employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (building_id) REFERENCES housing.building(building_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (room_number) REFERENCES housing.room(room_number) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Employee Data
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (2103533459,637804660,"Olga","Frances","747-1704 Aliquam Ave",18727528485);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3987609918,405706746,"Keaton","Sebastian","3372 At St.",19233387480);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9640642418,969894705,"Sybill","Jessica","P.O. Box 377, 587 Vestibulum Road",10904016080);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3097424912,760145754,"Yuri","Shellie","Ap #129-2784 Magna. Street",13937518442);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1660286136,516528613,"Barclay","Thaddeus","386-5805 Non Street",19352118000);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1227916960,699717585,"Keely","Paul","Ap #919-8221 Erat. Rd.",11433274997);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5380168829,598565355,"Xander","Brenda","Ap #200-877 Porta Ave",10837658513);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4144555502,688603529,"Dane","Nissim","P.O. Box 289, 7290 Elementum St.",19947228054);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1525698151,119306393,"Velma","Ray","P.O. Box 325, 6433 Vehicula Rd.",13170338845);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4502700465,257431524,"Carissa","Elmo","Ap #416-5317 Velit Avenue",12723185396);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3447513110,595038666,"Geraldine","Jordan","3239 Fusce St.",19535980829);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1513734058,438778193,"Kay","Bevis","P.O. Box 736, 4173 Ante Avenue",11317947786);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1219042418,403695700,"Lars","Yoko","P.O. Box 812, 3523 Congue. Rd.",17903152690);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (2266946407,846254823,"Coby","Colin","518-4431 Vitae Street",15143546001);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (2003439630,711326242,"Rhoda","Hop","P.O. Box 156, 1379 Quis, St.",15385973090);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (8622479656,175153758,"Branden","Malcolm","P.O. Box 720, 2255 Enim, Street",18908903663);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9609025652,385516289,"Jarrod","Erin","Ap #577-832 Tincidunt, Av.",18954138560);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7847415606,987132353,"Lane","Madison","P.O. Box 106, 6757 Tempor Street",13895472809);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3450168175,618940750,"Matthew","Finn","983-5646 Magnis Av.",12885704636);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (6515774887,358778278,"Stacey","Donovan","P.O. Box 943, 4584 Tincidunt Rd.",10076757930);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7987930656,204558795,"Dustin","Ann","Ap #220-9184 Amet St.",16105748717);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7174363675,123409732,"Halla","Casey","745-8917 Auctor St.",19051468996);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1768402105,164491391,"Ria","Lacy","P.O. Box 386, 1329 Felis. Rd.",13667608601);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4982373717,958951904,"Stephen","Travis","365-6463 Lectus Rd.",17039949460);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (2186343905,362816496,"Winter","Kessie","385-9930 Aliquam, Street",14970363308);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3352628202,821300766,"Carlos","Rylee","P.O. Box 464, 8079 Nam Ave",14877644642);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (6320215443,771292303,"Carly","Zena","491-9111 Ullamcorper, Road",15021116896);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5102115817,934199809,"Harding","Carlos","P.O. Box 775, 585 Nunc Rd.",12547299438);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1230425462,985212439,"Reuben","Mary","3427 Nulla Av.",15463401400);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9453196827,161469887,"Talon","Melinda","7577 Tempus St.",16271116076);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4659328212,386939186,"Cedric","Bianca","8399 Dui. Rd.",18190846783);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9784416813,742218729,"Liberty","Jolie","P.O. Box 675, 4668 Et Rd.",12388860285);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (2829625813,206382790,"Jameson","Galvin","7695 Dictum Street",15800694148);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3478242923,796019956,"Joelle","Alyssa","5073 Non Road",16249077757);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4186524537,831701024,"Steel","Hollee","205-6696 Aliquam Ave",10265334602);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (6452750171,166580838,"Roanna","Nadine","630-1096 Feugiat Street",17430633609);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4406623344,444721843,"Amy","Linus","858-1855 Dolor, Rd.",10308160679);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7236957549,925405976,"Brenda","Adena","6850 Convallis Rd.",10946666784);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1920714839,132039327,"Aristotle","Caesar","4167 Nec Rd.",18185003232);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7942145285,962357485,"Merrill","Lester","8949 Scelerisque Street",11458952301);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1317495323,766743143,"Kaye","Aidan","7769 A, Ave",10115100205);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1752391609,399992664,"Giacomo","Audrey","3904 Non Av.",17364609641);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5130639345,158755922,"Fitzgerald","Indira","6099 Ipsum. St.",11053031305);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3491485869,521777527,"Amos","Sandra","Ap #683-6405 Vestibulum Avenue",17031165636);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1197468921,609217999,"Abel","Leilani","P.O. Box 882, 3110 Orci Rd.",18658917443);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5802448566,216856933,"Sydnee","Zephr","P.O. Box 531, 212 Nec, Ave",16363848275);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1491106251,132725567,"Allegra","Orlando","308-7421 Non, Street",19481374528);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5691376334,155558720,"Meredith","Noble","P.O. Box 803, 7623 Lorem. Rd.",11379075194);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9514146025,715730481,"Blaine","Carter","4426 Ipsum St.",15765214711);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (6928907214,695905018,"Ginger","Duncan","3262 Tincidunt Rd.",13634333098);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (8769669890,491699234,"TaShya","Gillian","210-6625 Morbi Street",14096708181);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1553540751,120325072,"Jerry","Solomon","7579 Id, Ave",10461483225);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7877495695,353236005,"Aileen","Byron","878-6539 Hendrerit. Street",18974472093);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3322138493,529278337,"Brent","Giselle","Ap #281-6539 Non, Ave",15783849726);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3554204374,465667703,"Reed","Lael","Ap #488-4810 Fames Rd.",18561305468);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1018777923,500495579,"Wallace","Isabella","P.O. Box 666, 751 Adipiscing Road",19502013735);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9229017358,977164327,"Vernon","Jared","P.O. Box 499, 3788 Mi Road",11838598833);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (6545915540,703420863,"Samantha","Mari","P.O. Box 338, 6507 Diam Street",15975192738);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4117261116,356519835,"Todd","Slade","Ap #303-956 Natoque Rd.",13241236149);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3357670667,385374685,"Cleo","Lois","5839 A, Ave",19048741841);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (2216772841,915623478,"Iona","Ulla","Ap #982-5220 Nam Rd.",16440683351);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (6106437785,323582600,"Miriam","Halee","5428 Hendrerit St.",16349243884);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (6925464733,758155161,"Whilemina","Amos","P.O. Box 464, 6292 Lacinia Avenue",13927570967);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5559392275,825828589,"Gray","Scott","Ap #563-4593 Augue Av.",17697574608);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7975072988,743373405,"Alisa","Justin","108-6088 Etiam St.",17629869570);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4253295000,554190737,"Jerome","Elaine","134-288 Sed Street",13282290115);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9661563111,582021356,"Caleb","Andrew","396-4995 Ridiculus Ave",11818735222);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (8773236495,386219706,"Zeph","Allistair","186-3918 Risus. Av.",19190957057);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5634181960,575415074,"Jaime","Nicole","Ap #298-3232 Donec St.",18885515350);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (2939062137,885962137,"Rhea","Wayne","497-9545 Nunc Av.",17443948765);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5699202361,518528409,"Regina","Amena","Ap #853-2741 Ac Street",18484772755);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (3189216093,603036913,"Nicholas","Jerome","P.O. Box 198, 9076 Enim Av.",14593285312);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9496558215,346748082,"Chaim","Hayes","5661 Quisque St.",18487583389);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5600530790,208209530,"Delilah","Perry","2750 Auctor Rd.",13512794594);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1482610651,997407707,"Shad","Evan","Ap #367-9236 Neque. Av.",19281292464);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (8773079749,652003040,"Cedric","Michael","Ap #714-4447 Dictum Avenue",14816032247);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5645324900,939038181,"Connor","Farrah","P.O. Box 958, 7727 Est. Avenue",15328390044);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9387236262,465463150,"Teegan","Lewis","Ap #938-597 Aliquet St.",12270049406);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (1310747979,329617201,"Brady","Pamela","Ap #375-6059 Purus St.",13915995857);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4953630419,339271599,"Helen","Randall","6970 Tortor, Av.",16107412618);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9180183946,655710203,"Lenore","Thomas","484-6991 Enim Avenue",16504906606);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7853522040,337223525,"Jerome","Cassady","2804 Molestie St.",11139637855);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (6301557896,350546175,"William","Ramona","P.O. Box 285, 6391 A, Rd.",19747388609);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9956659504,677132228,"Hakeem","Chastity","758-4063 Ut, Avenue",10173802836);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7413781743,688056225,"Maia","Cyrus","P.O. Box 651, 1567 Lorem, Avenue",13507144083);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9565870343,835435971,"Carol","Buckminster","9259 Mus. Rd.",18998062652);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (2036569081,405937267,"Adrian","Orson","P.O. Box 526, 1685 Augue Street",18089023181);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4967265252,164898172,"Madeson","Ingrid","183-8215 Lacinia Road",14812415018);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9004230896,629981609,"Hanna","Philip","Ap #143-6730 Et, St.",13267812114);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7968039767,606826646,"Quinn","Kaitlin","4841 Aliquam Av.",11339035928);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7368480640,576179730,"Ursa","Briar","340-9980 Sem, Rd.",15288895182);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5773464636,675608219,"Dominic","Kennedy","Ap #910-9172 Vehicula Street",15966564188);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (2131179055,996913675,"Cameran","Craig","P.O. Box 625, 3819 Eu Avenue",11385989850);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7149729115,634157852,"Harlan","Quin","P.O. Box 222, 5406 Mauris Rd.",10777208427);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (9956855833,121606598,"Jena","Claire","6011 Luctus St.",13313203495);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (4486168435,107225923,"Nelle","Maisie","4778 Erat. Ave",18867091140);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5441532985,866395280,"Rinah","Xantha","6506 Proin Ave",10513562550);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (2152166016,205693452,"Ira","Ulysses","P.O. Box 878, 5422 Nam Road",18564634569);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (5268361655,834816896,"McKenzie","Gabriel","Ap #664-3423 Ultrices. St.",13824195368);
INSERT INTO housing.employee (employee_id,ssn,first_name,last_name,address,phone) VALUES (7129735154,261134195,"Harrison","Henry","4023 Odio St.",13548515685);

-- Student Data
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8945622915,924385296,"Ignatius","Jonas","Male",TRUE,"638-4452 Velit Av.",1054401016,"Freshman","Humanities","Computer Science","23-02-02");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5042619023,283671435,"Shoshana","Alvin","Male",FALSE,"851-3802 Quam St.",1286679604,"Senior","Humanities","Art History","23-11-12");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4981837556,529640485,"Aquila","Nathaniel","Female",TRUE,"6006 Nunc Avenue",1558431922,"Sophomore","Business","Communication","25-12-01");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5713201259,895781770,"Hilda","Jermaine","Female",TRUE,"P.O. Box 302, 1758 Eu Rd.",1644419949,"Sophomore","Humanities","Art History","19-01-02");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (6783297144,925997870,"Isabella","Forrest","Other",FALSE,"5596 Sem, Rd.",1663977606,"Junior","Humanities","Art History","18-05-03");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3685651902,999207999,"Priscilla","Wade","Female",FALSE,"P.O. Box 427, 7130 Placerat Av.",1026186894,"Junior","Science","Communication","22-03-20");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (9869975140,776008835,"Judah","Laith","Transgender",FALSE,"9550 Eu, Avenue",1087924872,"Senior","Science","Biology","21-05-10");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (1286406848,897896136,"Amy","Ruby","Non-Binary",FALSE,"Ap #355-7595 Venenatis Avenue",1240589910,"Sophomore","Business","Art History","19-04-14");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7076961686,338916779,"Jackson","Kyle","Transgender",FALSE,"7252 Auctor Av.",1178534314,"Sophomore","Business","Art History","20-09-16");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (6503617548,784226775,"Marshall","Jada","Male",FALSE,"P.O. Box 185, 778 Mi Av.",1145107596,"Senior","Business","Art History","21-10-01");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3820968136,242859604,"Aphrodite","Medge","Non-Binary",FALSE,"5074 Lobortis Rd.",1258309108,"Senior","Engineering","Art History","23-06-24");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (6301341974,625331268,"Madaline","Ivory","Transgender",FALSE,"580 Et Avenue",1704754081,"Freshman","Humanities","Art History","20-11-15");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7851379252,984237148,"Portia","Eve","Transgender",FALSE,"Ap #238-1774 Imperdiet Road",1248996156,"Sophomore","Business","Art History","24-09-11");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8890734931,822942748,"Veda","Mufutau","Transgender",TRUE,"7512 In St.",1844407157,"Sophomore","Humanities","Biology","19-09-11");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3325352739,615252365,"Ima","Maggy","Female",TRUE,"5081 Nulla. Avenue",1275945652,"Senior","Humanities","Art History","18-04-08");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3240864505,256813046,"Yen","Audrey","Non-Binary",FALSE,"2318 Ac Rd.",1670006555,"Senior","Humanities","Communication","19-07-17");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (9829651023,607765655,"Aquila","Kylee","Transgender",FALSE,"P.O. Box 927, 1850 Morbi Rd.",1695112930,"Junior","Engineering","Communication","21-08-08");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7588718084,359677911,"Michael","Nell","Male",FALSE,"P.O. Box 723, 1716 Gravida. Street",1194735916,"Junior","Science","Computer Science","24-01-17");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3290590937,134749140,"Galvin","Addison","Transgender",FALSE,"9703 Felis. Ave",1338219178,"Junior","Humanities","Computer Science","23-09-27");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8061005194,422293613,"Rigel","Wynne","Non-Binary",TRUE,"P.O. Box 409, 8104 Malesuada St.",1902825026,"Senior","Humanities","Art History","19-06-01");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7591819711,842980557,"Vaughan","Chaim","Female",FALSE,"5126 Risus. Road",1560685258,"Sophomore","Engineering","Computer Science","21-05-08");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (1237389122,688076648,"Lillith","Stone","Non-Binary",TRUE,"3990 Vulputate, Ave",1147655329,"Junior","Business","Biology","22-03-09");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5626881805,611279357,"Aretha","Renee","Other",TRUE,"608-1472 Feugiat Ave",1506563161,"Freshman","Engineering","Biology","19-05-30");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4367458646,675892135,"Kasper","Kameko","Male",FALSE,"Ap #640-3763 Vulputate Ave",1006718244,"Senior","Humanities","Computer Science","25-11-16");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5863571810,286420855,"Kim","Portia","Transgender",TRUE,"1417 Cursus Road",1803880419,"Junior","Science","Computer Science","18-08-18");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3837159022,689253066,"Teegan","Zena","Female",TRUE,"7622 Donec Rd.",1498146746,"Junior","Engineering","Communication","18-05-03");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8584635585,417674109,"Emma","Jeremy","Male",TRUE,"566-7371 Ullamcorper. Rd.",1880951170,"Sophomore","Science","Communication","20-09-22");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (6865341203,564840721,"Naida","Dai","Male",TRUE,"P.O. Box 698, 5709 Nec, St.",1262617942,"Senior","Science","Communication","25-12-26");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7029934494,678977128,"Harriet","Barry","Male",TRUE,"9292 Non Avenue",1267762953,"Freshman","Science","Art History","19-01-18");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7160158181,502798421,"Shaine","Edward","Male",FALSE,"7686 Elit, Road",1253750590,"Junior","Humanities","Computer Science","25-11-26");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (9106670045,607709245,"Juliet","Shoshana","Transgender",FALSE,"6005 Donec Road",1102775877,"Sophomore","Science","Computer Science","24-09-03");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (2953106631,341915392,"Jane","Mark","Non-Binary",TRUE,"Ap #395-4725 Elit, Street",1221382110,"Sophomore","Humanities","Communication","22-12-08");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7691848698,901430098,"Tara","Hedy","Transgender",TRUE,"Ap #345-5339 Quisque Ave",1153995322,"Junior","Humanities","Communication","21-04-04");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4760946198,125165191,"Roanna","Thomas","Female",FALSE,"3259 Feugiat St.",1209698799,"Junior","Business","Biology","22-04-19");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4365726782,658121945,"Tamekah","Audrey","Other",FALSE,"P.O. Box 630, 2626 Pharetra Ave",1261771142,"Freshman","Science","Biology","22-03-05");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8094040617,515836096,"Karleigh","Gloria","Transgender",TRUE,"9230 Vehicula. Rd.",1894595338,"Freshman","Humanities","Art History","25-11-19");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (9394596511,936357483,"Macon","Kimberly","Non-Binary",TRUE,"376-2226 Etiam Rd.",1488092905,"Junior","Engineering","Art History","23-06-10");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3253451223,894012028,"Wade","Molly","Transgender",TRUE,"8253 Pede. Street",1756608401,"Sophomore","Engineering","Communication","23-03-25");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (6674097345,765936481,"Sawyer","Illana","Other",TRUE,"909-9412 Amet Road",1107269596,"Junior","Business","Communication","20-05-31");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4869338028,848546257,"Connor","Rajah","Non-Binary",TRUE,"2923 A Street",1322035765,"Senior","Science","Computer Science","25-09-19");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7617803460,673050238,"Uriah","Jermaine","Other",TRUE,"857-9936 Velit Rd.",1101623104,"Junior","Engineering","Art History","20-08-17");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3100937784,342603656,"Wesley","Sade","Female",TRUE,"833-126 Sem Road",1833650528,"Sophomore","Engineering","Biology","25-09-28");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4952495291,464876551,"Ora","Shelley","Female",FALSE,"5135 Nulla. Rd.",1493611291,"Freshman","Business","Computer Science","25-08-02");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8511491825,202110287,"Yael","Zephania","Transgender",FALSE,"Ap #345-1292 Enim. St.",1242823982,"Junior","Engineering","Biology","24-01-19");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5160427037,584297688,"Francesca","Selma","Other",FALSE,"5401 Nunc Avenue",1566353318,"Junior","Humanities","Communication","22-08-05");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7182313148,257343293,"Dean","Pandora","Other",FALSE,"P.O. Box 582, 3911 Vestibulum Ave",1816778086,"Sophomore","Humanities","Biology","21-09-01");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3792246710,228160699,"Mannix","Knox","Female",FALSE,"9006 Nunc Rd.",1206302141,"Sophomore","Business","Communication","22-11-02");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7326174648,724547069,"Stephen","Stacy","Male",FALSE,"446-6917 Nunc Road",1480260802,"Senior","Engineering","Biology","24-09-12");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (6952827858,959995813,"Allistair","Nehru","Female",FALSE,"Ap #492-5605 Tincidunt, Ave",1538997203,"Junior","Business","Art History","20-07-23");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5514856294,918883712,"Rahim","Kyla","Other",FALSE,"Ap #893-3738 Et Ave",1650968749,"Sophomore","Engineering","Art History","22-12-20");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8292612912,536237370,"Ayanna","Justin","Other",TRUE,"Ap #370-6575 Elementum, Avenue",1171498340,"Senior","Humanities","Communication","18-08-05");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3310680209,565013297,"Samantha","Kasimir","Other",TRUE,"4431 Tristique Av.",1614869495,"Sophomore","Business","Biology","25-03-26");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4298623138,315657746,"Charde","Lucas","Other",TRUE,"Ap #253-1486 Quisque Ave",1922065224,"Junior","Humanities","Biology","24-02-26");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3188830467,806999085,"Ainsley","Nita","Female",TRUE,"P.O. Box 434, 251 Maecenas St.",1644767297,"Freshman","Business","Computer Science","18-08-26");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7863881699,532818373,"Perry","Naomi","Non-Binary",TRUE,"Ap #578-568 Rhoncus. St.",1381271630,"Senior","Business","Communication","20-05-13");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (2304927085,977530289,"Lucas","Tatyana","Transgender",FALSE,"6996 Natoque Rd.",1954839159,"Senior","Business","Computer Science","20-01-26");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (1214930542,732745143,"Kay","Miriam","Female",FALSE,"P.O. Box 395, 1130 Nulla Ave",1155190543,"Senior","Humanities","Communication","22-02-04");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3302651721,262410622,"Hashim","Adrienne","Female",TRUE,"P.O. Box 736, 7010 Tempor Rd.",1166648793,"Freshman","Science","Communication","24-09-10");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (1820302774,302872031,"Mallory","Lilah","Transgender",FALSE,"P.O. Box 330, 4747 Nam Rd.",1476857875,"Sophomore","Engineering","Computer Science","21-12-11");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5798105764,625268852,"Adrienne","Keefe","Female",TRUE,"373-5285 Euismod Av.",1152466558,"Freshman","Engineering","Communication","25-08-21");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5407765198,527063825,"Pearl","Bruce","Female",TRUE,"P.O. Box 407, 489 Duis St.",1327640474,"Freshman","Science","Biology","21-07-22");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8228541124,669826550,"Cherokee","September","Non-Binary",FALSE,"211-9135 Lectus Av.",1091395295,"Sophomore","Business","Art History","22-02-25");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5754352455,594507118,"David","Wynne","Female",FALSE,"P.O. Box 924, 6135 Nam Road",1182525641,"Junior","Business","Computer Science","24-01-16");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7655194187,748746979,"Nola","Paloma","Transgender",FALSE,"672-7461 Adipiscing Rd.",1283581956,"Freshman","Business","Communication","23-09-27");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7330148236,663542036,"Charles","Graiden","Non-Binary",TRUE,"725-4675 Mauris Road",1377378324,"Junior","Engineering","Computer Science","22-01-28");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (9650378815,394586839,"Tatyana","Colette","Other",TRUE,"339-2496 Lobortis Rd.",1488126422,"Junior","Science","Biology","19-09-09");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (2782442554,340416721,"Chase","Chaney","Female",FALSE,"8397 Placerat Rd.",1887887311,"Freshman","Science","Computer Science","22-11-24");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7224240530,730292194,"Lavinia","Nola","Female",FALSE,"Ap #561-7094 Non St.",1283429267,"Senior","Business","Art History","21-08-08");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7974608467,259381342,"Marsden","Rebekah","Non-Binary",FALSE,"Ap #735-9864 Suspendisse Ave",1815774771,"Sophomore","Science","Computer Science","20-05-04");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (2184831839,979249058,"Shad","Kimberley","Non-Binary",TRUE,"P.O. Box 556, 1388 Lectus Ave",1489883927,"Senior","Humanities","Computer Science","23-03-12");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8709456310,579261750,"Phyllis","Karleigh","Non-Binary",TRUE,"P.O. Box 509, 9416 Molestie Street",1934874773,"Senior","Humanities","Computer Science","19-02-06");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4599649099,586357078,"Katelyn","Alexander","Other",TRUE,"6575 Vivamus Avenue",1527084085,"Freshman","Engineering","Communication","25-03-14");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (9110420154,107499392,"Iliana","Jared","Male",TRUE,"Ap #724-8460 Malesuada Av.",1122579923,"Freshman","Business","Communication","18-04-10");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (2450645219,473417794,"Sawyer","Len","Transgender",FALSE,"P.O. Box 258, 2461 Magnis Rd.",1692409839,"Junior","Humanities","Art History","25-11-30");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (3863368911,561028523,"Amanda","Ebony","Female",TRUE,"292-3910 Dolor. Rd.",1753273947,"Senior","Business","Communication","24-06-07");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (1895092161,891912116,"Imogene","Stacey","Male",TRUE,"993-6401 Enim Street",1079732059,"Freshman","Engineering","Biology","25-06-25");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (1986971449,232240527,"Faith","Mohammad","Transgender",TRUE,"Ap #288-6148 Lorem Road",1146658582,"Freshman","Business","Art History","21-09-11");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (1370116303,369862485,"Jaime","Hall","Other",TRUE,"P.O. Box 662, 9278 Erat, Avenue",1936631712,"Senior","Engineering","Computer Science","21-07-31");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8230167159,840569572,"Deirdre","Keegan","Female",FALSE,"Ap #292-8735 Massa St.",1467387680,"Sophomore","Engineering","Biology","19-08-08");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (6050708564,697733309,"Craig","Fletcher","Male",FALSE,"319-3434 Vulputate Rd.",1642843164,"Sophomore","Business","Art History","20-09-03");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (2633367582,816781571,"Norman","Hasad","Transgender",FALSE,"P.O. Box 300, 4251 Nunc St.",1581129107,"Senior","Engineering","Biology","20-09-26");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (9383745518,246483350,"Joel","Emily","Male",FALSE,"P.O. Box 995, 9584 Sed Street",1445953475,"Senior","Business","Communication","18-12-23");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4081517500,389947605,"Jarrod","Clayton","Transgender",FALSE,"9398 Dignissim Road",1835722187,"Freshman","Business","Communication","22-11-25");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (6126063332,467184676,"Nerea","Sybil","Non-Binary",TRUE,"195-5246 Curae; Rd.",1049108097,"Junior","Business","Biology","22-12-29");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5496775930,673446617,"Naomi","Prescott","Other",TRUE,"P.O. Box 254, 8745 Nunc Av.",1978320419,"Junior","Business","Computer Science","20-04-07");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5395178768,425452915,"Darius","Jane","Female",FALSE,"7936 Adipiscing Avenue",1050143204,"Freshman","Business","Communication","20-10-28");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (6648110646,632179429,"Ruby","Edan","Male",TRUE,"Ap #438-9133 A St.",1334611640,"Sophomore","Engineering","Art History","23-05-02");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7500216594,945866340,"Frances","Kelly","Other",TRUE,"286-8041 Varius Road",1628140871,"Senior","Business","Biology","20-07-23");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (2273821826,225237495,"Maxine","Thomas","Male",TRUE,"767-6254 Morbi Rd.",1574636298,"Junior","Business","Art History","25-11-10");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5892950586,466690992,"Madison","Lacota","Transgender",TRUE,"232-3223 Sem, Ave",1793461994,"Senior","Business","Computer Science","19-05-16");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (9012608889,372923349,"Alvin","Gil","Other",TRUE,"P.O. Box 712, 4791 Cras Road",1796256295,"Senior","Business","Computer Science","25-02-09");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7322945264,638652692,"Helen","Hayfa","Female",FALSE,"Ap #964-5250 Quisque Ave",1034652047,"Senior","Science","Computer Science","22-07-25");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (5926197333,299716107,"Alvin","Genevieve","Female",FALSE,"9786 Duis Rd.",1236186651,"Senior","Humanities","Computer Science","25-07-05");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (6639828789,372895364,"Odessa","Cecilia","Transgender",TRUE,"P.O. Box 711, 8482 Erat. Rd.",1860206812,"Junior","Science","Computer Science","21-09-08");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4984514790,217613454,"Mark","Kellie","Transgender",TRUE,"4669 Mi Avenue",1050286440,"Junior","Engineering","Art History","18-11-26");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7708888705,915741036,"Zenia","Melanie","Non-Binary",TRUE,"598-3254 Eros St.",1378352656,"Senior","Humanities","Biology","20-05-29");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (4903463383,224742126,"Lani","Demetrius","Other",FALSE,"7916 Elit. Rd.",1288511131,"Junior","Engineering","Art History","21-06-23");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7497915569,222745805,"Shea","Illiana","Female",FALSE,"983-2605 Morbi Road",1613156642,"Sophomore","Engineering","Computer Science","18-10-31");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (8091283533,636014646,"Carol","Desirae","Non-Binary",TRUE,"914-8717 A Rd.",1602241063,"Sophomore","Science","Art History","25-04-08");
INSERT INTO housing.student (student_id,ssn,first_name,last_name,gender,marital_status,address,phone_number,undergraduate_level,major_college,major_department,graduation_date) VALUES (7110532361,345634594,"Wyatt","Iris","Transgender",TRUE,"Ap #108-680 Erat Ave",1838569524,"Freshman","Business","Art History","21-02-02");

-- Building Data
INSERT INTO housing.building (building_id,building_name) VALUES (20,"Willow");
INSERT INTO housing.building (building_id,building_name) VALUES (53,"Omar");
INSERT INTO housing.building (building_id,building_name) VALUES (89,"Ocean");
INSERT INTO housing.building (building_id,building_name) VALUES (55,"Basia");
INSERT INTO housing.building (building_id,building_name) VALUES (49,"Wang");
INSERT INTO housing.building (building_id,building_name) VALUES (92,"Davis");
INSERT INTO housing.building (building_id,building_name) VALUES (91,"Maxine");
INSERT INTO housing.building (building_id,building_name) VALUES (69,"Yael");
INSERT INTO housing.building (building_id,building_name) VALUES (66,"Ava");
INSERT INTO housing.building (building_id,building_name) VALUES (10,"Minerva");

-- Room Data
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (37350,55,"1480 Est, Av.",2,"King",3,3,"Two Bedroom Apartment",FALSE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (46363,91,"2881 Tortor Ave",1,"Twin",3,3,"One Bedroom Suite",FALSE,FALSE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (39970,66,"P.O. Box 992, 9181 Egestas. Road",2,"Queen",1,1,"One Bedroom Suite",TRUE,FALSE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (79716,69,"4282 Mi Street",2,"Twin",4,3,"One Bedroom Suite",TRUE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (64448,89,"301-2496 Egestas Street",4,"Queen",1,4,"One Bedroom Suite",TRUE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (70925,10,"P.O. Box 630, 490 Venenatis Road",3,"Twin",2,4,"Two Bedroom Apartment",FALSE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (84392,89,"344-5120 Nulla Ave",4,"Twin",1,2,"Two Bedroom Apartment",TRUE,FALSE,4000);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (73931,53,"1160 Vestibulum Rd.",4,"Queen",1,4,"One Bedroom Suite",TRUE,FALSE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (29289,89,"644-6673 Pharetra, Ave",3,"Queen",2,4,"Two Bedroom Suite",FALSE,FALSE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (84602,66,"P.O. Box 572, 3025 Nisi. St.",1,"King",4,1,"Two Bedroom Suite",TRUE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (63919,91,"2373 Ligula. Ave",4,"Twin",4,4,"Two Bedroom Apartment",FALSE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (54491,92,"9889 Ut Rd.",4,"King",2,2,"Two Bedroom Suite",FALSE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (77350,55,"P.O. Box 491, 2134 Tempus, Street",4,"Queen",3,4,"Four Bedroom Apartment",FALSE,TRUE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (48809,55,"7163 Ligula St.",3,"Twin",1,2,"Two Bedroom Suite",TRUE,FALSE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (43927,91,"9010 Tincidunt Av.",3,"Twin",3,3,"Two Bedroom Suite",TRUE,FALSE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (95509,53,"179-5732 Duis Rd.",3,"Queen",4,4,"Two Bedroom Apartment",TRUE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (66595,66,"P.O. Box 925, 1897 Aliquam Street",4,"Twin",1,2,"Two Bedroom Suite",TRUE,FALSE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (22421,20,"Ap #219-3983 Morbi Rd.",1,"Queen",2,2,"One Bedroom Suite",TRUE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (66564,49,"P.O. Box 655, 5365 Porttitor Street",3,"Twin",2,1,"Two Bedroom Apartment",FALSE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (68338,92,"P.O. Box 272, 9430 Nunc Rd.",2,"Twin",4,3,"Two Bedroom Apartment",FALSE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (48303,20,"142-5447 Vulputate St.",3,"Twin",1,4,"Four Bedroom Apartment",FALSE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (48841,89,"P.O. Box 839, 4597 Congue, Street",2,"Queen",2,2,"Two Bedroom Apartment",TRUE,FALSE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (80142,66,"P.O. Box 828, 5650 Adipiscing Road",4,"Queen",2,4,"Two Bedroom Suite",FALSE,FALSE,4000);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (43741,66,"300-8154 Magna. St.",3,"King",2,1,"Two Bedroom Suite",TRUE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (92016,92,"352-4083 Diam. St.",2,"King",1,4,"Four Bedroom Apartment",TRUE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (15788,89,"P.O. Box 957, 3043 Curabitur Ave",4,"Queen",1,1,"Two Bedroom Apartment",FALSE,FALSE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (46601,66,"P.O. Box 238, 5843 Volutpat Av.",1,"Queen",2,4,"One Bedroom Suite",TRUE,FALSE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (49739,69,"862-6321 Ipsum. Avenue",3,"King",2,4,"Two Bedroom Suite",TRUE,FALSE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (92518,66,"Ap #338-7786 Euismod St.",3,"Twin",3,4,"One Bedroom Suite",FALSE,TRUE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (83632,20,"P.O. Box 846, 3809 Nibh. Rd.",2,"Queen",2,1,"Two Bedroom Suite",FALSE,TRUE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (97704,55,"Ap #667-7661 Consectetuer Rd.",4,"Queen",1,4,"Two Bedroom Suite",FALSE,TRUE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (88165,69,"P.O. Box 627, 7110 Libero. St.",1,"Twin",1,4,"Two Bedroom Apartment",TRUE,FALSE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (34786,55,"117-7337 At, Rd.",1,"King",1,1,"Two Bedroom Suite",TRUE,TRUE,4000);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (37094,49,"P.O. Box 752, 2050 Consectetuer Road",4,"King",2,3,"Four Bedroom Apartment",TRUE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (54973,92,"819 Imperdiet St.",3,"King",2,3,"Four Bedroom Apartment",TRUE,TRUE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (17933,49,"219-5898 Nulla. Av.",1,"Twin",2,4,"Four Bedroom Apartment",FALSE,FALSE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (69506,66,"919-8792 Tellus Road",3,"Twin",1,1,"Two Bedroom Apartment",FALSE,FALSE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (95440,10,"1256 Aliquam Rd.",4,"King",3,1,"Two Bedroom Suite",FALSE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (13151,92,"4045 Fringilla Avenue",4,"Twin",4,2,"Four Bedroom Apartment",FALSE,FALSE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (48053,69,"Ap #969-4094 Quis Road",3,"Twin",4,1,"Two Bedroom Apartment",TRUE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (17562,91,"199-7404 Et Rd.",1,"Twin",4,2,"Two Bedroom Suite",TRUE,FALSE,4000);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (26424,20,"6506 Accumsan Rd.",1,"King",3,4,"Two Bedroom Suite",TRUE,FALSE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (95235,91,"216-592 Magna St.",2,"Queen",2,3,"One Bedroom Suite",TRUE,FALSE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (49427,55,"4367 Pellentesque Avenue",4,"Queen",2,4,"Two Bedroom Apartment",TRUE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (39588,49,"Ap #308-4550 Varius Av.",1,"Queen",4,1,"One Bedroom Suite",FALSE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (92009,66,"2433 Fusce Rd.",2,"Twin",4,2,"Four Bedroom Apartment",FALSE,FALSE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (41283,91,"Ap #588-8503 Molestie. Av.",3,"Twin",2,3,"Two Bedroom Apartment",TRUE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (67590,53,"P.O. Box 780, 2749 Purus St.",1,"Twin",1,4,"Two Bedroom Suite",TRUE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (78559,69,"233-449 Sed Rd.",1,"Twin",1,4,"Two Bedroom Suite",FALSE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (28474,55,"P.O. Box 980, 7345 Lacus Rd.",4,"Twin",2,4,"Two Bedroom Suite",TRUE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (25125,89,"Ap #375-8173 Amet St.",3,"Queen",4,4,"One Bedroom Suite",FALSE,FALSE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (13492,91,"265-8262 Dolor, Rd.",2,"Twin",2,1,"One Bedroom Suite",FALSE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (14580,69,"7049 Pede Rd.",3,"Twin",1,3,"Two Bedroom Suite",TRUE,FALSE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (88450,89,"6004 Aenean Av.",3,"Queen",4,3,"One Bedroom Suite",TRUE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (61006,69,"733-9897 Facilisis, Street",2,"Queen",1,1,"Four Bedroom Apartment",TRUE,FALSE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (30941,89,"602-2996 Ut, Road",3,"Queen",2,2,"One Bedroom Suite",FALSE,TRUE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (31719,66,"365 Lectus Avenue",3,"Twin",1,3,"Two Bedroom Suite",FALSE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (58760,20,"6231 Enim St.",4,"Twin",4,2,"Four Bedroom Apartment",TRUE,FALSE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (95232,89,"3350 Interdum Avenue",2,"Twin",3,1,"Two Bedroom Apartment",TRUE,TRUE,4000);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (37196,91,"P.O. Box 850, 5806 Cursus. Road",2,"King",4,4,"Two Bedroom Suite",FALSE,TRUE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (38730,89,"Ap #986-7232 Duis Avenue",2,"Queen",4,1,"Two Bedroom Suite",TRUE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (15079,53,"9914 Nam St.",4,"Queen",1,2,"One Bedroom Suite",FALSE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (41873,91,"2042 Donec Road",4,"Twin",4,4,"Four Bedroom Apartment",TRUE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (34920,55,"Ap #456-5080 Mauris Rd.",1,"Queen",2,2,"Four Bedroom Apartment",FALSE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (99984,53,"Ap #616-7472 Ligula. St.",1,"Queen",1,3,"Four Bedroom Apartment",FALSE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (56860,20,"3688 Nulla. Ave",4,"Twin",2,3,"One Bedroom Suite",TRUE,TRUE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (41004,89,"621-1756 Dui Avenue",3,"Twin",3,4,"Two Bedroom Suite",TRUE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (32617,91,"P.O. Box 755, 9074 Sed, Rd.",1,"King",4,2,"One Bedroom Suite",TRUE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (20485,92,"Ap #938-5105 Sed Road",3,"King",3,2,"Four Bedroom Apartment",FALSE,TRUE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (98991,69,"Ap #405-6888 Tempus Ave",2,"Twin",3,2,"Two Bedroom Apartment",FALSE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (65599,53,"Ap #244-8182 Sed St.",4,"Queen",3,4,"One Bedroom Suite",TRUE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (86468,66,"Ap #222-320 Sem. St.",2,"King",2,1,"Two Bedroom Suite",FALSE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (32033,92,"179-3614 Nullam St.",2,"Queen",1,3,"Four Bedroom Apartment",FALSE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (14733,49,"Ap #570-7860 Egestas, Road",4,"Queen",3,3,"One Bedroom Suite",TRUE,FALSE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (26538,89,"7169 Cum Road",1,"Queen",4,2,"One Bedroom Suite",FALSE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (94340,49,"2107 Lorem, Street",1,"Twin",2,1,"One Bedroom Suite",TRUE,TRUE,4000);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (41727,91,"9732 Nunc Road",2,"Queen",1,3,"One Bedroom Suite",FALSE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (96132,91,"P.O. Box 554, 6076 Blandit Road",4,"Queen",4,2,"Four Bedroom Apartment",TRUE,FALSE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (10780,66,"Ap #550-6686 Dignissim Rd.",3,"King",4,3,"Two Bedroom Suite",TRUE,TRUE,4000);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (51333,49,"8311 Eleifend Ave",4,"King",2,2,"Four Bedroom Apartment",TRUE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (64363,49,"P.O. Box 398, 6779 Sed St.",3,"Queen",4,3,"Two Bedroom Apartment",TRUE,TRUE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (29112,89,"3019 Ut St.",2,"Twin",1,1,"Four Bedroom Apartment",FALSE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (68541,89,"Ap #857-709 Non, Av.",2,"Twin",4,4,"One Bedroom Suite",FALSE,FALSE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (56860,69,"Ap #265-2290 Hendrerit Ave",1,"Twin",4,1,"One Bedroom Suite",FALSE,FALSE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (48527,53,"537-547 Id Av.",1,"Twin",1,1,"Four Bedroom Apartment",FALSE,TRUE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (76381,49,"663-2543 Dolor Rd.",1,"King",3,1,"One Bedroom Suite",TRUE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (39728,69,"Ap #497-1276 Vel, Avenue",4,"King",2,1,"Two Bedroom Apartment",TRUE,FALSE,3334);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (65389,20,"3978 Eu Rd.",3,"Queen",3,4,"Two Bedroom Suite",TRUE,FALSE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (51492,10,"P.O. Box 825, 7380 Nisi Road",1,"King",2,2,"Two Bedroom Apartment",TRUE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (83533,92,"2252 Metus Street",4,"King",3,2,"Four Bedroom Apartment",TRUE,FALSE,4000);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (72252,66,"P.O. Box 834, 512 Ipsum Avenue",4,"Twin",1,2,"Two Bedroom Suite",FALSE,FALSE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (51361,92,"Ap #857-9740 Pede Road",2,"Queen",3,4,"Two Bedroom Suite",TRUE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (86624,53,"Ap #320-5130 Auctor St.",1,"Twin",1,2,"Two Bedroom Suite",FALSE,FALSE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (58838,66,"Ap #751-7739 Nonummy St.",3,"King",2,4,"Two Bedroom Apartment",FALSE,FALSE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (55960,20,"7333 Volutpat. Road",2,"King",4,2,"One Bedroom Suite",FALSE,FALSE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (96512,49,"625-5898 Gravida St.",2,"Queen",4,1,"One Bedroom Suite",FALSE,TRUE,4667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (17028,66,"983-445 Ligula Street",3,"Twin",3,1,"Four Bedroom Apartment",TRUE,TRUE,2500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (38505,91,"Ap #569-7233 Convallis Rd.",4,"King",4,1,"Four Bedroom Apartment",FALSE,FALSE,3500);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (88626,91,"P.O. Box 417, 7347 Cubilia Road",1,"Twin",3,2,"Two Bedroom Apartment",FALSE,TRUE,3667);
INSERT INTO housing.room (room_number,building_id,address,bedroom_count,bed_size,capacity,occupancy,room_type,marriage,married_resident,cost) VALUES (68055,92,"745 Aliquam Rd.",2,"Twin",4,2,"Two Bedroom Apartment",FALSE,FALSE,4667);


-- Admin Data
INSERT INTO housing.admin (admin_id) VALUES(1317495323);
INSERT INTO housing.admin (admin_id) VALUES(1920714839);
INSERT INTO housing.admin (admin_id) VALUES(3987609918);
INSERT INTO housing.admin (admin_id) VALUES(6320215443);
INSERT INTO housing.admin (admin_id) VALUES(9640642418);

-- Applicant Data
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(1214930542,"In Progress","2018-11-29",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(1237389122,"In Progress","2018-11-30",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(1286406848,"In Progress","2018-12-01",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(1370116303,"In Progress","2018-12-02",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(1820302774,"In Progress","2018-12-03",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(1895092161,"In Progress","2018-12-04",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(1986971449,"In Progress","2018-12-05",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(2184831839,"In Progress","2018-12-06",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(2273821826,"In Progress","2018-12-07",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(2304927085,"In Progress","2018-12-08",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(2450645219,"In Progress","2018-12-09",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(2633367582,"In Progress","2018-12-10",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(2782442554,"In Progress","2018-12-11",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(2953106631,"In Progress","2018-12-12",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3100937784,"In Progress","2018-12-13",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3188830467,"In Progress","2018-12-14",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3240864505,"In Progress","2018-12-15",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3253451223,"In Progress","2018-12-16",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3290590937,"In Progress","2018-12-17",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3302651721,"In Progress","2018-12-18",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3310680209,"In Progress","2018-12-19",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3325352739,"In Progress","2018-12-20",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3685651902,"In Progress","2018-12-21",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3792246710,"In Progress","2018-12-22",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3820968136,"In Progress","2018-12-23",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3837159022,"In Progress","2018-12-24",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(3863368911,"In Progress","2018-12-25",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4081517500,"In Progress","2018-12-26",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4298623138,"In Progress","2018-12-27",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4365726782,"In Progress","2018-12-28",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4367458646,"In Progress","2018-12-29",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4599649099,"In Progress","2018-12-30",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4760946198,"In Progress","2018-12-31",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4869338028,"In Progress","2019-01-01",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4903463383,"In Progress","2019-01-02",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4952495291,"In Progress","2019-01-03",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4981837556,"In Progress","2019-01-04",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(4984514790,"In Progress","2019-01-05",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5042619023,"In Progress","2019-01-06",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5160427037,"In Progress","2019-01-07",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5395178768,"In Progress","2019-01-08",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5407765198,"In Progress","2019-01-09",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5496775930,"In Progress","2019-01-10",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5514856294,"In Progress","2019-01-11",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5626881805,"In Progress","2019-01-12",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5713201259,"In Progress","2019-01-13",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5754352455,"In Progress","2019-01-14",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5798105764,"In Progress","2019-01-15",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5863571810,"In Progress","2019-01-16",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5892950586,"In Progress","2019-01-17",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(5926197333,"In Progress","2019-01-18",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(6050708564,"In Progress","2019-01-19",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(6126063332,"In Progress","2019-01-20",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(6301341974,"In Progress","2019-01-21",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(6503617548,"In Progress","2019-01-22",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(6639828789,"In Progress","2019-01-23",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(6648110646,"In Progress","2019-01-24",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(6674097345,"In Progress","2019-01-25",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(6783297144,"In Progress","2019-01-26",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(6865341203,"In Progress","2019-01-27",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(6952827858,"In Progress","2019-01-28",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7029934494,"In Progress","2019-01-29",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7076961686,"In Progress","2019-01-30",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7110532361,"In Progress","2019-01-31",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7160158181,"In Progress","2019-02-01",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7182313148,"In Progress","2019-02-02",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7224240530,"In Progress","2019-02-03",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7322945264,"In Progress","2019-02-04",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7326174648,"In Progress","2019-02-05",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7330148236,"In Progress","2019-02-06",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7497915569,"In Progress","2019-02-07",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7500216594,"In Progress","2019-02-08",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7588718084,"In Progress","2019-02-09",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7591819711,"In Progress","2019-02-10",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7617803460,"In Progress","2019-02-11",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7655194187,"In Progress","2019-02-12",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7691848698,"In Progress","2019-02-13",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7708888705,"In Progress","2019-02-14",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7851379252,"In Progress","2019-02-15",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7863881699,"In Progress","2019-02-16",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(7974608467,"In Progress","2019-02-17",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8061005194,"In Progress","2019-02-18",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8091283533,"In Progress","2019-02-19",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8094040617,"In Progress","2019-02-20",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8228541124,"In Progress","2019-02-21",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8230167159,"In Progress","2019-02-22",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8292612912,"In Progress","2019-02-23",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8511491825,"In Progress","2019-02-24",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8584635585,"In Progress","2019-02-25",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8709456310,"In Progress","2019-02-26",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8890734931,"In Progress","2019-02-27",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(8945622915,"In Progress","2019-02-28",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(9012608889,"In Progress","2019-03-01",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(9106670045,"In Progress","2019-03-02",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(9110420154,"In Progress","2019-03-03",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(9383745518,"In Progress","2019-03-04",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(9394596511,"In Progress","2019-03-05",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(9650378815,"In Progress","2019-03-06",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(9829651023,"In Progress","2019-03-07",0,FALSE);
INSERT INTO housing.applicant (student_id,application_status,submission_date,fee,married) VALUES(9869975140,"In Progress","2019-03-08",0,FALSE);

-- Preferred Buidling Data
INSERT INTO housing.preferred_building (application_id) VALUES(1000000001);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000002);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000003);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000004);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000005);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000006);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000007);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000008);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000009);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000000);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000010);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000011);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000012);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000013);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000014);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000015);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000016);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000017);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000018);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000019);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000020);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000021);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000022);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000023);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000024);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000025);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000026);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000027);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000028);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000029);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000030);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000031);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000032);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000033);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000034);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000035);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000036);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000037);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000038);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000039);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000040);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000041);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000042);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000043);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000044);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000045);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000046);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000047);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000048);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000049);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000050);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000051);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000052);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000053);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000054);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000055);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000056);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000057);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000058);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000059);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000060);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000061);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000062);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000063);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000064);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000065);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000066);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000067);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000068);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000069);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000070);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000071);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000072);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000073);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000074);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000075);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000076);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000077);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000078);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000079);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000080);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000081);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000082);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000083);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000084);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000085);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000086);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000087);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000088);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000089);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000090);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000091);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000092);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000093);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000094);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000095);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000096);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000097);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000098);
INSERT INTO housing.preferred_building (application_id) VALUES(1000000099);

-- Preferred Room Data
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000001,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000002,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000003,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000004,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000005,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000006,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000007,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000008,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000009,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000000,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000010,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000011,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000012,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000013,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000014,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000015,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000016,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000017,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000018,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000019,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000020,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000021,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000022,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000023,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000024,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000025,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000026,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000027,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000028,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000029,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000030,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000031,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000032,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000033,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000034,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000035,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000036,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000037,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000038,"Two Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000039,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000040,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000041,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000042,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000043,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000044,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000045,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000046,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000047,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000048,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000049,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000050,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000051,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000052,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000053,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000054,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000055,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000056,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000057,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000058,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000059,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000060,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000061,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000062,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000063,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000064,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000065,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000066,"Four Bedroom Apartment");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000067,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000068,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000069,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000070,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000071,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000072,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000073,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000074,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000075,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000076,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000077,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000078,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000079,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000080,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000081,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000082,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000083,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000084,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000085,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000086,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000087,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000088,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000089,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000090,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000091,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000092,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000093,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000094,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000095,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000096,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000097,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000098,"One Bedroom Suite");
INSERT INTO housing.preferred_room (application_id, room_type_1) VALUES(1000000099,"One Bedroom Suite");

-- Room Resident Data
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(15788,89,1214930542,1370116303);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(37350,55,1820302774,1895092161);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(39728,69,1986971449,2184831839);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(41283,91,2273821826,2304927085);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(48053,69,2450645219,2633367582);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(48841,89,2782442554,2953106631);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(49427,55,3100937784,3188830467);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(51492,10,3240864505,3253451223);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(58838,66,3290590937,3302651721);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(63919,91,3310680209,3325352739);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(64363,49,3685651902,3792246710);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(66564,49,3820968136,3837159022);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(68055,92,3863368911,4081517500);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(68338,92,4298623138,4365726782);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(69506,66,4367458646,4599649099);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(70925,10,4760946198,4869338028);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(84392,89,4903463383,4952495291);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(88165,69,4981837556,4984514790);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(88626,91,5042619023,1237389122);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2, resident_3, resident_4) VALUES(13151,92,5160427037,5395178768,5407765198,5496775930);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2, resident_3, resident_4) VALUES(17028,66,5514856294,5626881805,5713201259,5754352455);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2, resident_3, resident_4) VALUES(17933,49,5798105764,5863571810,5892950586,5926197333);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2, resident_3, resident_4) VALUES(20485,92,6050708564,6126063332,6301341974,6503617548);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2, resident_3, resident_4) VALUES(29112,89,6639828789,6648110646,6674097345,6783297144);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2, resident_3, resident_4) VALUES(32033,92,6865341203,6952827858,7029934494,7076961686);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2, resident_3, resident_4) VALUES(34920,55,7110532361,7160158181,7182313148,7224240530);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(13492,91,7322945264);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(14733,49,7326174648);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(15079,53,7330148236);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(22421,20,7497915569);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(25125,89,7500216594);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(26538,89,7588718084);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(30941,89,7591819711);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(32617,91,7617803460);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(39588,49,7655194187);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(39970,66,7691848698);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(41727,91,7708888705);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(46363,91,7851379252);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(46601,66,7863881699);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(55960,20,7974608467);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(56860,20,8061005194);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(56860,69,8091283533);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(64448,89,8094040617);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(65599,53,8228541124);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(68541,89,8230167159);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(73931,53,8292612912);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(76381,49,8511491825);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(79716,69,8584635585);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(88450,89,8709456310);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(92518,66,8890734931);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(94340,49,8945622915);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(95235,91,9012608889);
INSERT INTO housing.room_residents (room_number, building_id, resident_1) VALUES(96512,49,9106670045);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2) VALUES(98991,69,9110420154,9383745518);
INSERT INTO housing.room_residents (room_number, building_id, resident_1, resident_2, resident_3, resident_4) VALUES(99984,53,9394596511,9650378815,9829651023,9869975140);

-- Update Resident Information

INSERT INTO housing.resident(student_id, building_id, room_number) SELECT housing.room_residents.resident_1, housing.room_residents.building_id, housing.room_residents.room_number FROM housing.room_residents;
INSERT INTO housing.resident(student_id, building_id, room_number) SELECT housing.room_residents.resident_2, housing.room_residents.building_id, housing.room_residents.room_number FROM housing.room_residents WHERE housing.room_residents.resident_2 IS NOT NULL;
INSERT INTO housing.resident(student_id, building_id, room_number) SELECT housing.room_residents.resident_3, housing.room_residents.building_id, housing.room_residents.room_number FROM housing.room_residents WHERE housing.room_residents.resident_3 IS NOT NULL;
INSERT INTO housing.resident(student_id, building_id, room_number) SELECT housing.room_residents.resident_4, housing.room_residents.building_id, housing.room_residents.room_number FROM housing.room_residents WHERE housing.room_residents.resident_4 IS NOT NULL;