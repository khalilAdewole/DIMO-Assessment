select * from system_a
select * from system_b

create table system_a_samp
(like system_a)

insert into system_a_samp
select *
from system_a
select *
from system_a_samp

create table system_b_samp
(like system_b)

insert into system_b_samp
select *
from system_b

select *
from system_b_samp

-- Step 1: Add the new column
ALTER TABLE system_a_samp
ADD COLUMN full_name VARCHAR;

-- Step 2: Populate the new column
UPDATE system_a_samp
SET full_name = COALESCE(first_name, '') || ' ' || COALESCE(last_name, '');

select *
from system_a_samp

-- Step 1: Add the new column
ALTER TABLE system_b_samp
ADD COLUMN full_name VARCHAR;

-- Step 2: Populate the new column
UPDATE system_b_samp
SET full_name = COALESCE(first_name, '') || ' ' || COALESCE(last_name, '');

select *
from system_b_samp;

with cte as (
select *, row_number() over (partition by UID, Title, First_Name, 
Last_Name,	Gender,	email2,	Phone,	Address,	City,	Post_Code,
Department,	Job_Title,	DBS, full_name)as row_no
from system_a_samp
)

select * 
from cte
where row_no >1;

with cte as (
select *, row_number() over (partition by UID, Title, First_Name, 
Last_Name,	Gender,	email2,	Phone,	Address,	City,	Post_Code,
Department,	Job_Title,	DBS, full_name)as row_no
from system_b_samp
)

select * 
from cte
where row_no >1;

select * 
from system_a_samp
where department isnull or department = '' and
job_title isnull or job_title ='' and
dbs isnull;

select system_a_samp.email2,system_b_samp.email2, system_a_samp.department, system_b_samp.department, system_a_samp.dbs, system_b_samp.dbs
from system_a_samp
join system_b_samp
on system_a_samp.full_name = system_b_samp.full_name;



select system_a_samp.email2, system_b_samp.email2
from system_a_samp
join system_b_samp
on system_a_samp.full_name = system_b_samp.full_name;

UPDATE system_a_samp
SET email2 = system_b_samp.email2
FROM system_b_samp
WHERE system_a_samp.full_name = system_b_samp.full_name
  AND system_a_samp.email2 ISNULL
  AND system_b_samp.email2 IS NOT NULL;

select system_a_samp.email2
from system_a_samp;

select *
from system_a_samp;


