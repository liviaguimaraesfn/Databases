DROP TABLE IF EXISTS SFI_Gender_Awards;

CREATE TABLE SFI_Gender_Awards (
programme_id SERIAL PRIMARY KEY,
programme_name VARCHAR(255),
year INT,
award_status VARCHAR(50),
applicant_gender VARCHAR(10),
amount_requested DECIMAL(15,2),
amount_funded DECIMAL(15,2)
);

INSERT INTO SFI_Gender_Awards (programme_name, year, award_status, applicant_gender, amount_requested, amount_funded)
VALUES
('SFI Investigator Programme/Principal Investigator Programme', 2011, 'Awarded', 'Male',   1000000, 890000),
('SFI Investigator Programme/Principal Investigator Programme', 2011, 'Awarded', 'Female', 1300000, 1140000),
('SFI Investigator Programme/Principal Investigator Programme', 2011, 'Awarded', 'Male',    650000, 760000),
('SFI Investigator Programme/Principal Investigator Programme', 2011, 'Awarded', 'Male',    580000, 570000),
('SFI Investigator Programme/Principal Investigator Programme', 2011, 'Awarded', 'Male',   1190000, 1100000);

SELECT * FROM SFI_Gender_Awards;