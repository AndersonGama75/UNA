
                                            /*Agrupando e Resumindo dados
                                               Banco de dados EMPRESA
- Quantos empregados n�o possuem comiss�o? 

   11 EMPREGADOS NAO POSSUEM COMISSAO
*/
SELECT COUNT(*)
FROM EMP
WHERE COMISSAO IS NULL 
OR COMISSAO =0;
/*
- Quantos empregados possuem comiss�o?
   
   3 EMPREGADOS POSSUEM COMISS�O E 1 EMPREGADO POSSUI COMISSAO EQUIVALENTE A 0
*/
SELECT COUNT(*)
FROM EMP
WHERE COMISSAO IS NOT NULL
AND COMISSAO!=0

/*
- Qual o menor e maior sal�rio da empresa?

       MAIOR SAL�RIO = 15000,00 E MENOR SAL�RIO=1100,00
*/
SELECT MAX(SALARIO) AS 'MAIOR SAL�RIO' ,MIN(SALARIO) AS 'MENOR SAL�RIO'
FROM EMP
/*
- Considerando somente os departamentos 10 e 20, qual o menor e maior sal�rio?

       MAIOR SAL�RIO = 15000,00 E MENOR SAL�RIO=1100,00
*/
SELECT MAX(SALARIO) AS 'MAIOR SAL�RIO',
       MIN(SALARIO) AS 'MENOR SAL�RIO'
FROM EMP
WHERE DEPTNO IN(10,20)

/*
- Qual a m�dia salarial dos empregados que ganham mais de R$ 2000,00?

      MEDIA SALARIAL DOS EMPREGADOS QUE GANHAM MAIS QUE R$ 2000,00 = R$ 6386,4772
*/
SELECT AVG(SALARIO)
FROM EMP
WHERE SALARIO>2000.00

/*
- Quando foram realizadas a primeira e a �ltima contrata��o de um empregado? 

      DATA PRIMEIRA CONTRATA��O = 2010-12-03    DATA ULTIMA CONTRATA��O= 2016-05-01
*/
SELECT MAX(DATACONTRATACAO) 'PRIMEIRA CONTRATA��O' , MIN(DATACONTRATACAO) 'ULTIMA CONTRATA��O'
FROM EMP

/*
- Quantos cargos existem na tabela EMP?

      5 CARGOS DISTINTOS
*/
SELECT COUNT(DISTINCT CARGO)
FROM EMP

/*
- Quantos gerentes existem na tabela EMP?

           6  GERENTES
*/
SELECT COUNT(DISTINCT E2.EMPNO)
FROM EMP E1
JOIN EMP E2 ON E2.EMPNO = E1.GERENTE
/*
- Quantos departamentos possuem pelo menos um empregado?

       3 DEPARTAMENTOS POSSUEM PELO MENOS UM EMPREGADO
*/
SELECT COUNT(DISTINCT EMP.DEPTNO)
FROM EMP
JOIN DEPT 
ON DEPT.DEPTNO = EMP.DEPTNO
WHERE EMP.DEPTNO IS NOT NULL

/*
- Exibir a quantidade de empregados da tabela EMP separados por cargo e departamento.
*/
SELECT COUNT(*),CARGO,DEPTNO
FROM EMP
GROUP BY CARGO,DEPTNO

/*
- Exibir o c�digo e nome dos departamentos, bem como o seu maior sal�rio, mas somente para os departamentos que possuem mais de 4 empregados.
*/
SELECT max(dept.DEPTNO) as 'C�DIGO DEPARTAMENTO', max(dept.NOME) as 'NOME DEPARTAMENTO',max(salario) as 'MAIOR SAL�RIO'
FROM EMP
JOIN DEPT 
ON DEPT.DEPTNO = EMP.DEPTNO
GROUP BY emp.DEPTNO
HAVING COUNT(*)>4

/*
- Exibir o c�digo dos gerentes (coluna GERENTE) e a quantidade de empregados gerenciados por ele. 
*/ 
SELECT MAX(E2.EMPNO) as 'C�GIDO GERENTE',COUNT(*) as 'QUANTIDADE EMPREGADOS'
FROM EMP E1
JOIN EMP E2 ON E1.GERENTE=E2.EMPNO
GROUP BY E1.GERENTE
/*
- Exibir o c�digo e nome do departamento, sua m�dia salarial, mas somente para os departamentos que possuem o sal�rio m�nimo maior que R$ 1000.
*/
SELECT MAX(DEPT.DEPTNO) as 'C�digo departamento',MAX(DEPT.NOME)'Nome departamento',AVG(SALARIO) 'M�dia Sal�rial'
FROM EMP
JOIN DEPT
ON DEPT.DEPTNO=EMP.DEPTNO
JOIN SALGRADE
ON emp.SALARIO>1000
GROUP BY DEPT.DEPTNO

/*
- Exibir o sal�rio, o c�digo e nome dos 3 empregados que possuem o menor sal�rio dentro da empresa. 
*/
SELECT TOP 3 DEPTNO,NOME,SALARIO
FROM EMP 
ORDER BY SALARIO 

/*
- Exibir os dois cargos que possuem maior m�dia salarial dentro da empresa.
*/
SELECT TOP (2) CARGO, AVG(SALARIO)
FROM EMP
GROUP BY CARGO
ORDER BY 2 DESC

/*
Banco de dados Nutri��o
- Quantos pacientes moram em S�o Paulo ou no Rio de Janeiro?

        9 PACIENTES MORAM NO RJ E SP
*/
USE dbNutricao
SELECT COUNT(*)
FROM paciente
where estado in('RJ','SP')

/*
- Exibir o nome da cidade, o estado e a quantidade de pacientes por cidade/estado.
*/
SELECT cidade,estado,COUNT(*) as 'quantidade de pacientes'
FROM paciente
GROUP BY CIDADE,ESTADO
/*
- Exibir o nome do paciente, a data de sua primeira e da sua �ltima consulta.
*/

SELECT MAX(paciente.nome),MIN(consulta.datConsulta) as 'PRIMEIRA CONSULTA',MAX(consulta.datConsulta) as '�LTIMA CONSULTA'
FROM paciente
JOIN CONSULTA
ON consulta.idPaciente = paciente.idPaciente
GROUP BY paciente.idPaciente

/*
- Exibir a quantidade de consultas realizadas por cidade e estado.
*/
SELECT paciente.cidade,paciente.estado,COUNT(*) as 'QUANTIDADE DE CONSULTA(S)'
FROM paciente
JOIN consulta
ON consulta.idPaciente = paciente.idPaciente
GROUP BY paciente.cidade,paciente.estado

/*
- Para cada dieta, exibir o nome do paciente, a data em que foi realizada, e a quantidade total de cada nutriente que comp�e a dieta.
*/
SELECT max(p.nome) nomePaciente,max(c.datConsulta) datConsulta,CONCAT(MIN(n.nome),' - ',SUM(ca.quantidade)) nutriente
FROM consulta c
join dieta d
on d.idConsulta=c.idConsulta
join paciente p
on c.idPaciente=p.idPaciente
join
composicaoDieta cd on cd.idDieta = d.idDieta
join alimento a on a.idAlimento = cd.idAlimento
join composicaoAlimento ca on ca.idAlimento = a.idAlimento
join nutriente n on n.idNutriente = ca.idNutriente
group by d.idConsulta, n.idNutriente
order by nomePaciente, datConsulta

select * from nutriente


