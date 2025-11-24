 CREATE DATABASE crime_db;
 USE crime_db;
-- 1. Police Station
CREATE TABLE Police_Station (
  station_id INT AUTO_INCREMENT PRIMARY KEY,
  station_name VARCHAR(100),
  location VARCHAR(150)
);
-- 2. Officer
CREATE TABLE Officer (
  officer_id INT AUTO_INCREMENT PRIMARY KEY,
  officer_name VARCHAR(100),
  officer_rank VARCHAR(50),
  station_id INT,
  FOREIGN KEY (station_id) REFERENCES Police_Station(station_id)
);
-- 3. Crime Type
CREATE TABLE Crime_Type (
  crime_type_id INT AUTO_INCREMENT PRIMARY KEY,
  crime_name VARCHAR(100),
  description VARCHAR(200)
);
-- Crime Case
CREATE TABLE Crime_Case (
  case_id INT AUTO_INCREMENT PRIMARY KEY,
  case_title VARCHAR(200),
  crime_type_id INT,
  officer_id INT,
  date_reported DATE,
  status VARCHAR(50),
  FOREIGN KEY (crime_type_id) REFERENCES Crime_Type(crime_type_id),
  FOREIGN KEY (officer_id) REFERENCES Officer(officer_id)
  );
  -- 5. Suspect
CREATE TABLE Suspect (
  suspect_id INT AUTO_INCREMENT PRIMARY KEY,
  suspect_name VARCHAR(100),
  age INT,
  address VARCHAR(200),
  case_id INT,
  FOREIGN KEY (case_id) REFERENCES Crime_Case(case_id)
);
INSERT INTO Police_Station (station_name, location) VALUES
('Central Station', 'City Center'),
('North Station', 'North Zone'),
('Cyber Cell', 'Tech Park'),
('Harbour Station', 'Harbour Area'),
('West Station', 'Westside'),
('East Station', 'East End'),
('South Station', 'South Zone'),
('Hillside Station', 'Hill Area'),
('Metro Station', 'Metro Circle'),
('Riverside Station', 'River Bank');
--------------------------------------------
INSERT INTO Officer (officer_name, officer_rank, station_id) VALUES
('Raj Singh', 'Inspector', 1),
('Amit Verma', 'Constable', 1),
('Kavita Rao', 'Sub-Inspector', 2),
('John Fernandes', 'Inspector', 3),
('Meera Shah', 'Constable', 4),
('Arjun Patel', 'ACP', 3),
('Riya Malhotra', 'Head Constable', 5),
('Rohit Sharma', 'Inspector', 6),
('Sneha Nair', 'Sub-Inspector', 7),
('Daniel Joseph', 'Constable', 2);
-----------------------------------------
INSERT INTO Crime_Type (crime_name, description) VALUES
('Cyber Crime', 'Online fraud, hacking, identity theft'),
('Robbery', 'Stealing using force'),
('Theft', 'Stealing without force'),
('Fraud', 'Financial cheating'),
('Assault', 'Physical attack'),
('Kidnapping', 'Forceful abduction'),
('Drug Crime', 'Illegal substances'),
('Harassment', 'Threatening / abusive behavior'),
('Cyber Bullying', 'Online harassment'),
('Phishing', 'Fake communication to steal data');
------------------------------------------------------
INSERT INTO Crime_Case (case_title, crime_type_id, officer_id, date_reported, status) VALUES
('Online Banking Scam', 1, 4, '2024-10-12', 'Under Investigation'),
('Mobile Theft from Mall', 3, 2, '2024-09-01', 'Open'),
('House Robbery at Night', 2, 1, '2024-07-22', 'Closed'),
('Assault in Market', 5, 3, '2024-05-18', 'Under Investigation'),
('Email Phishing Fraud', 10, 6, '2024-08-04', 'Open'),
('Kidnapping of Teenager', 6, 7, '2024-08-20', 'Under Investigation'),
('Cyber Bullying Case', 9, 9, '2024-06-14', 'Closed'),
('ATM Card Skimming', 1, 4, '2024-04-30', 'Open'),
('Car Theft Case', 3, 8, '2024-11-01', 'Under Investigation'),
('Harassment Complaint', 8, 10, '2024-09-18', 'Open'),
('Drug Smuggling Case', 7, 5, '2024-01-28', 'Closed'),
('Jewelry Shop Robbery', 2, 1, '2024-03-03', 'Under Investigation'),
('Fake Loan Fraud', 4, 6, '2024-02-22', 'Open'),
('Laptop Hacking Incident', 1, 4, '2024-08-30', 'Closed'),
('Street Fight Assault', 5, 3, '2024-10-05', 'Open');
-----------------------------------------------------
INSERT INTO Suspect (suspect_name, age, address, case_id) VALUES
('Rohan Mehta', 28, 'City Street 12', 1),
('Suresh Kumar', 35, 'Lane 5, North Zone', 2),
('Imran Khan', 40, 'Market Road', 3),
('Vijay Gupta', 25, 'Tech Park', 1),
('Rita Sharma', 30, 'Westside Area', 4),
('Sameer Ali', 22, 'Sector 14', 5),
('Neha Joshi', 27, 'Green Park', 6),
('Punit Shah', 33, 'Hill Avenue', 7),
('Arif Khan', 29, 'Old City', 8),
('Sanjay Patel', 42, 'Sunset Colony', 9),
('Rekha Yadav', 31, 'North Enclave', 10),
('Mohit Dixit', 26, 'East Road', 11),
('Dinesh Rawat', 37, 'Harbour Block', 12),
('Anil Kumar', 28, 'Metro Center', 13),
('Nitin Verma', 24, 'City Plaza', 14),
('Kabir Malhotra', 33, 'South Zone', 15),
('Devansh Roy', 39, 'River Park', 3),
('Jatin Shah', 32, 'Tech Lane', 4),
('Arjun Desai', 27, 'Metro Circle', 5),
('Harshita Sen', 29, 'Hill Base', 6);
------------------------------------------------------------
-- QUERY SECTION:-
------------------------------------------------------------
-- QUERY 1: Display all crime cases
------------------------------------------------------------
SELECT * FROM Crime_Case;

------------------------------------------------------------
-- QUERY 2: Show officer details with station name
------------------------------------------------------------
SELECT o.officer_name, o.officer_rank, p.station_name, p.location
FROM Officer o
JOIN Police_Station p ON o.station_id = p.station_id;

------------------------------------------------------------
-- QUERY 3: List all Cyber Crime cases
------------------------------------------------------------
SELECT c.case_title, c.date_reported, c.status
FROM Crime_Case c
JOIN Crime_Type ct ON c.crime_type_id = ct.crime_type_id
WHERE ct.crime_name = 'Cyber Crime';

------------------------------------------------------------
-- QUERY 4: Show suspects with their case
------------------------------------------------------------
SELECT s.suspect_name, s.age, c.case_title
FROM Suspect s
JOIN Crime_Case c ON s.case_id = c.case_id;

------------------------------------------------------------
-- QUERY 5: Count cases by each crime type
------------------------------------------------------------
SELECT ct.crime_name, COUNT(c.case_id) AS total_cases
FROM Crime_Case c
JOIN Crime_Type ct ON c.crime_type_id = ct.crime_type_id
GROUP BY ct.crime_name;

------------------------------------------------------------
-- QUERY 6: Show officers handling cases
------------------------------------------------------------
SELECT o.officer_name, o.officer_rank, COUNT(c.case_id) AS assigned_cases
FROM Officer o
JOIN Crime_Case c ON o.officer_id = c.officer_id
GROUP BY o.officer_id;

------------------------------------------------------------
-- QUERY 7: List all OPEN cases
------------------------------------------------------------
SELECT case_title, date_reported
FROM Crime_Case
WHERE status = 'Open';

------------------------------------------------------------
-- QUERY 8: Count suspects involved per case
------------------------------------------------------------
SELECT c.case_title, COUNT(s.suspect_id) AS total_suspects
FROM Crime_Case c
LEFT JOIN Suspect s ON c.case_id = s.case_id
GROUP BY c.case_title;

------------------------------------------------------------
-- QUERY 9: Show 5 most recent cases
------------------------------------------------------------
SELECT case_title, date_reported, status
FROM Crime_Case
ORDER BY date_reported DESC
LIMIT 5;

------------------------------------------------------------
-- QUERY 10: Display cases handled by officer_id = 4
------------------------------------------------------------
SELECT case_title, status, date_reported
FROM Crime_Case
WHERE officer_id = 4;

------------------------------------------------------------
-- QUERY 11: List suspects older than 30
------------------------------------------------------------
SELECT suspect_name, age, address
FROM Suspect
WHERE age > 30;

------------------------------------------------------------
-- QUERY 12: Show all cases with their crime type
------------------------------------------------------------
SELECT c.case_title, ct.crime_name, c.status
FROM Crime_Case c
JOIN Crime_Type ct ON c.crime_type_id = ct.crime_type_id;

------------------------------------------------------------
-- QUERY 13: Case count per police station
------------------------------------------------------------
SELECT p.station_name, COUNT(c.case_id) AS total_cases
FROM Police_Station p
LEFT JOIN Officer o ON p.station_id = o.station_id
LEFT JOIN Crime_Case c ON o.officer_id = c.officer_id
GROUP BY p.station_name;

------------------------------------------------------------
-- QUERY 14: Cases reported between two dates
------------------------------------------------------------
SELECT case_title, date_reported, status
FROM Crime_Case
WHERE date_reported BETWEEN '2024-07-01' AND '2024-10-01';

------------------------------------------------------------
-- QUERY 15: Suspects from address containing 'Tech Park'
------------------------------------------------------------
SELECT suspect_name, age, case_id
FROM Suspect
WHERE address LIKE '%Tech Park%';





