### Triggers in Postgresql

## Insert Trigger: 

- Step 1 (create a table): 
    ```sql
        CREATE TABLE employee (
        id SERIAL PRIMARY KEY,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL
    );


    ``` 

- Step 2 (create tracking table)/ trigger table:
   ```sql
    CREATE TABLE employee_audit (
        id SERIAL PRIMARY KEY,
        email VARCHAR(100) UNIQUE NOT NULL
    );
   ```

- Step 3 (create a function):
  ```sql
    create or replace function emp_audit_log()
    returns trigger as $emp_audit_info_trgs$
    begin
    insert into employee_audit(email)
    values (new.email);
    return new;
    end;
    $emp_audit_info_trgs$ language plpgsql;

  ```

- Step 4 (create trigger):
  ```sql
    create trigger employee_audit_trg after insert on 
    employee for each row execute procedure emp_audit_log();

  ```