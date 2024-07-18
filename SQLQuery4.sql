-- Create a join table --
SELECT * FROM Absenteeism_at_work AS a
LEFT JOIN compensation AS b
ON a.ID = b.ID
LEFT JOIN Reasons AS r 
ON a.Reason_for_absence = r.Number;

--Find the healthiest employees--
SELECT * FROM Absenteeism_at_work
WHERE Social_drinker = 0 AND Social_smoker = 0
AND Body_mass_index < 25
AND Absenteeism_time_in_hours < (SELECT AVG (Absenteeism_time_in_hours) FROM Absenteeism_at_work)

--Compensation rate increase for non-smokers / budget $983,221 so .68 increase per hour / $1,414.4 per year --
SELECT COUNT(*) AS Non_smokers FROM Absenteeism_at_work
WHERE Social_smoker = 0

--Opimize the query--
SELECT a.ID, r.Reason, Month_of_absence, Body_mass_index,
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight' --Body Mass Index (BMI) is a person's weight in kilograms divided by the square of height in meters--
	 WHEN Body_mass_index BETWEEN 18.5 AND 25 THEN 'HealthyWeight'
	 WHEN Body_mass_index BETWEEN 25 AND 30 THEN 'OverWeight'
	 WHEN Body_mass_index > 30 THEN 'Obese'
	 ELSE 'Unknown' 
	 END AS BMI_Category,
CASE WHEN Month_of_absence IN (12,1,2) THEN 'Winter'
	 WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
	 WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
	 WHEN Month_of_absence IN (9,10,11) THEN 'Autumn'
	ELSE 'Unknown'
	END AS Season_Names,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
FROM Absenteeism_at_work AS a
LEFT JOIN compensation AS b
ON a.ID = b.ID
LEFT JOIN Reasons AS r 
ON a.Reason_for_absence = r.Number;
