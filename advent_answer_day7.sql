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