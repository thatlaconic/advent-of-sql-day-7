# [Santa's Cartesian Elf Skill-Matching Program](https://adventofsql.com/challenges/7)

## Description
Santa's workshop is implementing a new mentoring program! He noticed that some elves excel at certain tasks but could benefit from working with others who share the same skills. To make the workshop more efficient, Santa needs to pair up elves who have the same skills so they can collaborate and learn from each other. However, he wants to make sure each pair is only listed once (no duplicates where Elf1/Elf2 are reversed) and that elves aren't paired with themselves.

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-7/blob/main/advent_of_sql_day_7.sql)

Create a query that returns pairs of elves who share the same primary_skill. The pairs should be comprised of the elf with the most (max) and least (min) years of experience in the primary_skill.

When you have multiple elves with the same years_experience, order the elves by elf_id in ascending order.
Your query should return:
* The ID of the first elf with the Max years experience
* The ID of the first elf with the Min years experience
* Their shared skill
  
## Dataset
This dataset contains 1 tables with 4 columns and 100000 rows. 
### Using PostgreSQL
**input**
```sql
SELECT *
FROM workshop_elves ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-7/blob/main/workshop_elves.PNG)


### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-7/blob/main/advent_answer_day7.sql)

**input**
```sql
WITH AB AS (SELECT *
		FROM (SELECT elf_id, primary_skill, years_experience,
				ROW_NUMBER() OVER(PARTITION BY primary_skill ORDER BY years_experience DESC, elf_id ASC) AS max_exp
				FROM workshop_elves)
		WHERE max_exp = 1),
CD AS	(SELECT *
		FROM (SELECT elf_id, primary_skill, years_experience,
				ROW_NUMBER() OVER(PARTITION BY primary_skill ORDER BY years_experience, elf_id ASC) AS min_exp
				FROM workshop_elves)
		WHERE min_exp = 1)
	SELECT AB.elf_id AS elf_id_1,
			CD.elf_id AS elf_id_2,
			CD.primary_skill
	FROM CD
	JOIN AB ON CD.primary_skill = AB.primary_skill
	;

```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-7/blob/main/d7%20answer.PNG)



