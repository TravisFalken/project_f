/*--------------------------------------------
    Create Extension for Location data
---------------------------------------------*/
CREATE EXTENSION postgis;



/*--------------------------------------------------------------
    Create User Table
--------------------------------------------------------------*/

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

CREATE TABLE _location
(
    location_id serial NOT NULL,
    location geometry NOT NULL
);


/*-----------------------------------------------------------------
    Create User Account Table || Joins user and the account tables
-------------------------------------------------------------------*/

CREATE TABLE _user_account
(
    user_id integer NOT NULL,
    account_id integer NOT NULL,
    PRIMARY KEY (user_id, account_id)
);


/*----------------------------------------------------------------
    Create Account Table
-----------------------------------------------------------------*/

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

CREATE TABLE _salary_record
(
    salary_record_id serial NOT NULL,
    salary_recorded_amount money NOT NULL,
    salary_record_owner integer NOT NULL,
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

CREATE TABLE payment_day
(
    payment_day_id serial NOT NULL,
    payment_day character varying(30) NOT NULL,
    PRIMARY KEY (payment_day_id)
);


/*-------------------------------------------------------------
    Create Expense Table
--------------------------------------------------------------*/

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

CREATE TABLE _expense_photo
(
    expense_id integer NOT NULL,
    photo_path character varying(255) NOT NULL,
    PRIMARY KEY (expense_id, photo_path)
);

/*------------------------------------------------------------------------
    Create Photo
-------------------------------------------------------------------------*/

CREATE TABLE _photo
(
    path character varying(255) NOT NULL,
    photo_description character varying(255),
    PRIMARY KEY (path)
);

/*------------------------------------------------------------------------
    Create Direct Debit Table
-------------------------------------------------------------------------*/

CREATE TABLE _direct_debit
(
    direct_debit_id serial NOT NULL,
    direct_debit_title character varying(55) NOT NULL,
    direct_debit_description character varying(255),
    total_amount money NOT NULL,
    amount_remaining money NOT NULL,
    interest_rate real NOT NULL,
    direct_debit_date_created date NOT NULL,
    direct_debit_last_update date,
    timeframe_id integer NOT NULL,
    payment_day_id integer NOT NULL,
    direct_debit_type integer NOT NULL,
    account_id integer NOT NULL,
    user_confirmed boolean NOT NULL DEFAULT FALSE,
    PRIMARY KEY (direct_debit_id)
);

/*-----------------------------------------------------------------------
    Create Direct Debit Type
------------------------------------------------------------------------*/

CREATE TABLE _direct_debit_type
(
    direct_debit_type_id serial NOT NULL,
    direct_debit_type character varying(55) NOT NULL,
    direct_debit_type_description character varying(255) NOT NULL,
    PRIMARY KEY (direct_debit_type_id)
);

/*-----------------------------------------------------------------------
    Create Direct Debit Photo Table
------------------------------------------------------------------------*/

CREATE TABLE _direct_debit_photo
(
    direct_debit_id integer NOT NULL,
    photo_path character varying(255) NOT NULL,
    PRIMARY KEY (direct_debit_id, photo_path)
);

