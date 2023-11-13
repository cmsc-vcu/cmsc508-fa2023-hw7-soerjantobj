# hw7-ddl.sql

## DO NOT RENAME OR OTHERWISE CHANGE THE SECTION TITLES OR ORDER.
## The autograder will look for specific code sections. If it can't find them, you'll get a "0"

# Code specifications.
# 0. Where there a conflict between the problem statement in the google doc and this file, this file wins.
# 1. Complete all sections below.
# 2. Table names must MATCH EXACTLY to schemas provided.
# 3. Define primary keys in each table as appropriate.
# 4. Define foreign keys connecting tables as appropriate.
# 5. Assign ID to skills, people, roles manually (you must pick the ID number!)
# 6. Assign ID in the peopleskills and peopleroles automatically (use auto_increment)
# 7. Data types: ONLY use "int", "varchar(255)", "varchar(4096)" or "date" as appropriate.

# Section 1
# Drops all tables.  This section should be amended as new tables are added.

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS peopleskills;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS peopleroles;
SET FOREIGN_KEY_CHECKS=1;

# Section 2
# Create skills( id,name, description, tag, url, time_commitment)
# ID, name, description and tag cannot be NULL. Other fields can default to NULL.
# tag is a skill category grouping.  You can assign it based on your skill descriptions.
# time committment offers some sense of how much time was required (or will be required) to gain the skill.
# You can assign the skill descriptions.  Please be creative!

CREATE TABLE skills(
    id int NOT NULL,
    name varchar(225) NOT NULL,
    description varchar(225) NOT NULL,
    tag varchar(225) NOT NULL,
    url varchar(225),
    time_commitment date,
    PRIMARY KEY (id)
)

# Section 3
# Populate skills
# Populates the skills table with eight skills, their tag fields must exactly contain “Skill 1”, “Skill 2”, etc.
# You can assign skill names.  Please be creative!

INSERT INTO skills(id, name, description, tag, url, time_commitment) values(1, "writing", "write", "Skill 1", NULL, NULL);
INSERT INTO skills(id, name, description, tag, url, time_commitment) values(2, "drawing", "draw", "Skill 2", NULL, NULL);
INSERT INTO skills(id, name, description, tag, url, time_commitment) values(3, "coding", "code", "Skill 3", NULL, NULL);
INSERT INTO skills(id, name, description, tag, url, time_commitment) values(4, "throwing", "throw", "Skill 4", NULL, NULL);
INSERT INTO skills(id, name, description, tag, url, time_commitment) values(5, "catching", "catch", "Skill 5", NULL, NULL);
INSERT INTO skills(id, name, description, tag, url, time_commitment) values(6, "kicking", "kick", "Skill 6", NULL, NULL);
INSERT INTO skills(id, name, description, tag, url, time_commitment) values(7, "punching", "punch", "Skill 7", NULL, NULL);
INSERT INTO skills(id, name, description, tag, url, time_commitment) values(8, "painting", "paint", "Skill 8", NULL, NULL);
# Section 4
# Create people( id,first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined)
# ID cannot be null, Last name cannot be null, date joined cannot be NULL.
# All other fields can default to NULL.

CREATE TABLE people (
    people_id int NOT NULL,
    people_first_name varchar (256),
    people_last_name varchar(256) NOT NULL,
    email varchar(256),
    linkedin_url varchar(256),
    headshot_url varchar(256),
    discord_handle varchar(256),
    brief_bio varchar(256),
    date_joined date default (current_date) NOT NULL,
    PRIMARY KEY (people_id)
);

# Section 5
# Populate people with six people.
# Their last names must exactly be “Person 1”, “Person 2”, etc.
# Other fields are for you to assign.

insert into people (people_id,people_last_name, email) values (1,'Person 1', 'john.doe123@example.com'), (2,'Person 2', 'alice.smith456@gmail.com'), (3,'Person 3', 'emily.jones789@hotmail.com'), (4,'Person 4', 'david.brown987@yahoo.com'), (5,'Person 5', 'sarah.green234@outlook.com'), (6,'Person 6', 'chris.miller567@mail.com'), (7,'Person 7', 'lisa.wilson890@aol.com'), (8,'Person 8', 'kevin.jenkins123@protonmail.com'), (9,'Person 9', 'laura.white678@icloud.com'), (10,'Person 10', 'brian.taylor345@yandex.com');

# Section 6
# Create peopleskills( id, skills_id, people_id, date_acquired )
# None of the fields can ba NULL. ID can be auto_increment.

CREATE TABLE peopleskills(
    id int NOT NULL auto_increment,
    skills_id int NOT NULL,
    people_id int NOT NULL,
    date_acquired date default (current_date) NOT NULL,
    PRIMARY KEY (id)
)


# Section 7

# Populate peopleskills such that:
# Person 1 has skills 1,3,6;

INSERT INTO peopleskills (skills_id, people_id) values (1, 1), (3, 1), (6, 1);

# Person 2 has skills 3,4,5;

INSERT INTO peopleskills (skills_id, people_id) values (3, 2), (4, 2), (5, 2);

# Person 3 has skills 1,5;

INSERT INTO peopleskills (skills_id, people_id) values (1, 3), (5, 3);

# Person 4 has no skills;

INSERT INTO peopleskills (skills_id, people_id) values (0, 4);

# Person 5 has skills 3,6;

INSERT INTO peopleskills (skills_id, people_id) values (3, 5), (6, 5);

# Person 6 has skills 2,3,4;

INSERT INTO peopleskills (skills_id, people_id) values (2, 6), (3, 6), (4, 6);

# Person 7 has skills 3,5,6;

INSERT INTO peopleskills (skills_id, people_id) values (3, 7), (5, 7), (6, 7);

# Person 8 has skills 1,3,5,6;

INSERT INTO peopleskills (skills_id, people_id) values (1, 8), (3, 8), (5, 8), (6, 8);

# Person 9 has skills 2,5,6;

INSERT INTO peopleskills (skills_id, people_id) values (2, 9), (5, 9), (6, 9);

# Person 10 has skills 1,4,5;

INSERT INTO peopleskills (skills_id, people_id) values (1, 10), (4, 10), (5, 10);

# Note that no one has yet acquired skills 7 and 8.

# Section 8
# Create roles( id, name, sort_priority )
# sort_priority is an integer and is used to provide an order for sorting roles

CREATE TABLE roles(
    id int auto_increment,
    name varchar(256),
    sort_priority int,
    PRIMARY KEY(id)
)

# Section 9
# Populate roles
# Designer, Developer, Recruit, Team Lead, Boss, Mentor
# Sort priority is assigned numerically in the order listed above (Designer=10, Developer=20, Recruit=30, etc.)

INSERT INTO roles(name, sort_priority) values ("Designer", 10), ("Developer", 20), ("Recruit", 30), ("Team Lead", 40), ("Boss", 50), ("Mentor", 60);


# Section 10
# Create peopleroles( id, people_id, role_id, date_assigned )
# None of the fields can be null.  ID can be auto_increment

CREATE TABLE peopleroles(
    id int auto_increment NOT NULL,
    people_id int NOT NULL,
    role_id int NOT NULL,
    date_assigned date default(current_date) NOT NULL,
    PRIMARY KEY (id)
)

# Section 11
# Populate peopleroles
# Person 1 is Developer 
# Person 2 is Boss, Mentor
# Person 3 is Developer and Team Lead
# Person 4 is Recruit
# person 5 is Recruit
# Person 6 is Developer and Designer
# Person 7 is Designer
# Person 8 is Designer and Team Lead
# Person 9 is Developer
# Person 10 is Developer and Designer

INSERT INTO peopleroles(people_id, role_id) values (1, 2), (2, 5), (2, 6), (3, 2), (3,4), (4,3), (5,3), (6, 2), (6,1), (7, 1), (8, 1), (8,4), (9,2), (10, 2), (10,1);