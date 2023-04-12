/*
   -----------------------------------------------------------------------------
   Programmer's Name: Justin Dubin
   Course: CSCI 2020 Section Number: 201
   Creation Date: 04/29/2022 Date of Last Modification: 04/29/2022
   E-mail Address:dubinj@etsu.edu
   ----------------------------------------------------------------------------
   Purpose -
       Deliverable 5
   -----------------------------------------------------------------------------
   Identifier dictionary -
       Not Applicable
   -----------------------------------------------------------------------------
   Notes and Assumptions – 
   -----------------------------------------------------------------------------
*/
DROP TABLE APARTMENT CASCADE CONSTRAINTS;
DROP TABLE APPLICANT CASCADE CONSTRAINTS;
DROP TABLE APPLICATION CASCADE CONSTRAINTS;
DROP TABLE BUILDING CASCADE CONSTRAINTS;
DROP TABLE DEPENDENT CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE MAINTENANCE_REQUEST CASCADE CONSTRAINTS;
DROP TABLE SUBMISSION CASCADE CONSTRAINTS;
DROP TABLE TENANT CASCADE CONSTRAINTS;


CREATE TABLE APARTMENT (
    Building_No       NUMBER(5,0),
    Apartment_No     NUMBER(5,0),
    Apartment_Type      CHAR(4),
    A_Size            VARCHAR2(50),
    Floor_Plan      CHAR(4),
    A_Availability    NUMBER(1,0),
    Rental_Fee      VARCHAR2(50),
    
    CONSTRAINT apt_pk PRIMARY KEY (Building_No, Apartment_No)
);

CREATE TABLE APPLICANT (
    Applicant_ID        NUMBER(5,0),
    First_Name          VARCHAR2(50),
    Last_Name           VARCHAR2(50),
    Phone               NUMBER(10,0),
    SSN                 NUMBER(9,0),
    Email               VARCHAR2(50),
    Street              VARCHAR2(50),
    City                VARCHAR2(50),
    ZIP                 NUMBER(5,0),
    App_State               CHAR(2),
    Occupation          VARCHAR2(50),
    Current_Employer    VARCHAR2(50),
    Annual_Income       VARCHAR2(15),
    
    CONSTRAINT apl_pk PRIMARY KEY (Applicant_ID)
);

CREATE TABLE APPLICATION (
    Application_ID              NUMBER(5,0),
    Application_Type            CHAR(4),
    Building_No                 NUMBER(5,0),
    Fee                         VARCHAR2(50),
    Status                      VARCHAR2(50),
    Preferred_MoveIn_Date       DATE,
    Apartment_ID                NUMBER(5,0),
    
    CONSTRAINT app_pk PRIMARY KEY (Application_ID),
    CONSTRAINT apt_fk FOREIGN KEY (Building_No, Apartment_ID) REFERENCES APARTMENT(Building_No, Apartment_No)
);

CREATE TABLE BUILDING (
    Building_No         NUMBER(5,0),
    B_Location            VARCHAR2(50),
    Floors              NUMBER(2,0),
    
    CONSTRAINT bld_pk PRIMARY KEY (Building_No)
);

CREATE TABLE EMPLOYEE (
    Employee_ID         NUMBER(5,0),
    First_Name          VARCHAR2(50),
    Last_Name           VARCHAR2(50),
    Email               VARCHAR2(50),
    Phone               NUMBER(10,0),
    DOB                 DATE,
    Street              VARCHAR2(50),
    City                VARCHAR2(50),
    Emp_State               CHAR(2),
    ZIP                 CHAR(5),
    Salary              VARCHAR2(50),
    Job_Title           VARCHAR2(50),
    
    CONSTRAINT emp_pk PRIMARY KEY (Employee_ID)
);

CREATE TABLE DEPENDENT (
    Employee_ID         NUMBER(5,0),
    First_Name          VARCHAR2(50),
    Last_Name           VARCHAR2(50),
    DOB                 DATE,
    Relationship        VARCHAR2(50),
    Street              VARCHAR2(50),
    City                VARCHAR2(50),
    Dep_State               CHAR(2),
    ZIP                 CHAR(5),
    
    CONSTRAINT dpd_pk PRIMARY KEY (Employee_ID, First_Name, Last_Name),
    CONSTRAINT emp_fk FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID)
);

CREATE TABLE TENANT (
    Tenant_ID               NUMBER(5,0),
    First_Name              VARCHAR2(50),
    Last_Name               VARCHAR2(50),
    Phone                   NUMBER(10,0),
    SSN                     NUMBER(9,0),
    Email                   VARCHAR2(50),
    DOB                     DATE,
    No_of_Dependents        NUMBER(2,0),
    Occupation              VARCHAR2(50),
    Current_Employer        VARCHAR2(50),
    Lease_Start_Date        DATE,
    Lease_End_Date          DATE,
    Security_Deposit        VARCHAR2(50),
    Apartment               NUMBER(5,0),
    Building_No             NUMBER(5,0),
    
    CONSTRAINT ten_pk PRIMARY KEY (Tenant_ID),
    CONSTRAINT apt_fk_2 FOREIGN KEY (Apartment, Building_No) REFERENCES APARTMENT(Apartment_No, Building_No)
 );   
 
CREATE TABLE MAINTENANCE_REQUEST (
    Request_ID              NUMBER(5,0),
    Issue_Type              VARCHAR2(10),
    Issue_Desc              VARCHAR2(250),
    Date_Requested          DATE,
    Date_Completed          DATE,
    Request_Status          VARCHAR2(10),
    Employee_Assigned       NUMBER(5,0),
    Tenant_ID               NUMBER(5,0),
    
    CONSTRAINT mnt_pk PRIMARY KEY (Request_ID),
    CONSTRAINT emp_fk_2 FOREIGN KEY (Employee_Assigned) REFERENCES Employee(Employee_ID),
    CONSTRAINT tnd_fk FOREIGN KEY (Tenant_ID) REFERENCES TENANT(Tenant_ID)
);

CREATE TABLE SUBMISSION (
    Application_ID          NUMBER(5,0),
    Applicant_ID            NUMBER(5,0),
    Sub_Date                    DATE,
    
    CONSTRAINT sub_pk PRIMARY KEY (Application_ID, Applicant_ID),
    CONSTRAINT app_fk FOREIGN KEY (Application_ID) REFERENCES APPLICATION(Application_ID),
    CONSTRAINT apl_fk FOREIGN KEY (Applicant_ID) REFERENCES APPLICANT(Applicant_ID)
);
    
CREATE INDEX idx_applicant_address      --CREATE INDEX
    ON APPLICANT(Applicant_ID,Street,City,App_State,ZIP);
    
CREATE INDEX idx_dependent_address       --CREATE INDEX
    ON DEPENDENT(Last_Name, First_Name, Street, City, Dep_State, ZIP);
    
CREATE INDEX idx_employee_address      --CREATE INDEX
    ON EMPLOYEE(Employee_ID, Street, City, Emp_State, ZIP);
    
CREATE INDEX idx_application_apartment       --CREATE INDEX
    ON APPLICATION(Application_ID, Apartment_ID);
    
CREATE INDEX idx_maintenace_employee       --CREATE INDEX
    ON MAINTENANCE_REQUEST(Request_ID, Employee_Assigned);
    
CREATE INDEX idx_maintenace_tenant     --CREATE INDEX
    ON MAINTENANCE_REQUEST(Request_ID, Tenant_ID);
    
CREATE INDEX idx_tenant_apartment     --CREATE INDEX
    ON TENANT(Apartment, Tenant_ID);  
    
------------------------------------------------------------------------------------------------

INSERT INTO Apartment
VALUES ('00001', '00001', 'NORM', 'Large',
	  '1st', '4', '$550');
      
INSERT INTO Apartment
VALUES ('00001', '00002', 'NORM', 'Large',
	  '1st', '4', '$550');
      
INSERT INTO Applicant
VALUES ('00001', 'Justin', 'Dubin', '4236763529',
	  '123456789', 'dubinj@etsu.edu', 'Test Drive', 'Johnson City', 
      '37614', 'TN', 'Student', 'ETSU', '30,000');
      
INSERT INTO Application
VALUES ('00001', 'NORM', '00001', '$550', 'Processing', 
      '', '00001');
      
INSERT INTO Building
VALUES ('00001', '123 Test Dr', '20');

INSERT INTO Employee
VALUES ('00001', 'Justin', 'Dubin', 'dubinj@etsu.edu', 
'4236763529', '', '123 Test Drive', 'Johnson City', 'TN', 
'37615', '30,000', 'Student');

INSERT INTO Dependent
VALUES ('00001', 'Justin', 'Dubin', '', 'Myself', 
'123 Test Street', 'Johnson City', 'TN', '37615');

INSERT INTO Submission
VALUES ('00001', '00001', '');

INSERT INTO Tenant
VALUES ('00001', 'Justin', 'Dubin', '4236763529', '123456789',
'dubinj@etsu.edu', '', '0', 'Student', 'ETSU', '', '', 
'$550', '00001', '00001');

INSERT INTO Maintenance_Request
VALUES ('00001', 'Utility', 'Door squeks when opened', '', 
'', 'Processing', '00001', '00001');

UPDATE Maintenance_Request
SET Issue_Type = 'Plumbing'
WHERE Request_ID = '00001';

UPDATE Maintenance_Request
SET Request_Status = 'Pending'
WHERE Request_ID = '00001';

DELETE FROM Apartment
WHERE Apartment_No = '00002';

