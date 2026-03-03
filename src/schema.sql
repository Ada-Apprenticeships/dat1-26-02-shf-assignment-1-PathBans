.open fittrackpro.db
.mode column

--Dropping existing tables
DROP TABLE IF EXISTS locations;

DROP TABLE IF EXISTS members;

DROP TABLE IF EXISTS staff;

DROP TABLE IF EXISTS equipment;

DROP TABLE IF EXISTS classes;

DROP TABLE IF EXISTS class_schedule;

DROP TABLE IF EXISTS memberships;

DROP TABLE IF EXISTS attendance;

DROP TABLE IF EXISTS class_attendance;

DROP TABLE IF EXISTS payments;

DROP TABLE IF EXISTS personal_training_sessions;

DROP TABLE IF EXISTS member_health_metrics;

DROP TABLE IF EXISTS equipment_maintenance_log;

PRAGMA foreign_keys = ON;

--Creating the tables with constraints
CREATE TABLE
    locations (
        location_id INTEGER PRIMARY KEY CHECK (location_id > 0),
        name TEXT NOT NULL,
        address TEXT NOT NULL UNIQUE,
        phone_number TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL UNIQUE CHECK (email LIKE '%_@__%.__%'),
        opening_hours TEXT NOT NULL CHECK (opening_hours LIKE '__:__-__:__')
    );

CREATE TABLE
    members (
        member_id INTEGER PRIMARY KEY CHECK (member_id > 0),
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE CHECK (email LIKE '%_@__%.__%'),
        phone_number TEXT NOT NULL UNIQUE CHECK (
            phone_number GLOB '07[0-9][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
        ),
        date_of_birth TEXT NOT NULL CHECK (
            date_of_birth GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        join_date TEXT NOT NULL CHECK (
            join_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        emergency_contact_name TEXT NOT NULL DEFAULT 'Unknown',
        emergency_contact_phone TEXT NOT NULL DEFAULT 'Unknown' CHECK (
            phone_number GLOB '07[0-9][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
        )
    );

CREATE TABLE
    staff (
        staff_id INTEGER PRIMARY KEY CHECK (staff_id > 0),
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE CHECK (email LIKE '%_@__%.__%'),
        phone_number TEXT NOT NULL UNIQUE CHECK (
            phone_number GLOB '07[0-9][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
        ),
        position TEXT NOT NULL CHECK (
            position in ('Manager', 'Trainer', 'Receptionist')
        ),
        hire_date TEXT NOT NULL CHECK (
            hire_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        location_id INTEGER,
        FOREIGN KEY (location_id) REFERENCES locations (location_id)
    );

CREATE TABLE
    equipment (
        equipment_id INTEGER PRIMARY KEY CHECK (equipment_id > 0),
        name TEXT NOT NULL,
        type TEXT NOT NULL CHECK (type in ('Cardio', 'Strength')),
        purchase_date TEXT NOT NULL CHECK (
            purchase_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        last_maintenance_date TEXT NOT NULL CHECK (
            last_maintenance_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        next_maintenance_date TEXT NOT NULL CHECK (
            next_maintenance_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        location_id INTEGER,
        FOREIGN KEY (location_id) REFERENCES locations (location_id)
    );

CREATE TABLE
    classes (
        class_id INTEGER PRIMARY KEY CHECK (class_id > 0),
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        capacity INTEGER NOT NULL CHECK (capacity > 0),
        duration INTEGER NOT NULL CHECK (duration > 0),
        location_id INTEGER,
        FOREIGN KEY (location_id) REFERENCES locations (location_id)
    );

CREATE TABLE
    class_schedule (
        schedule_id INTEGER PRIMARY KEY CHECK (schedule_id > 0),
        class_id INTEGER,
        staff_id INTEGER,
        start_time TEXT NOT NULL CHECK (
            start_time GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9][ ][0-9][0-9][:][0-9][0-9][:][0-9][0-9]'
        ),
        end_time TEXT NOT NULL CHECK (
            end_time GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9][ ][0-9][0-9][:][0-9][0-9][:][0-9][0-9]'
        ),
        FOREIGN KEY (class_id) REFERENCES classes (class_id),
        FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
    );

CREATE TABLE
    memberships (
        membership_id INTEGER PRIMARY KEY CHECK (membership_id > 0),
        member_id INTEGER,
        type TEXT NOT NULL CHECK (type in ('Standard', 'Premium')),
        start_date TEXT NOT NULL CHECK (
            start_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        end_date TEXT NOT NULL CHECK (
            end_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        status TEXT NOT NULL CHECK (status in ('Active', 'Inactive')),
        FOREIGN KEY (member_id) REFERENCES member (member_id)
    );

CREATE TABLE
    attendance (
        attendance_id INTEGER PRIMARY KEY CHECK (attendance_id > 0),
        member_id INTEGER,
        location_id INTEGER,
        check_in_time TEXT NOT NULL CHECK (
            check_in_time GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9][ ][0-9][0-9][:][0-9][0-9][:][0-9][0-9]'
        ),
        check_out_time TEXT CHECK (
            check_out_time GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9][ ][0-9][0-9][:][0-9][0-9][:][0-9][0-9]'
        ),
        FOREIGN KEY (member_id) REFERENCES member (member_id),
        FOREIGN KEY (location_id) REFERENCES location (location_id)
    );

CREATE TABLE
    class_attendance (
        class_attendance_id INTEGER PRIMARY KEY CHECK (class_attendance_id > 0),
        schedule_id INTEGER,
        member_id INTEGER,
        attendance_status TEXT NOT NULL CHECK (
            attendance_status in ('Attended', 'Registered', 'Unattended')
        ),
        FOREIGN KEY (schedule_id) REFERENCES schedule (schedule_id),
        FOREIGN KEY (member_id) REFERENCES member (member_id)
    );

CREATE TABLE
    payments (
        payment_id INTEGER PRIMARY KEY CHECK (payment_id > 0),
        member_id INTEGER,
        amount REAL,
        payment_date TEXT NOT NULL CHECK (
            payment_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9][ ][0-9][0-9][:][0-9][0-9][:][0-9][0-9]'
        ),
        payment_method TEXT NOT NULL CHECK (
            payment_method in ('Credit Card', 'PayPal', 'Cash', 'Bank Transfer')
        ),
        payment_type TEXT NOT NULL CHECK (
            payment_type in ('Monthly membership fee', 'Day pass')
        ),
        FOREIGN KEY (member_id) REFERENCES member (member_id)
    );

CREATE TABLE
    personal_training_sessions (
        session_id INTEGER PRIMARY KEY CHECK (session_id > 0),
        member_id INTEGER,
        staff_id INTEGER,
        session_date TEXT NOT NULL CHECK (
            session_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        start_time TEXT NOT NULL CHECK (
            start_time GLOB '[0-9][0-9][:][0-9][0-9][:][0-9][0-9]'
        ),
        end_time TEXT NOT NULL CHECK (
            end_time GLOB '[0-9][0-9][:][0-9][0-9][:][0-9][0-9]'
        ),
        notes TEXT NOT NULL CHECK (
            notes in ('Cardio focus', 'Strength training', 'Form check')
        ),
        FOREIGN KEY (member_id) REFERENCES member (member_id) FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
    );

CREATE TABLE
    member_health_metrics (
        metric_id INTEGER PRIMARY KEY CHECK (metric_id > 0),
        member_id INTEGER,
        measurement_date TEXT NOT NULL CHECK (
            measurement_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        weight REAL,
        body_fat_percentage REAL,
        muscle_mass REAL,
        bmi REAL,
        FOREIGN KEY (member_id) REFERENCES member (member_id)
    );

CREATE TABLE
    equipment_maintenance_log (
        log_id INTEGER PRIMARY KEY CHECK (log_id > 0),
        equipment_id INTEGER,
        maintenance_date TEXT NOT NULL CHECK (
            maintenance_date GLOB '[0-9][0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9]'
        ),
        description TEXT NOT NULL,
        staff_id INTEGER,
        FOREIGN KEY (equipment_id) REFERENCES equipment (equipment_id),
        FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
    );