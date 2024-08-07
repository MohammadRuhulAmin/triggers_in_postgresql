#step1 create a table: 
CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

#step2 insert some data: 
INSERT INTO employee (first_name, last_name, email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Michael', 'Johnson', 'michael.johnson@example.com'),
('Emily', 'Davis', 'emily.davis@example.com'),
('David', 'Wilson', 'david.wilson@example.com');

#step3 create trigger table:
CREATE TABLE employee_audit (
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL
);

#step 4 create function: 
create or replace function emp_audit_log()
returns trigger as $emp_audit_info_trgs$
begin
 insert into employee_audit(email)
 values (new.email);
 return new;
 end;
 $emp_audit_info_trgs$ language plpgsql;

#step 5 create trigger:  
create trigger employee_audit_trg after insert on 
employee for each row execute procedure emp_audit_log();

#step 6 insert a data and check:

INSERT INTO employee (first_name, last_name, email) VALUES
('Jsssohn', 'ddDoe', 'xxjohn.doe@example.com');