USE BDEX1_HOSPITAL;
# 1 - Quais são os pacientes agendados para consulta com um determinado médico, 
# incluindo informações do médico, em uma determinada data?
SELECT
CONSULTAS.DATA_CONS AS DATA,
CONSULTAS.HORA_CONS AS HORARIO,
PACIENTES.NOME AS PACIENTE,
MEDICOS.NOME AS MEDICO,
MEDICOS.CRM,
MEDICOS.UF,
DEPARTAMENTOS.NOME_ESPECIALIDADE AS ESPECIALIDADE
FROM CONSULTAS
JOIN MEDICOS
	ON CONSULTAS.CRM = MEDICOS.CRM AND CONSULTAS.UF = MEDICOS.UF
JOIN DEPARTAMENTOS
	ON MEDICOS.DEPTO_COD_ESPEC = DEPARTAMENTOS.COD_ESPECIALIDADE
JOIN PACIENTES
	ON PACIENTES.CPF_PACIENTE = CONSULTAS.CPF_PACIENTE
ORDER BY DATA,HORARIO;

# 2 - Quais são os médicos e seus respectivos departamentos, incluindo aqueles 
# que não estão associados a nenhum departamento?
SELECT
MEDICOS.NOME AS MEDICO,
DEPARTAMENTOS.NOME_ESPECIALIDADE AS DEPARTAMENTO
FROM MEDICOS LEFT JOIN DEPARTAMENTOS
ON MEDICOS.DEPTO_COD_ESPEC = DEPARTAMENTOS.COD_ESPECIALIDADE;

# 3 - Quais são os pacientes que já passaram por consulta com um determinado médico, 
#incluindo informações do médico, mesmo que não tenham sido atendidos?
SELECT
CONSULTAS.DATA_CONS AS DATA,
PACIENTES.NOME AS PACIENTE,
MEDICOS.NOME AS MEDICO,
MEDICOS.CRM,
MEDICOS.UF
FROM PACIENTES
JOIN CONSULTAS
	ON PACIENTES.CPF_PACIENTE = CONSULTAS.CPF_PACIENTE
JOIN MEDICOS
	ON CONSULTAS.CRM = MEDICOS.CRM AND CONSULTAS.UF = MEDICOS.UF
WHERE CONSULTAS.DATA_CONS < CURDATE() AND CONSULTAS.ANAMNESE IS NULL;

USE BDEX2_PASSAGENS_AEREAS;
#1 - Quais são os voos disponíveis de um determinado aeroporto para outro em uma 
# determinada data, incluindo informações dos aeroportos de partida e chegada?
SELECT
DATA_PART AS DATA_EMBARQUE,
HORA_PART AS HORA_EMBARQUE,
CIA_AEREAS.NOME_FANTASIA AS OPERADORA,
PART.NOME AS EMBARQUE,
CHEG.NOME AS DESTINO,
DATA_CHEG AS DATA_PREVISTA,
HORA_CHEG AS HORARIO_PREVISTO
FROM VOOS
JOIN AEROPORTOS AS PART ON PART.ID_AEROPORTO = VOOS.AERO_PART
JOIN AEROPORTOS AS CHEG ON CHEG.ID_AEROPORTO = VOOS.AERO_CHEG
JOIN CIA_AEREAS ON CIA_AEREAS.ID_CIA = VOOS.CIA_AEREA;
#2 - Quais são os passageiros reservados em um determinado voo,
#incluindo aqueles que ainda não reservaram?
SELECT
CONCAT(P.NOME,' ', P.SOBRENOME) PASSAGEIRO,
V.DATA_PART AS DATA_EMBARQUE,
V.HORA_PART AS HORA_EMBARQUE,
CA.NOME_FANTASIA AS OPERADORA,
A.NOME AS EMBARQUE
FROM PASSAGEIROS P
LEFT JOIN PASSAGEIROS_RESERVAS PR ON PR.PASSAGEIRO = P.COD_PASSAGEIRO
LEFT JOIN VOOS_RESERVAS VR ON VR.ID_RESERVA = PR.ID_RESERVA
LEFT JOIN VOOS V ON V.ID_VOO = VR.ID_VOO
LEFT JOIN AEROPORTOS A ON A.ID_AEROPORTO = V.AERO_PART
LEFT JOIN CIA_AEREAS CA ON CA.ID_CIA = V.CIA_AEREA;

#3 - Quais são os voos operados por uma determinada companhia aérea, 
# incluindo aquelas que não têm operações?
SELECT 
CA.NOME_FANTASIA AS OPERADORA,
A.NOME AS EMBARQUE,
V.DATA_PART AS DATA_EMBARQUE,
V.HORA_PART AS HORA_EMBARQUE
FROM CIA_AEREAS AS CA
LEFT JOIN VOOS V ON CA.ID_CIA = V.CIA_AEREA 
LEFT JOIN AEROPORTOS A ON A.ID_AEROPORTO = V.AERO_PART;

USE BDEX3_REDESOCIAL;
# 1 - Quais são os usuários que pertencem a um determinado grupo, 
# incluindo informações dos grupos e dos usuários?
SELECT
GRUPOS.NOME_GRUPO AS GRUPO,
GROUP_CONCAT(USUARIOS.NOME_USUARIO) AS USERS
FROM USUARIOS_GRUPOS
JOIN USUARIOS ON USUARIOS.ID_USUARIO = USUARIOS_GRUPOS.USUARIO
JOIN GRUPOS ON GRUPOS.ID_GRUPO = USUARIOS_GRUPOS.GRUPO
GROUP BY USUARIOS_GRUPOS.GRUPO
ORDER BY USUARIOS_GRUPOS.GRUPO;
/* 
#SE FOSSE OS GRUPOS DE CADA USUÁRIO:
SELECT
USUARIOS.NOME_USUARIO AS USERS,
GROUP_CONCAT(GRUPOS.NOME_GRUPO) AS GRUPO
FROM USUARIOS_GRUPOS
JOIN USUARIOS ON USUARIOS.ID_USUARIO = USUARIOS_GRUPOS.USUARIO
JOIN GRUPOS ON GRUPOS.ID_GRUPO = USUARIOS_GRUPOS.GRUPO
GROUP BY USUARIOS.NOME_USUARIO 
ORDER BY USUARIOS.NOME_USUARIO ;*/

# 2 - Quais são as postagens de um usuário específico, 
# incluindo o texto da postagem e as informações do usuário?
SELECT
USUARIOS.NOME_USUARIO AS USERS,
GROUP_CONCAT(POSTAGENS.TEXTO) AS POSTAGENS
FROM USUARIOS
JOIN POSTAGENS ON POSTAGENS.USUARIO = USUARIOS.ID_USUARIO
GROUP BY USUARIOS.NOME_USUARIO
ORDER BY USUARIOS.NOME_USUARIO;
# 3 - Quais usuários estão na rede social, que realizaram postagens ou não. 
# Inclua as informações das postagens, quando houver.
SELECT
USUARIOS.NOME_USUARIO AS USERS,
GROUP_CONCAT(POSTAGENS.TEXTO) AS POSTAGENS,
GROUP_CONCAT(POSTAGENS.IMAGEM) AS IMAGENS
FROM USUARIOS
LEFT JOIN POSTAGENS ON POSTAGENS.USUARIO = USUARIOS.ID_USUARIO
GROUP BY USUARIOS.NOME_USUARIO
ORDER BY USUARIOS.NOME_USUARIO;

USE BDEX4_ESTOQUE;
# 1 - Quais são os produtos fornecidos por um determinado fornecedor, 
# incluindo informações do fornecedor e dos produtos?
SELECT
F.NOME_FOR AS FORNECEDOR,
GROUP_CONCAT(P.NOME_PRO) PRODUTOS
FROM FORNECEDORES F
LEFT JOIN PRODUTOS_FORNECEDORES PF ON PF.FORNECEDOR = F.ID_FORNECEDOR
LEFT JOIN PRODUTOS P ON P.ID_PRODUTO = PF.PRODUTO
GROUP BY F.NOME_FOR
ORDER BY FORNECEDOR;
# 2 - Quais são os produtos disponíveis em um determinado armazém, 
# incluindo informações dos produtos e dos armazéns?
SELECT
A.NOME_ARMAZEM ARMAZEM,
GROUP_CONCAT(P.NOME_PRO) PRODUTOS
FROM ARMAZENS A
JOIN PRODUTOS_ARMAZENS PA ON PA.ARMAZEM = A.ID_ARMAZEM
JOIN PRODUTOS P ON PA.PRODUTO = P.ID_PRODUTO
GROUP BY ARMAZEM;


# 3 - Quais são os fornecedores que fornecem um determinado produto, 
#incluindo aqueles que não têm fornecimentos registrados?
SELECT
P.NOME_PRO PRODUTOS,
GROUP_CONCAT(F.NOME_FOR) FORNECEDORES
FROM FORNECEDORES F
LEFT JOIN PRODUTOS_FORNECEDORES PF ON PF.FORNECEDOR = F.ID_FORNECEDOR
LEFT JOIN PRODUTOS P ON P.ID_PRODUTO = PF.PRODUTO
GROUP BY P.NOME_PRO
ORDER BY P.NOME_PRO;

use BDEX5_EVENTOS;
# 1 - Quais são as atividades planejadas para um determinado evento, 
# incluindo informações dos eventos e das atividades?
SELECT
E.NOME_EVENTO EVENTO,
#AGRUPANDO OS -RESULTADOS- DE ACORDO COM O EVENTO
GROUP_CONCAT(
#CONCATENANDO AS INFORMAÇÕES DE ATIVIDADE (TEXTO)
CONCAT(
A.NOME_ATV,'|', #ADICIONA UM TEXTO COM UM SEPARADOR |
A.DATA_ATV,'|',
A.HORA_ATV) 
#MUDANDO O SEPARADOR PADRÃO DE , PARA ||
SEPARATOR ' || ') ATIVIDADES #NOME DA COLUNA RESULTANTE

FROM ATIVIDADES A
INNER JOIN EVENTOS E ON A.EVENTO_ATV = E.ID_EVENTO
GROUP BY EVENTO
ORDER BY EVENTO;

# 2 - Quais são os participantes inscritos em uma determinada atividade,
# incluindo aqueles que não têm inscrição registrada?
SELECT
P.NOME PARTICIPANTE,
A.NOME_ATV ATIVIDADE
FROM PARTICIPANTES P
LEFT JOIN PARTICIPANTE_ATIVIDADE PA
ON PA.INSCRICAO = P.NUM_INSCRICAO AND PA.CPF = P.CPF
LEFT JOIN ATIVIDADES A
ON A.ID_ATIVIDADE = PA.ATIVIDADE;

# 3 - Quais são os eventos que ocorrerão em um determinado local, 
# incluindo aqueles que não têm localização definida?
SELECT E.NOME_EVENTO, L.NOME
FROM EVENTOS E
LEFT JOIN LOCAIS L ON E.LOCAL_EVENTO = L.ID_LOCAL;

use BDEX6_CINEMA;
# 1 - Quais são os espectadores que assistiram a um determinado filme 
# em uma determinada data, incluindo informações dos espectadores e 
# dos filmes?
SELECT 
    DATA_ING,
    GROUP_CONCAT(INFO SEPARATOR '; ') AS INFO
FROM (
    SELECT 
        I.DATA_ING,
        CONCAT(GROUP_CONCAT(E.NOME_ESPEC SEPARATOR ', '), 
        IF(COUNT(E.NOME_ESPEC) > 1,' assistiram ',' assistiu '), F.NOME_FILME) AS INFO
    FROM 
        INGRESSOS I
    JOIN 
        ESPECTADORES E ON I.ESPECTADOR = E.ID_ESPEC
    JOIN 
        SESSOES S ON S.ID_SESSAO = I.SESSAO
    JOIN 
        FILMES F ON F.ID_FILME = S.FILME
    GROUP BY 
        I.DATA_ING, F.NOME_FILME
) AS SUBCONSULTA
GROUP BY 
    DATA_ING;

# 2 - Quais são os filmes em exibição em uma determinada sala, incluindo
# aqueles que não têm sessões programadas?
SELECT F.NOME_FILME FILMES, GROUP_CONCAT(SL.NOME) SALA
FROM SALAS SL
RIGHT JOIN SESSOES S ON S.SALA = SL.ID_SALA
RIGHT JOIN FILMES F ON S.FILME = F.ID_FILME
GROUP BY FILMES;

# 3 - Quais são as sessões disponíveis para um determinado filme, 
# incluindo informações das sessões e dos filmes?
SELECT F.NOME_FILME FILMES, GROUP_CONCAT(S.ID_SESSAO) SESSAO
FROM SESSOES S
JOIN FILMES F ON S.FILME = F.ID_FILME
GROUP BY FILMES;

USE BDEX7_TRANSACOESBANCARIAS;
#1 - Quais são as transações realizadas por um determinado usuário, incluindo informações das transações e dos usuários?
SELECT
U.NOME_USER USUARIO,
GROUP_CONCAT(
CONCAT_WS(' ',C.NOME_BNC, 
T.AGENCIA,T.CONTA,T.NATUREZA,
CONCAT('R$ ',T.VALOR))
SEPARATOR ' || ') TRANSACOES
FROM USUARIOS U
INNER JOIN TRANSACOES T ON U.ID_USER = T.USUARIO
INNER JOIN CONTAS C ON C.AGENCIA = T.AGENCIA
					AND C.CONTA = T.CONTA
					AND C.COD_BANCO = T.COD_BANCO
GROUP BY USUARIO;


#2 - Quais são as transações de débito realizadas em uma determinada conta, incluindo aquelas que não têm registros de débito?
SELECT 
CONCAT_WS(' ',C.NOME_BNC, 
C.AGENCIA,C.CONTA) CONTA,
GROUP_CONCAT(CONCAT(' R$ ',T.VALOR)) VALOR
FROM TRANSACOES T 
RIGHT JOIN CONTAS C ON C.AGENCIA = T.AGENCIA
					AND C.CONTA = T.CONTA
					AND C.COD_BANCO = T.COD_BANCO
WHERE T.NATUREZA = 'DEBITO' OR T.NATUREZA IS NULL
GROUP BY CONTA;

#3 - Quais são os saldos registrados em uma determinada agência e conta, incluindo aqueles que não têm registros de saldo?
SELECT
CONCAT_WS(' ',C.NOME_BNC, 
C.AGENCIA,C.CONTA) CONTA,
GROUP_CONCAT(CONCAT_WS(' - ',S.DATA_SALDO,
CONCAT('R$ ',S.VALOR_SALDO)) SEPARATOR ' || ') SALDOS
FROM SALDOS S
RIGHT JOIN CONTAS C ON C.AGENCIA = S.AGENCIA
					AND C.CONTA = S.CONTA
					AND C.COD_BANCO = S.COD_BANCO
GROUP BY CONTA;
