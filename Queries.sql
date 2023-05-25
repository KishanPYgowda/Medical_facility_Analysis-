select * from Projects.dbo.Citys
select * from Projects.dbo.diseases
select * from Projects.dbo.recipients

-- 1. Name the Cities having more than 10 Hspitals

select city, num_of_Hospitals from Projects.dbo.Citys 
where  num_of_Hospitals > 10
order by  num_of_Hospitals desc;

-- 2. what is the total hospitals and beds are there in Texas

select sum(num_of_Hospitals) as Total_Hospitals, sum(num_of_beds) as No_bed 
from Projects.dbo.Citys 
where state = 'Texas';

-- 3. what is the 5th states Which has most number of physician 

select top 1 * from (select top 5 state, sum(number_of_physicians)as Physicians 
from Projects.dbo.Citys 
group by state 
order by Physicians desc) as sq order by Physicians;

-- 4. Find the city starting with 'H' having population more than 2.5 lack 

select city, total_population_of_city as population 
from Projects.dbo.Citys 
where city like 'H%' and total_population_of_city >= 250000 ;

-- 5. Count the city in state Alabama which have number of beds more than 500

select count(city) as No_of_Beds from Projects.dbo.Citys 
where state = 'alabama' and num_of_beds > 500;

-- 6. Name top 5 citys which have recorded highest Recipients growth rate

select top 5 city, recipients_in_2021, round(recipient_growth_in,2) as growth_rate 
from  Projects.dbo.citys inner join 
Projects.dbo.recipients on  Projects.dbo.citys.id_no = Projects.dbo.recipients.id_no
order by growth_rate desc;

-- 7. what is the total population and total Female recipients recorderd in state Washington

select sum(female) as Total_Women, sum(total_population_of_city) as Total_population
from Projects.dbo.citys 
inner join Projects.dbo.recipients on  Projects.dbo.citys.id_no = Projects.dbo.recipients.id_no
where state = 'washington';

--8. how many Heart deseases are recorded in california? And find Minimun Heart recipient per physician

select distinct city,state,Heart_disease, recipients_in_2021 as Recipients, number_of_physicians, cast(floor((Heart_disease/number_of_physicians))as float) as 'Mini_R/P'
from Projects.dbo.Citys 
inner join Projects.dbo.diseases on Projects.dbo.citys.id_no = Projects.dbo.diseases.id_no
inner join Projects.dbo.Recipients on Projects.dbo.recipients.id_no = Projects.dbo.diseases.id_no
where state in ('california','north california', 'south california')
order by [Mini_R/P] desc ;

--9. what percentage of population are suffering from diabetes Statewise 

select state, diabetes, total_population_of_city as population, round((cast(diabetes as float)/cast(total_population_of_city as float)),3)*100 as '% of diabetes' 
from Projects.dbo.citys
inner join Projects.dbo.diseases on  Projects.dbo.citys.id_no = Projects.dbo.diseases.id_no ;

--10. Rank the Citys based on its healthcare facility

select city, round((cast(num_of_beds as float)/cast(total_population_of_city as float)),4) as bed_to_population_ratio, 
rank() over(order by (cast(num_of_beds as float)/cast(total_population_of_city as float)) desc ) as 'Rank'
from projects.dbo.Citys ;



