## Delete Trigger:

#[Step 1,2]
#Step 3: create function

CREATE OR REPLACE FUNCTION log_employee_deletion() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_deletions (employee_id, first_name, last_name, email)
    VALUES (OLD.id, OLD.first_name, OLD.last_name, OLD.email);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


# Step4: (Create trigger)

CREATE TRIGGER after_employee_delete
AFTER DELETE ON employee
FOR EACH ROW
EXECUTE FUNCTION log_employee_deletion();
