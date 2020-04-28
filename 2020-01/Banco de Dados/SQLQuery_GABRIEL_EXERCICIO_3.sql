/*
Exerc�cios 
JOINS
Crie uma consulta SQL para exibir:
Banco de dados EMPRESA
- O nome do empregado, seu cargo, seu sal�rio, bem como o nome e local (LOC) do seu departamento.
*/
select EMP.NOME, EMP.CARGO, EMP.SALARIO, DEPT.NOME, DEPT.LOC
from EMP
JOIN DEPT 
ON EMP.DEPTNO=DEPT.DEPTNO;
/*
- O nome dos empregados, seu cargo, e o nome dos seus departamentos. Exibir somente os empregados que possuem sal�rio acima de 2000,00 e que trabalham nos departamentos 10 e 20. Exiba os dados ordenados pelo nome do departamento, e em seguida pelo nome dos empregados.
*/
select EMP.NOME,EMP.CARGO,DEPT.NOME
from EMP
JOIN DEPT 
ON EMP.DEPTNO=DEPT.DEPTNO
where salario>2000.00 
and EMP.DEPTNO IN (10,20)
order by DEPT.NOME,EMP.NOME
GO
/*
- O nome do departamento, seu local, e o nome dos empregados que trabalham nesses departamentos. Exibir todos os departamentos, mesmo os que n�o possuem empregado.
*/
SELECT MAX(DEPT.NOME),MAX(DEPT.LOC),STRING_AGG(EMP.NOME,' ,')
FROM EMP
RIGHT JOIN DEPT
ON DEPT.DEPTNO=EMP.DEPTNO 
group BY DEPT.DEPTNO
/*
- O nome do empregado, seu sal�rio e o nome do seu departamento. Exibir todos os empregados, mesmo os que n�o possuem departamento
*/
SELECT E.NOME,E.SALARIO,D.NOME
FROM EMP AS E
LEFT JOIN DEPT AS D
ON E.DEPTNO=D.DEPTNO

/*
Banco de dados Nutri��o
- O nome e endere�o completo do paciente, a data da sua consulta, e o nome do m�dico que realizou a consulta.  Exibir somente os pacientes do sexo Feminino que moram nos estados do RJ ou MG.
*/
USE dbNutricao
SELECT p.nome,p.endereco,c.datConsulta,m.nome
FROM dbo.paciente as p
JOIN dbo.consulta as c
ON p.idPaciente=c.idPaciente
JOIN dbo.medico as m
ON m.idMedico = c.idMedico
WHERE p.estado in('RJ','MG')
AND p.sexo='f'
/*
- O nome do alimento, o nome de sua categoria, e o nome, quantidade e unidade de medida dos nutrientes que o comp�em. Exibir somente os alimentos cujo nome comece com a letra A.
*/
SELECT a.nome,c.nome as categoria,ca.quantidade,n.nome ,u.nome 
FROM dbo.alimento as a
join dbo.categoriaAlimento as c
on a.idCategoria=c.idCategoria
join dbo.composicaoAlimento as ca
on a.idAlimento=ca.idAlimento
join dbo.nutriente as n
on ca.idNutriente=n.idNutriente
join dbo.unidadeMedida as u
on u.idUnidadeMedida=ca.idUnidadeMedida
where a.nome like 'a%'

select *
from dbo.unidadeMedida

/*
- O nome e endere�o completo do paciente, a data da sua consulta, o m�dico que realizou a consulta, bem como todos os dados das dietas realizadas na consulta (categoria e alimentos que comp�em as dietas).  Exibir o endere�o completo em uma �nica coluna, da seguinte forma: Endere�o, Bairro � Cidade/Estado. Nomeie esta �ltima coluna como �Endere�o Completo�.
*/
SELECT MAX(p.nome),MAX(c.datConsulta) as data_consulta,MAX(m.nome) as nome_medico,MAX(cd.nome) as categoriaDieta, STRING_AGG(a.nome,' ,') as alimentos_dieta,MAX(CONCAT(p.endereco,'-',p.bairro,'-',p.cidade,'/',p.estado)) as 'Endere�o completo'
FROM dbo.paciente as p
JOIN dbo.consulta as c
ON p.idPaciente=c.idPaciente
JOIN dbo.medico as m
ON m.idMedico = c.idMedico
left JOIN dbo.dieta as d
ON c.idConsulta=d.idConsulta
left join dbo.categoriaDieta as cd
ON cd.idCategoriaDieta=d.idCategoriaDieta
left join dbo.composicaoDieta cdta
on d.idDieta = cdta.idDieta
left join dbo.alimento a 
on a.idAlimento = cdta.idAlimento
group by p.nome,c.datConsulta,m.nome,cd.nome

/*
- O nome do paciente, seu endere�o, e o nome do m�dico que o consultou. Exibir todos os pacientes, mesmo os que nunca realizaram consultas.
*/
SELECT MAX(p.nome),MAX(p.endereco),STRING_AGG(m.nome,',') as MEDICOS
FROM dbo.paciente as p
LEFT JOIN .consulta as c
ON p.idPaciente=c.idPaciente
LEFT JOIN dbo.medico as m
ON m.idMedico = c.idMedico
GROUP BY p.idPaciente 


/*
- O nome do paciente, seu endere�o, a data da sua consulta, e todos os dados de suas avalia��es nutricionais. Exibir todos os pacientes, mesmo os que nunca realizaram consulta e que nunca realizaram avalia��o nutricional.
*/
SELECT MAX(p.nome) AS NOME,MAX(p.endereco) AS ENDERE�O,STRING_AGG(c.datConsulta,'   //  ') AS 'DATA DA(S) CONSULTA(S)',MAX(an.peso) AS PESO,MAX(an.altura) AS ALTURA,MAX(an.percGordura) AS 'PERCENTUAL GORDURA'
FROM dbo.paciente as p
LEFT JOIN dbo.consulta as c
ON p.idPaciente=c.idPaciente
LEFT JOIN dbo.avaliacaoNutricional AS an
ON an.idConsulta=c.idConsulta
GROUP BY P.idPaciente

select *
from avaliacaoNutricional

/*
Desafio (banco de dados Empresa)
- O nome do empregado, seu sal�rio, bem como o nome e sal�rio do seu gerente.
*/
USE dbEmpresa
select e.NOME,e.SALARIO
from EMP as e
where e.CARGO != 'GERENTE'

select e.nome as 'NOME FUNCIONARIO',e.salario,e2.NOME as 'NOME GERENTE', e2.SALARIO
from emp as e
left join emp as e2 on e2.EMPNO = e.GERENTE
 

/*
- O nome do empregado, seu sal�rio, e o n�vel salarial no qual o mesmo se encontra, de acordo com a tabela SALGRADE
*/

select e.NOME,SALARIO, s.grau
from emp e	
join SALGRADE s
on e.SALARIO >= s.SALMINIMO AND e.SALARIO <= s.SALMAXIMO

