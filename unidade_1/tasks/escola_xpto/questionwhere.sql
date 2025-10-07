--Aula 7 Testes
--WHERE

--1 Liste os nomes dos estudantes da serie '2a Serie' com nota maior que 8.
SELECT 
	e.nome_estudante,
	s.descricao,
	m.nota
FROM academico.matricula m
JOIN academico.estudantes e ON m.id_estudante = e.id
JOIN academico.serie s ON e.id_serie = s.id
WHERE s.descricao = 'Segundo Ano' AND m.nota > 80
ORDER BY m.nota DESC


--2 Mostre as escolas cujo nome contenha a palavra 'Estadual'.
SELECT nome_escola
FROM academico.escola
WHERE nome_escola ILIKE '%Estadual'


--3 Liste os estudantes que nao estao nas series com IDs 1 ou 2.
SELECT nome_estudante
FROM academico.estudantes
WHERE id_serie = 1 OR id_serie=2

--4 Encontre as disciplinas cujo nome comece com a letra 'H'.
SELECT descricao
FROM academico.disciplina
WHERE descricao ILIKE 'H%'

--5 Liste as escolas com orcamento menor que 1 milhao E que pertencam ao tipo de escola com ID
--igual a 1.
SELECT * FROM academico.tipo_escola

SELECT nome_escola, orcamento_anual
FROM academico.escola
WHERE orcamento_anual < 1000000 AND id_tipo_escola = 1

--6 Liste as escolas cujo orcamento seja entre 2 milhoes e 5 milhoes OU que tenham o nome
--iniciando com 'Colegio'.
SELECT nome_escola
FROM academico.escola
WHERE (orcamento_anual > 2000000 AND orcamento_anual < 5000000) OR nome_escola ILIKE 'Colegio%'

--7 Mostre os estudantes que possuem a letra 'e' no nome E que estejam na serie de ID 2.
SELECT nome_estudante
FROM academico.estudantes
WHERE nome_estudante ILIKE '%e%' AND id_serie = 2

--8 Liste os estudantes que tem notas entre 7 e 9 e que estao matriculados nas disciplinas com ID 2
--ou 3.
SELECT e.nome_estudante
FROM academico.matricula m
JOIN academico.estudantes e ON m.id_estudante = e.id
WHERE (m.nota BETWEEN 70 AND 90) AND (m.id_disciplina = 2 OR m.id_disciplina = 3)

--9 Exiba os nomes dos estudantes que estao em series com descricao '1a Serie' ou '4a Serie'.
SELECT e.nome_estudante
FROM academico.estudantes e
JOIN academico.serie s ON e.id_serie = s.id
WHERE s.descricao = 'Segundo Ano' OR s.descricao = 'Quarto Ano'

--10 Encontre as disciplinas com a palavra 'Arte' no nome OU que terminem com 'Avancada'.
SELECT descricao
FROM academico.disciplina
WHERE descricao ILIKE '%Arte%' OR descricao ILIKE '%Avancada' 




--HAVING/ GROUP BY
--1 Liste a média de notas por série.
SELECT s.descricao,
		AVG(m.nota)::NUMERIC(18,2) AS "media notas"
FROM academico.matricula m
JOIN academico.estudantes e ON m.id_estudante = e.id
JOIN academico.serie s ON e.id_serie = s.id
GROUP BY s.descricao
ORDER BY s.descricao

--2  Exiba o número de estudantes por gênero.
SELECT g.descricao AS "Genero",
	   COUNT(e.id) AS "Quantidade"
FROM academico.estudantes e
JOIN academico.genero g ON e.id_genero = g.id
GROUP BY g.descricao

--3 Liste as disciplinas que possuem mais de 2 matrículas, ordenadas pela quantidade de alunos.
SELECT d.descricao AS "Disciplina",
	   COUNT(m.id_disciplina) AS "Quantidade"
FROM academico.matricula m
JOIN academico.disciplina d ON m.id_disciplina= d.id
GROUP BY d.descricao
HAVING COUNT(m.id_disciplina)>2
ORDER BY COUNT(m.id_disciplina)


--4 Mostre as 3 escolas com maior número de alunos cadastrados.
SELECT e.nome_escola AS "Nome escola",
	   COUNT(m.id_escola) AS "Quantidade"
FROM academico.matricula m
JOIN academico. escola e ON m.id_escola = e.id
GROUP BY nome_escola
ORDER BY COUNT(m.id_escola) DESC
LIMIT 3


--5 Liste a quantidade total de matrículas por escola.
SELECT e.nome_escola AS "Nome escola",
	   COUNT(m.id_escola) AS "Quantidade"
FROM academico.matricula m
JOIN academico. escola e ON m.id_escola = e.id
GROUP BY nome_escola
ORDER BY COUNT(m.id_escola) DESC


--6 Exiba os estudantes com mais de 2 disciplinas cursadas, ordenados por nome.
SELECT e.nome_estudante,
	   COUNT(m.id_disciplina)
FROM academico.estudantes e
JOIN academico.matricula m ON m.id_estudante = e.id
GROUP BY e.nome_estudante
HAVING COUNT(m.id_disciplina) >=2


-- 7 Mostre a média de notas por escola, apenas para escolas com mais de 5 matrículas.
SELECT e.nome_escola,
	   AVG(m.nota)::NUMERIC(18,2) AS media_notas
FROM academico.matricula m
JOIN academico.escola e ON m.id_escola = e.id
GROUP BY e.nome_escola
HAVING COUNT(m.id) > 5 
ORDER BY media_notas DESC


--8 Liste as disciplinas com média de nota inferior a 6.
SELECT d.descricao,
	   AVG(m.nota)
FROM academico.matricula m
JOIN academico.disciplina d ON m.id_disciplina = d.id
GROUP BY d.descricao
HAVING AVG(m.nota) <6


--9 Exiba a quantidade de estudantes por série, ordenada da maior para a menor.
SELECT s.descricao,
       COUNT(e.id) AS quantidade
FROM academico.estudantes e
JOIN academico.serie s ON e.id_serie = s.id
GROUP BY s.descricao
ORDER BY quantidade DESC


--10 Liste as 5 escolas com maior orçamento, do maior para o menor.
SELECT nome_escola,
	   orcamento_anual AS orcamento
FROM academico.escola
ORDER BY orcamento DESC
LIMIT 5