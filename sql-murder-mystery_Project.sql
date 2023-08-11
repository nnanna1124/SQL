-- find out the crime scene report for Murder crimes that took place in SQL city on Jan 05 2018
select *
from crime_scene_report
where city = 'SQL City' and type = 'murder'
--find out the details of the witnesses Annabel on Franklin Ave and the witness who lives at the last house on Northwestern Dr
select *
from person
join facebook_event_checkin
on person.id = facebook_event_checkin.person_id
where person.address_street_name in ('Northwestern Dr', 'Franklin Ave')
and facebook_event_checkin.date = 20180115
--first witness is Monty Schapiro with id 14887 and license id 118009 ssn 111564949
--second witness is Annabel Miler with id 16371 and license id 490173 ssn 318771143
--Both witnesses attended the funky grooves tour on the said date

--Search for the transcript of the interview of Monty and Annabel 
select interview.transcript, interview.person_id
from interview
join person 
on person.id = interview.person_id
where interview.person_id in (14887, 16371)
--Annabel - I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th. 
--Monty - I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W". 

select get_fit_now_member.id, person.id, person.name, person.license_id, drivers_license.plate_number, get_fit_now_member.membership_status
from drivers_license
join person
on drivers_license.id = person.license_id
join get_fit_now_member
on get_fit_now_member.person_id = person.id
where get_fit_now_member.membership_status =  'gold'
and get_fit_now_member.id like '48Z%'
and drivers_license.plate_number like '%H42W%'

-- Jeremy Bowers owns the bag and the Vehicle with plate number 0H42W2, license id 423327, person id 67318, membership id 20160101 

Select * 
from get_fit_now_check_in
join get_fit_now_member
on get_fit_now_check_in.membership_id = get_fit_now_member.id
where get_fit_now_check_in.check_in_date = 20180109
and get_fit_now_check_in.membership_id = '48Z55'

-- Get fit gym member with membership id 48Z55 was also at the gym on 20180109 from 1530 t0 1700, the same perios Annabel was in the gym

insert into solution (user, value)
values  (1, 'Jeremy Bowers')

Select *
from solution

--- check murder interview transcript
select *
from interview
where person_id = 67318

-- Transcript of the murderer - I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017. 

select *
from drivers_license
join person 
on drivers_license.id = person.license_id
join income 
on income.ssn = person.ssn
where drivers_license.hair_color = 'red'
and drivers_license.gender = 'female'
and drivers_license.car_make = 'Tesla'
and drivers_license.car_model = 'Model S'
order by income.annual_income Desc 
 
-- there are 2 women who match this description, they both earn 
-- Red Korb with person id 78881, license id 918773, plate number 917UU3, salary 310,000
-- Miranda Preistly with person id 99716, license id 202298, plate number 500123, salary 278,000

--Which of these women watched the SQL Symphony 3 times in december 2017
select person_id, event_name, date
from facebook_event_checkin
where person_id in (78881,99716)
and event_name Like 'SQL SYmphony%' 
and date like '201712%'            

--only the person with id 99716 attended the SQL Symphony Concert 3 times in Dec 2017.
-- the person who hired the murderer is Miranda Preistly

insert into solution (user, value)
values  (2, 'Miranda Priestly')

Select *
from solution
