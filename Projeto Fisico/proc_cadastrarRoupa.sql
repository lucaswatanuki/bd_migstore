ALTER PROCEDURE cadastrar_roupa
@nome VARCHAR(50),
@marca VARCHAR(15),
@departamento VARCHAR(15),
@preco money,
@cor VARCHAR(15),
@qtd_estoque INT,
@tipo SMALLINT,
@tipo_peca VARCHAR(15),
@tamanho CHAR(3),
@time VARCHAR(15)
as
BEGIN TRANSACTION
INSERT into produtos VALUES(@nome, @marca, @departamento, @preco, @cor, @qtd_estoque, @tipo)
DECLARE @cod_produto INT = (select IDENT_CURRENT('produtos') AS [IDENT_CURRENT('produtos')])
IF @@ROWCOUNT>0 AND @tipo = 0
    BEGIN
        INSERT into roupa VALUES(@cod_produto, @tipo_peca, @tamanho, @time)
        IF @@ROWCOUNT>0 
            BEGIN PRINT 'Produto cadastrado com sucesso!'COMMIT TRANSACTION RETURN 1 END
        ELSE PRINT 'Erro ao cadastrar produto!' ROLLBACK TRANSACTION RETURN 0
    END
ELSE PRINT 'Erro ao cadastrar produto!' ROLLBACK TRANSACTION RETURN 0 

EXEC cadastrar_roupa 'Camisa SPFC I 2018', 'Adidas', 'Futebol', 249, 'Branco', 150, 0, 'Camisa', 'P', 'São Paulo FC'