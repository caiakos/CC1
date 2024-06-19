DELETE FROM PRODUTOS
WHERE ID_PRODUTO IN (
    SELECT PRODUTO
    FROM PRODUTOS_FORNECEDORES
    WHERE FORNECEDOR = (
        SELECT ID_FORNECEDOR
        FROM FORNECEDORES
        WHERE CIDADE = 'Belo Horizonte'
    )
);

DELETE FROM PRODUTOS
WHERE ID_PRODUTO IN (
    SELECT PRODUTO
    FROM PRODUTOS_FORNECEDORES
    WHERE FORNECEDOR = (
        SELECT ID_FORNECEDOR
        FROM FORNECEDORES
        WHERE CIDADE = 'Curitiba'
    )
);

DELETE FROM FORNECEDORES
WHERE ID_FORNECEDOR IN (
    SELECT FORNECEDOR
    FROM PRODUTOS_FORNECEDORES
    WHERE PRODUTO IN (
        SELECT ID_PRODUTO
        FROM PRODUTOS
        WHERE PRECO > 100
    )
);

DELETE FROM FORNECEDORES
WHERE ID_FORNECEDOR IN (
    SELECT FORNECEDOR
    FROM PRODUTOS_FORNECEDORES
    WHERE PRODUTO IN (
        SELECT ID_PRODUTO
        FROM PRODUTOS
        WHERE DESCRICAO LIKE '%vel%'
    )
);

DELETE FROM ARMAZENS
WHERE CIDADE_ARMAZEM = 'Salvador';

DELETE FROM ARMAZENS
WHERE CIDADE_ARMAZEM = 'Manaus';