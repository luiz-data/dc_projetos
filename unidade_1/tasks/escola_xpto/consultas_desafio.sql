--Análise 1: Orçamento da Escola vs. Média das Notas dos Alunos

SELECT
    e.id AS id_escola,
    e.nome_escola,
    e.orcamento_anual,
    AVG(m.nota)::NUMERIC(18, 2) AS media_notas_escola
FROM
    academico.escola AS e
JOIN
    academico.matricula AS m ON e.id = m.id_escola
GROUP BY
    e.id, e.nome_escola, e.orcamento_anual
ORDER BY
    media_notas_escola DESC;
	

-- Análise 2: Tipo de Escola com Melhor Rendimento Educacional
SELECT
    te.descricao AS tipo_escola_descricao,
    AVG(m.nota)::NUMERIC(18,2) AS media_notas_tipo_escola
FROM
    academico.matricula AS m
JOIN
    academico.escola AS e ON m.id_escola = e.id
JOIN
    academico.tipo_escola AS te ON e.id_tipo_escola = te.id
GROUP BY
    te.descricao
ORDER BY
    media_notas_tipo_escola DESC;

-- Análise 3: Desempenho dos Alunos por Disciplina
SELECT
    d.descricao AS nome_disciplina,
    AVG(m.nota)::NUMERIC(18,2) AS media_notas_disciplina
FROM
    academico.matricula AS m
JOIN
    academico.disciplina AS d ON m.id_disciplina = d.id
GROUP BY
    d.descricao
ORDER BY
    media_notas_disciplina DESC;