/*
 *  File name:  setup.sql
 *  Function:   to create the initial database schema for the CMPUT 391 project,
 *              Winter Term, 2014
 *  Author:     Prof. Li-Yan Yuan
 */
DROP TABLE family_doctor;
DROP TABLE pacs_images;
DROP TABLE radiology_record;
DROP TABLE users;
DROP TABLE persons;

/*
 *  To store the personal information
 */
CREATE TABLE persons (
   person_id int,
   first_name varchar(24),
   last_name  varchar(24),
   address    varchar(128),
   email      varchar(128),
   phone      char(10),
   PRIMARY KEY(person_id),
   UNIQUE (email)
);

/*
 *  To store the log-in information
 *  Note that a person may have been assigned different user_name(s), depending
 *  on his/her role in the log-in  
 */
CREATE TABLE users (
   user_name varchar(24),
   password  varchar(24),
   class     char(1),
   person_id int,
   date_registered date,
   CHECK (class in ('a','p','d','r')),
   PRIMARY KEY(user_name),
   FOREIGN KEY (person_id) REFERENCES persons
);

/*
 *  to indicate who is whose family doctor.
 */
CREATE TABLE family_doctor (
   doctor_id    int,
   patient_id   int,
   FOREIGN KEY(doctor_id) REFERENCES persons,
   FOREIGN KEY(patient_id) REFERENCES persons,
   PRIMARY KEY(doctor_id,patient_id)
);

/*
 *  to store the radiology records
 */
CREATE TABLE radiology_record (
   record_id   int,
   patient_id  int,
   doctor_id   int,
   radiologist_id int,
   test_type   varchar(24),
   prescribing_date date,
   test_date    date,
   diagnosis    varchar(128),
   description   varchar(1024),
   PRIMARY KEY(record_id),
   FOREIGN KEY(patient_id) REFERENCES persons,
   FOREIGN KEY(doctor_id) REFERENCES  persons,
   FOREIGN KEY(radiologist_id) REFERENCES  persons
);

/*
 *  to store the pacs images
 */
CREATE TABLE pacs_images (
   record_id   int,
   image_id    int,
   thumbnail   blob,
   regular_size blob,
   full_size    blob,
   PRIMARY KEY(record_id,image_id),
   FOREIGN KEY(record_id) REFERENCES radiology_record
);

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (1, 'David', 'Pho', 'Vietnam', 'phoboy@ualberta.ca', '7800000000');
INSERT INTO users (user_name, password, class, person_id) VALUES ('me', 'you', 'a', 1);


INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (2, 'Kevin', 'Lau', '123 Street', 'fakeemail@mail.com', '7805553333');


INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (3, 'Blah', 'McBlaher', '143 Street', 'realgmail@mail.com', '7803253334');

INSERT INTO radiology_record (record_id, patient_id, test_date, diagnosis) VALUES (23, 1, to_date('2013', 'YYYY'), 'cancer');


INSERT INTO radiology_record (record_id, patient_id, test_date, diagnosis) VALUES (24, 2, to_date('2013', 'YYYY'), 'cancer');

