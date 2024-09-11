--Users
--The heart of LinkedIn’s platform is its people. Your database should be able to represent the following information about LinkedIn’s users:

--Their first and last name
--Their username
--Their password
--Keep in mind that, if a company is following best practices, application passwords are “hashed.” No need to worry about hashing passwords here, though.

CREATE TABLE users(
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" VARCHAR NOT NULL
);

--Schools and Universities
--LinkedIn also allows for official school or university accounts, such as that for Harvard,
--so alumni (i.e., those who’ve attended) can identify their affiliation.
--Ensure that LinkedIn’s database can store the following information about each school:

--The name of the school
--The type of school (e.g., “Elementary School”, “Middle School”, “High School”, “Lower School”, “Upper School”, “College”, “University”, etc.)
--The school’s location
--The year in which the school was founded

CREATE TABLE schools(
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK("type" IN ('Elementary School', 'Middle School'
    , 'High School', 'Lower School', 'Upper School', 'College', 'University')),
    "location" TEXT NOT NULL,
    "year_founded" INTEGER NOT NULL
);

--Companies
--LinkedIn allows companies to create their own pages, like the one for LinkedIn itself,
--so employees can identify their past or current employment with the company.
--Ensure that LinkedIn’s database can store the following information for each company:

--The name of the company
--The company’s industry (e.g., “Education”, “Technology, “Finance”, etc.)
--The company’s location

CREATE TABLE companies(
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    "location" TEXT NOT NULL
);

--Connections
--And finally, the essence of LinkedIn is its ability to facilitate connections between people.
--Ensure LinkedIn’s database can support each of the following connections.

--Connections with People
--LinkedIn’s database should be able to represent mutual (reciprocal, two-way) connections between users.
--No need to worry about one-way connections, such as user A “following” user B without user B “following” user A.
CREATE TABLE ppl_connections(
    "user_id_a" INTEGER,
    "user_id_b" INTEGER,
    PRIMARY KEY ("user_id_a", "user_id_b"),
    FOREIGN KEY ("user_id_a") REFERENCES "users"("id"),
    FOREIGN KEY ("user_id_b") REFERENCES "users"("id"),
    CHECK ("user_id_a" < "user_id_b")
);

--Connections with Schools
--A user should be able to create an affiliation with a given school.
--And similarly, that school should be able to find its alumni. Additionally, allow a user to define:

--The start date of their affiliation (i.e., when they started to attend the school)
--The end date of their affiliation (i.e., when they graduated), if applicable
--The type of degree earned/pursued (e.g., “BA”, “MA”, “PhD”, etc.)

CREATE TABLE school_connections(
    "id" INTEGER PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "school_id" INTEGER NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE,
    "degree_type" TEXT CHECK("degree_type" IN ('BA', 'MA', 'PhD', 'other')),
    FOREIGN KEY ("user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("school_id") REFERENCES "schools"("id")
);

--Connections with Companies
--A user should be able to create an affiliation with a given company.
--And similarly, a company should be able to find its current and past employees. Additionally, allow a user to define:

--The start date of their affiliation (i.e., the date they began work with the company)
--The end date of their affiliation (i.e., when left the company), if applicable
--The title they held while affiliated with the company
CREATE TABLE company_connections(
    "id" INTEGER PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "company_id" INTEGER NOT NULL,
    "employee_status" TEXT NOT NULL CHECK("employee_status" IN('current', 'past')),
    "start_date" DATE NOT NULL,
    "end_date" DATE,
    "title" TEXT NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("company_id") REFERENCES "companies"("id")
);

