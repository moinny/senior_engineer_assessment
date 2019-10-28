USE PERSONDATABASE

/*********************
Hello! 

Please use the test data provided in the file 'PersonDatabase' to answer the following
questions. Please also import the dbo.Contacts flat file to a table for use. 

All answers should be executable on a MS SQL Server 2012 instance. 

***********************



QUESTION 1

The table dbo.Risk contains calculated risk scores for the population in dbo.Person. Write a 
query or group of queries that return the patient name, and their most recent risk level(s). 
Any patients that dont have a risk level should also be included in the results. 

**********************/
--ANSWER TO QUESTION 1 
select PersonName, Max(RiskDateTime), Max(RiskLevel)
From	(Select p.PersonName, r.RiskLevel, r.RiskDateTime
		From Person p
		Left join Risk r on p.PersonID = r.PersonID
		) B
Group By PersonName

/**********************

QUESTION 2


The table dbo.Person contains basic demographic information. The source system users 
input nicknames as strings inside parenthesis. Write a query or group of queries to 
return the full name and nickname of each person. The nickname should contain only letters 
or be blank if no nickname exists.

**********************/
--ANSWER TO QUESTION 2
Select PersonName, 
Case when CHARINDEX('(',PersonName) > 0 Then Substring(PersonName,Charindex('(',PersonName)+1 ,Charindex(')',PersonName)-Charindex('(',PersonName)-1)
Else '' End
From Person


/**********************

QUESTION 6

Write a query to return risk data for all patients, all payers 
and a moving average of risk for that patient and payer in dbo.Risk. 

**********************/
--ANSWER TO QUESTION 6
Select PersonID, AttributedPayer, AVG(RiskScore) OVER (PARTITION BY PersonID ORDER BY AttributedPayer ROWS 19 PRECEDING) AS MovingAverage
From Risk



