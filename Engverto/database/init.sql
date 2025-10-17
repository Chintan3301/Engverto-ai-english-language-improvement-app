CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    user_id INT,
    module TEXT,
    activity_type TEXT,
    score INT,
    completed_on TIMESTAMP DEFAULT now()
);
