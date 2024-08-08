# Step 1: Create a log table 

CREATE TABLE del_timelog_id (
    id SERIAL PRIMARY KEY,
    timelog_id int ,
    is_processed int default 0,
    deleted_at TIMESTAMP 
);

# Step 2: Create a Function in postgresql

CREATE OR REPLACE FUNCTION del_time_log() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO del_timelog_id(timelog_id,deleted_at)
    VALUES (OLD.id,CURRENT_TIMESTAMP);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


#step 3: Create Trigger for tracking the deleted id 

CREATE TRIGGER del_time_log_trg
AFTER DELETE ON time_log
FOR EACH ROW
EXECUTE FUNCTION del_time_log();