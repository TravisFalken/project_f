/*--------------------------------------------
    Create Extension for Location data
---------------------------------------------*/
CREATE EXTENSION postgis;



/*--------------------------------------------------------------
    Create User Table
--------------------------------------------------------------*/
DROP TABLE IF EXISTS _user
CASCADE;

CREATE TABLE _user
(
    user_id serial NOT NULL,
    username character varying(50) NOT NULL UNIQUE,
    email character varying(255) NOT NULL UNIQUE,
    password character varying(280) NOT NULL,
    given_name character varying(200) NOT NULL,
    family_name character varying(200) NOT NULL,
    phone_num character varying(50),
    date_of_birth date,
    created_date date NOT NULL,
    address_id integer,
    profile_photo character varying(255) UNIQUE,
    PRIMARY KEY (user_id)
);

/*-----------------------------------------------------------
    Create Address Table
-------------------------------------------------------------*/

DROP TABLE IF EXISTS _address
CASCADE;

CREATE TABLE _address
(
    address_id serial NOT NULL,
    street_num character varying(20) NOT NULL,
    street_name character varying(250) NOT NULL,
    suburb character varying(250) NOT NULL,
    city character varying(250) NOT NULL,
    country character varying(100) NOT NULL,
    region character varying(150) NOT NULL,
    postal_code character varying(10) NOT NULL,
    location_id integer NOT NULL,
    PRIMARY KEY (address_id)
);


/*--------------------------------------------------------------
    Create Location Table
---------------------------------------------------------------*/
DROP TABLE IF EXISTS _location
CASCADE;

CREATE TABLE _location
(
    location_id serial NOT NULL,
    location geometry NOT NULL,
    PRIMARY KEY(location_id)
);


/*-----------------------------------------------------------------
    Create User Account Table || Joins user and the account tables
-------------------------------------------------------------------*/
DROP TABLE IF EXISTS _user_account
CASCADE;

CREATE TABLE _user_account
(
    user_id integer NOT NULL,
    account_id integer NOT NULL,
    PRIMARY KEY (user_id, account_id)
);


/*----------------------------------------------------------------
    Create Account Table
-----------------------------------------------------------------*/
DROP TABLE IF EXISTS _account
CASCADE;

CREATE TABLE _account
(
    account_id serial NOT NULL,
    owner integer NOT NULL,
    account_name character varying(55) NOT NULL,
    account_description character varying(255),
    created_date date NOT NULL,
    last_updated date,
    balance money NOT NULL,
    PRIMARY KEY (account_id)
);


/*----------------------------------------------------------------
    Create Salary Table
----------------------------------------------------------------*/
DROP TABLE IF EXISTS _salary
CASCADE;

CREATE TABLE _salary
(
    salary_id serial NOT NULL,
    salary_amount money NOT NULL,
    salary_owner integer NOT NULL,
    payment_day_id integer NOT NULL,
    salary_created date NOT NULL,
    salary_last_updated date,
    employer character varying(55),
    account_id integer NOT NULL,
    time_frame_id integer NOT NULL,
    PRIMARY KEY (salary_id)
);


/*----------------------------------------------------------------
    Create Salary Record Table
-----------------------------------------------------------------*/
DROP TABLE IF EXISTS _salary_record
CASCADE;

CREATE TABLE _salary_record
(
    salary_record_id serial NOT NULL,
    salary_recorded_amount money NOT NULL,
    salary_id integer NOT NULL,
    salary_recieved_date date NOT NULL,
    record_last_updated date NOT NULL,
    salary_owner integer NOT NULL,
    employer character varying(55),
    salary_record_timeframe_id integer NOT NULL,
    salary_record_payment_day_id integer NOT NULL,
    user_comfirmed_record boolean NOT NULL DEFAULT false,
    PRIMARY KEY (salary_record_id)
);

/*-----------------------------------------------------------------
    Create Timeframe Table
------------------------------------------------------------------*/
DROP TABLE IF EXISTS _timeframe
CASCADE;

CREATE TABLE _timeframe
(
    timeframe_id serial NOT NULL,
    timeframe character varying(30) NOT NULL,
    timeframe_description character varying(255) NOT NULL,
    PRIMARY KEY (timeframe_id)
);


/*---------------------------------------------------------------
    Create Payment Day Table
----------------------------------------------------------------*/
DROP TABLE IF EXISTS _payment_day
CASCADE;

CREATE TABLE _payment_day
(
    payment_day_id serial NOT NULL,
    payment_day character varying(30) NOT NULL,
    PRIMARY KEY (payment_day_id)
);


/*-------------------------------------------------------------
    Create Expense Table
--------------------------------------------------------------*/
DROP TABLE IF EXISTS _expense
CASCADE;

CREATE TABLE _expense
(
    expense_id serial NOT NULL,
    expense_title character varying(55) NOT NULL,
    expense_description character varying(255),
    expense_owner integer NOT NULL,
    expense_amount money NOT NULL,
    expense_created date NOT NULL,
    expense_last_updated date NOT NULL,
    expense_type integer NOT NULL,
    account_id integer NOT NULL,
    place_of_purchase character varying(55),
    PRIMARY KEY (expense_id)
);


/*------------------------------------------------------------------
    Create Expense Type Table
-------------------------------------------------------------------*/
DROP TABLE IF EXISTS _expense_type
CASCADE;

CREATE TABLE _expense_type
(
    expense_type_id serial NOT NULL,
    expense_type character varying(55) NOT NULL,
    expense_type_description character varying(255) NOT NULL,
    PRIMARY KEY (expense_type_id)
);

/*---------------------------------------------------------------------
    Create Expense Photo
----------------------------------------------------------------------*/
DROP TABLE IF EXISTS _expense_photo
CASCADE;

CREATE TABLE _expense_photo
(
    expense_id integer NOT NULL,
    photo_path character varying(255) NOT NULL,
    PRIMARY KEY (expense_id, photo_path)
);

/*------------------------------------------------------------------------
    Create Photo
-------------------------------------------------------------------------*/
DROP TABLE IF EXISTS _photo
CASCADE;

CREATE TABLE _photo
(
    photo_path character varying(255) NOT NULL,
    photo_description character varying(255),
    PRIMARY KEY (photo_path)
);

/*------------------------------------------------------------------------
    Create Direct Debit Table
-------------------------------------------------------------------------*/
DROP TABLE IF EXISTS _direct_debit
CASCADE;

CREATE TABLE _direct_debit
(
    direct_debit_id serial NOT NULL,
    direct_debit_title character varying(55) NOT NULL,
    direct_debit_description character varying(255),
    total_amount money NOT NULL,
    owner integer NOT NULL,
    amount_remaining money NOT NULL,
    interest_rate real NOT NULL,
    direct_debit_date_created date NOT NULL,
    direct_debit_last_update date,
    timeframe_id integer NOT NULL,
    payment_day_id integer NOT NULL,
    direct_debit_type_id integer NOT NULL,
    account_id integer NOT NULL,
    user_confirmed boolean NOT NULL DEFAULT FALSE,
    PRIMARY KEY (direct_debit_id)
);

/*-----------------------------------------------------------------------
    Create Direct Debit Type
------------------------------------------------------------------------*/
DROP TABLE IF EXISTS _direct_debit_type
CASCADE;

CREATE TABLE _direct_debit_type
(
    direct_debit_type_id serial NOT NULL,
    direct_debit_type character varying(55) NOT NULL,
    direct_debit_type_description character varying(255) NOT NULL,
    PRIMARY KEY (direct_debit_type_id)
);

/*-----------------------------------------------------------------------
    Create Direct Debit Record Table
-------------------------------------------------------------------------*/
DROP TABLE IF EXISTS _direct_debit_record
CASCADE;

CREATE TABLE _direct_debit_record
(
    direct_debit_record_id serial NOT NULL,
    direct_debit_record_title character varying(55) NOT NULL,
    direct_debit_record_description character varying(255),
    total_amount_before_payment money NOT NULL,
    total_paid money NOT NULL,
    debit_record_created date NOT NULL,
    debit_record_last_updated date,
    direct_debit_id integer NOT NULL,
    interest_rate real,
    timeframe_id integer NOT NULL,
    payment_day_id integer NOT NULL,
    owner integer NOT NULL,
    user_confirmed boolean NOT NULL,
    direct_debit_type_id integer NOT NULL,
    payment_to character varying(55),
    PRIMARY KEY (direct_debit_record_id)
);

/*-----------------------------------------------------------------------
    Create Direct Debit Photo Table
------------------------------------------------------------------------*/
DROP TABLE IF EXISTS _direct_debit_photo
CASCADE;

CREATE TABLE _direct_debit_photo
(
    direct_debit_record_id integer NOT NULL,
    photo_path character varying(255) NOT NULL,
    PRIMARY KEY (direct_debit_record_id, photo_path)
);


/*--------------------------------------------------
    Create Deposit Tabel
---------------------------------------------------*/
DROP TABLE IF EXISTS _deposit
CASCADE;

CREATE TABLE _deposit
(
    deposit_id serial NOT NULL,
    deposit_amount money NOT NULL,
    owner integer NOT NULL,
    deposit_title character varying(55) NOT NULL,
    deposit_description character varying(255),
    payee character varying(55),
    deposit_recieved_date date NOT NULL,
    deposit_last_updated date,
    account_id integer NOT NULL,
    deposit_type_id integer NOT NULL,
    PRIMARY KEY (deposit_id)
);

/*----------------------------------------------
    Create Deposit Type Table
-----------------------------------------------*/
DROP TABLE IF EXISTS _deposit_type
CASCADE;

CREATE TABLE _deposit_type
(
    deposit_type_id serial NOT NULL,
    deposit_type character varying(55) NOT NULL,
    deposit_type_description character varying(255) NOT NULL,
    PRIMARY KEY (deposit_type_id)
);

/*---------------------------------------------------
    Create deposit photo table
----------------------------------------------------*/
DROP TABLE IF EXISTS _deposit_photo
CASCADE;

CREATE TABLE _deposit_photo
(
    deposit_id integer NOT NULL,
    photo_path character varying(255) NOT NULL,
    PRIMARY KEY (deposit_id, photo_path)
);


/*------------------------------------------------------
    Create direct credit table
------------------------------------------------------*/
DROP TABLE IF EXISTS _direct_credit
CASCADE;

CREATE TABLE _direct_credit
(
    direct_credit_id serial NOT NULL,
    direct_credit_amount money NOT NULL,
    owner integer NOT NULL,
    total_amount_recieved money NOT NULL,
    direct_credit_title character varying(55) NOT NULL,
    direct_credit_description character varying(255),
    direct_credit_type_id integer NOT NULL,
    account_id integer NOT NULL,
    timeframe_id integer NOT NULL,
    payment_day_id integer NOT NULL,
    direct_credit_created_date date NOT NULL,
    direct_credit_last_updated date,
    payee character varying(55),
    PRIMARY KEY (direct_credit_id)
);

/*----------------------------------------
    Create direct credit type table
-----------------------------------------*/
DROP TABLE IF EXISTS _direct_credit_type
CASCADE;

CREATE TABLE _direct_credit_type
(
    direct_credit_type_id serial NOT NULL,
    direct_credit_type character varying(55) NOT NULL,
    direct_credit_type_description character varying(255) NOT NULL,
    PRIMARY KEY (direct_credit_type_id)
);

/*-----------------------------------------------
    Create direct credit record table
------------------------------------------------*/
DROP TABLE IF EXISTS _direct_credit_record
CASCADE;

CREATE TABLE _direct_credit_record
(
    direct_credit_record_id serial NOT NULL,
    amount_recieved money NOT NULL,
    owner integer NOT NULL,
    direct_credit_id integer NOT NULL,
    direct_credit_record_title character varying(55) NOT NULL,
    direct_credit_record_description character varying(255),
    recieved_payment_date date NOT NULL,
    direct_credit_record_last_updated date,
    direct_credit_type_id integer NOT NULL,
    timeframe_id integer NOT NULL,
    payment_day_id integer NOT NULL,
    user_comfirmed_payment boolean NOT NULL,
    direct_credit_record_payee character varying(55),
    PRIMARY KEY (direct_credit_record_id)
);


/*------------------------------------------------
    Create direct credit record photo
-------------------------------------------------*/
DROP TABLE IF EXISTS _direct_credit_record_photo
CASCADE;

CREATE TABLE _direct_credit_record_photo
(
    direct_credit_record_id integer NOT NULL,
    photo_path character varying(255) NOT NULL,
    PRIMARY KEY (direct_credit_record_id, photo_path)
);


/*---------------------------------------------------
    Create Saving Goal Table
----------------------------------------------------*/
DROP TABLE IF EXISTS _saving_goal
CASCADE;

CREATE TABLE _saving_goal
(
    saving_goal_id serial NOT NULL,
    account_id integer NOT NULL,
    amount_saved money NOT NULL,
    saving_goal money NOT NULL,
    saving_goal_title character varying(55) NOT NULL,
    saving_goal_description character varying(255),
    timeframe_id integer NOT NULL,
    PRIMARY KEY (saving_goal_id)
);



/*====================================================================
      
        Alter The Database Tables

======================================================================*/

/*----------------------------------------
    Alter the user table
------------------------------------------*/

--Address foreign key
ALTER TABLE _user ADD
CONSTRAINT fk_address_id FOREIGN KEY(address_id) REFERENCES _address(address_id)
ON DELETE CASCADE;

--photo foreign key
ALTER TABLE _user ADD
CONSTRAINT fk_profile_photo FOREIGN KEY(profile_photo) REFERENCES _photo(photo_path)
ON DELETE CASCADE;


/*--------------------------------------------------
    Alter the address table
---------------------------------------------------*/

-- location foreign key
ALTER TABLE _address ADD
CONSTRAINT fk_location_id FOREIGN KEY(location_id) REFERENCES _location(location_id)
ON DELETE CASCADE;


/*-------------------------------------------------
    Alter the user account table
--------------------------------------------------*/

--user id foreign key
ALTER TABLE _user_account ADD
CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES _user(user_id)
ON DELETE CASCADE;

--account id foreign key
ALTER TABLE _account ADD
CONSTRAINT fk_account_id FOREIGN KEY(account_id) REFERENCES _account(account_id);


/*----------------------------------------------
    Alter the account table
-----------------------------------------------*/

--Owner foreign key
ALTER TABLE _account ADD
CONSTRAINT fk_owner FOREIGN KEY(owner) REFERENCES _user(user_id)
ON DELETE CASCADE;


/*-------------------------------------------
    Alter the salary table
--------------------------------------------*/

--Salary owner foreign key
ALTER TABLE _salary ADD
CONSTRAINT fk_salary_owner FOREIGN KEY(salary_owner) REFERENCES _user(user_id)
ON DELETE CASCADE;

--Payment day foreign key
ALTER TABLE _salary ADD
CONSTRAINT fk_payment_day_id FOREIGN KEY(payment_day_id) REFERENCES _payment_day(payment_day_id);

--Account id foreign key
ALTER TABLE _salary ADD
CONSTRAINT fk_account_id FOREIGN KEY(account_id) REFERENCES _account(account_id)
ON DELETE CASCADE;

--Timeframe id foreign key
ALTER TABLE _salary ADD
CONSTRAINT fk_timeframe_id FOREIGN KEY(time_frame_id) REFERENCES _timeframe(timeframe_id);


/*-------------------------------------------------------------
    Alter the salary record table
-------------------------------------------------------------*/

--Salary ID foreign key
ALTER TABLE _salary_record ADD
CONSTRAINT fk_salary_id FOREIGN KEY(salary_id) REFERENCES _salary(salary_id)
ON DELETE CASCADE;

--time frame foreign key
ALTER TABLE _salary_record ADD
CONSTRAINT fk_time_frame_id FOREIGN KEY(salary_record_timeframe_id) REFERENCES _timeframe(timeframe_id);

--payment day foreign key
ALTER TABLE _salary_record ADD
CONSTRAINT fk_payment_day_id FOREIGN KEY(salary_record_payment_day_id) REFERENCES _payment_day(payment_day_id);

--Salary owner id foreign key
ALTER TABLE _salary_record ADD
CONSTRAINT fk_owner_id FOREIGN KEY(salary_owner) REFERENCES _user(user_id)
ON DELETE CASCADE;


/*-------------------------------------------------------------
    Alter the expense table
------------------------------------------------------------*/

--Expense owner id foreign key
ALTER TABLE _expense ADD
CONSTRAINT fk_expense_owner FOREIGN KEY(expense_owner) REFERENCES _user(user_id)
ON DELETE CASCADE;

--Expense type id foreign key
ALTER TABLE _expense ADD
CONSTRAINT fk_expense_type FOREIGN KEY(expense_type) REFERENCES _expense_type(expense_type_id);

--Account id foreign key
ALTER TABLE _expense ADD
CONSTRAINT fk_account_id FOREIGN KEY(account_id) REFERENCES _account(account_id)
ON DELETE CASCADE;


/*---------------------------------------------------------------
    Alter Expense Photo Table
--------------------------------------------------------------*/

--Expense id foreign key
ALTER TABLE _expense_photo ADD
CONSTRAINT fk_expense_id FOREIGN KEY(expense_id) REFERENCES _expense(expense_id)
ON DELETE CASCADE;

--Photo path foreign key
ALTER TABLE _expense_photo ADD
CONSTRAINT fk_photo_path FOREIGN KEY(photo_path) REFERENCES _photo(photo_path)
ON DELETE CASCADE;


/*-------------------------------------------------------------
    Alter Direct Debit Table
--------------------------------------------------------------*/

--Timeframe id foreign key
ALTER TABLE _direct_debit ADD
CONSTRAINT fk_timeframe_id FOREIGN KEY(timeframe_id) REFERENCES _timeframe(timeframe_id);

--Payment day id foreign key
ALTER TABLE _direct_debit ADD
CONSTRAINT fk_payment_day_id FOREIGN KEY(payment_day_id) REFERENCES _payment_day(payment_day_id);

--Direct debit type id foreign key
ALTER TABLE _direct_debit ADD
CONSTRAINT fk_direct_debit_type_id FOREIGN KEY(direct_debit_type_id) REFERENCES _direct_debit_type(direct_debit_type_id);

--Owner id foreign key
ALTER TABLE _direct_debit ADD
CONSTRAINT fk_owner FOREIGN KEY(owner) REFERENCES _user(user_id);

--Account ID foreign key
ALTER TABLE _direct_debit ADD
CONSTRAINT fk_account_id FOREIGN KEY(account_id) REFERENCES _account(account_id)
ON DELETE CASCADE;

/*-----------------------------------------------------------------
    ALTER the direct debit record table
----------------------------------------------------------------*/


--Timeframe id foreign key
ALTER TABLE _direct_debit_record ADD
CONSTRAINT fk_timeframe_id FOREIGN KEY(timeframe_id) REFERENCES _timeframe(timeframe_id);

--Payment day id foreign key
ALTER TABLE _direct_debit_record ADD
CONSTRAINT fk_payment_day_id FOREIGN KEY(payment_day_id) REFERENCES _payment_day(payment_day_id);

--Direct debit type id foreign key
ALTER TABLE _direct_debit_record ADD
CONSTRAINT fk_direct_debit_type_id FOREIGN KEY(direct_debit_type_id) REFERENCES _direct_debit_type(direct_debit_type_id);

--Owner id foreign key
ALTER TABLE _direct_debit_record ADD
CONSTRAINT fk_owner FOREIGN KEY(owner) REFERENCES _user(user_id);

--direct debit ID foreign key
ALTER TABLE _direct_debit_record ADD
CONSTRAINT fk_direct_debit_id FOREIGN KEY(direct_debit_id) REFERENCES _direct_debit(direct_debit_id)
ON DELETE CASCADE;


/*--------------------------------------------------------------
    Alter Direct Debit Photo Table
----------------------------------------------------------------*/

--direct debit record id foreign key
ALTER TABLE _direct_debit_photo ADD
CONSTRAINT fk_direct_debit_record_id FOREIGN KEY(direct_debit_record_id) REFERENCES _direct_debit_record(direct_debit_record_id)
ON DELETE CASCADE;

--photo path foreign key
ALTER TABLE _direct_debit_photo ADD
CONSTRAINT fk_photo_path FOREIGN KEY(photo_path) REFERENCES _photo(photo_path)
ON DELETE CASCADE;


/*-------------------------------------------------------
    ALTER Deposit table
------------------------------------------------------*/

--Owner foreign key
ALTER TABLE _deposit ADD
CONSTRAINT fk_owner FOREIGN KEY(owner) REFERENCES _user(user_id)
ON DELETE CASCADE;

--Account ID foreign key
ALTER TABLE _deposit ADD
CONSTRAINT fk_account_id FOREIGN KEY(account_id) REFERENCES _account(account_id)
ON DELETE CASCADE;

--Deposit type id foreign key
ALTER TABLE _deposit ADD
CONSTRAINT fk_deposit_type_id FOREIGN KEY(deposit_type_id) REFERENCES _deposit_type(deposit_type_id);

/*------------------------------------------------------------------
    ALTER Deposit Photo Table
------------------------------------------------------------------*/

--Deposit id foreign key
ALTER TABLE _deposit_photo ADD
CONSTRAINT fk_deposit_id FOREIGN KEY(deposit_id) REFERENCES _deposit(deposit_id)
ON DELETE CASCADE;

--Photo Path foreign key
ALTER TABLE _deposit_photo ADD
CONSTRAINT fk_photo_path FOREIGN KEY(photo_path) REFERENCES _photo(photo_path)
ON DELETE CASCADE;


/*--------------------------------------------------
    Alter direct credit table
---------------------------------------------------*/

--Owner foreign key
ALTER TABLE _direct_credit ADD
CONSTRAINT fk_owner FOREIGN KEY(owner) REFERENCES _user(user_id)
ON DELETE CASCADE;

--Direct credit type id foreign key
ALTER TABLE _direct_credit ADD
CONSTRAINT fk_direct_credit_type_id FOREIGN KEY(direct_credit_type_id) REFERENCES _direct_credit_type(direct_credit_type_id);

--Account id foreign key
ALTER TABLE _direct_credit ADD
CONSTRAINT fk_account_id FOREIGN KEY(account_id) REFERENCES _account(account_id)
ON DELETE CASCADE;

--Timeframe foreign key
ALTER TABLE _direct_credit ADD
CONSTRAINT fk_timeframe_id FOREIGN KEY(timeframe_id) REFERENCES _timeframe(timeframe_id);

--Payment day foreign key
ALTER TABLE _direct_credit ADD
CONSTRAINT fk_payment_day FOREIGN KEY(payment_day_id) REFERENCES _payment_day(payment_day_id);


/*------------------------------------------------------------------
   Alter  _direct_credit_record Table
-------------------------------------------------------------------*/

--Owner foreign key
ALTER TABLE _direct_credit_record ADD
CONSTRAINT fk_owner FOREIGN KEY(owner) REFERENCES _user(user_id)
ON DELETE CASCADE;

--Direct credit type id foreign key
ALTER TABLE _direct_credit_record ADD
CONSTRAINT fk_direct_credit_type_id FOREIGN KEY(direct_credit_type_id) REFERENCES _direct_credit_type(direct_credit_type_id);

--direct credit id foreign key
ALTER TABLE _direct_credit_record ADD
CONSTRAINT fk_direct_credit_id FOREIGN KEY(direct_credit_id) REFERENCES _direct_credit(direct_credit_id)
ON DELETE CASCADE;

--Timeframe foreign key
ALTER TABLE _direct_credit_record ADD
CONSTRAINT fk_timeframe_id FOREIGN KEY(timeframe_id) REFERENCES _timeframe(timeframe_id);

--Payment day foreign key
ALTER TABLE _direct_credit_record ADD
CONSTRAINT fk_payment_day FOREIGN KEY(payment_day_id) REFERENCES _payment_day(payment_day_id);

/*---------------------------------------------------------
   Alter _direct_credit_record_photo Table
------------------------------------------------------------*/

-- Direct credit record id foreign key
ALTER TABLE _direct_credit_record_photo ADD
CONSTRAINT fk_direct_credit_record_id FOREIGN KEY(direct_credit_record_id) REFERENCES _direct_credit_record(direct_credit_record_id)
ON DELETE CASCADE;

--Photo path foreign key
ALTER TABLE _direct_credit_record_photo ADD
CONSTRAINT fk_photo_path FOREIGN KEY(photo_path) REFERENCES _photo(photo_path)
ON DELETE CASCADE;


/*-----------------------------------------------------------
   Alter _saving_goal Table
------------------------------------------------------------*/

-- Account id foreign key
ALTER TABLE _saving_goal ADD
CONSTRAINT fk_account_id FOREIGN KEY(account_id) REFERENCES _account(account_id)
ON DELETE CASCADE;

-- Timeframe id foreign key
ALTER TABLE _saving_goal ADD
CONSTRAINT fk_timeframe_id FOREIGN KEY(timeframe_id) REFERENCES _timeframe(timeframe_id);