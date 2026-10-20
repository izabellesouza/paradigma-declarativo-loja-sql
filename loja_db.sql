-- ==========================================
-- ATIVIDADE PRÁTICA - PARADIGMA DECLARATIVO
-- SISTEMA DE LOJA
-- ==========================================


-- ==========================================
-- CRIAÇÃO DO BANCO
-- ==========================================

CREATE DATABASE loja_db;

USE loja_db;


-- ==========================================
-- CRIAÇÃO DAS TABELAS
-- ==========================================

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    idade INT NOT NULL
);


CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL
);


CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);


-- ==========================================
-- INSERÇÃO DOS DADOS
-- ==========================================

-- CLIENTES

INSERT INTO clientes (nome, email, cidade, idade)
VALUES
('Ana Silva', 'ana@email.com', 'João Pessoa', 28),
('Carlos Souza', 'carlos@email.com', 'Recife', 34),
('Mariana Lima', 'mariana@email.com', 'Natal', 22),
('Pedro Alves', 'pedro@email.com', 'João Pessoa', 41),
('Juliana Costa', 'juliana@email.com', 'Recife', 31),
('Bruno Santos', 'bruno@email.com', 'Natal', 19);

SELECT * FROM clientes;

-- PRODUTOS

INSERT INTO produtos (nome, categoria, preco, estoque)
VALUES
('Notebook Dell', 'Informática', 3500.00, 7),
('Mouse Gamer', 'Acessórios', 180.00, 25),
('Teclado Mecânico', 'Acessórios', 450.00, 8),
('Monitor 24', 'Eletrônicos', 1200.00, 6),
('Smartphone Samsung', 'Eletrônicos', 2500.00, 12),
('Impressora HP', 'Informática', 850.00, 4),
('Webcam HD', 'Informática', 320.00, 15),
('Fone Bluetooth', 'Eletrônicos', 600.00, 9);

SELECT * FROM produtos;

-- PEDIDOS

INSERT INTO pedidos (id_cliente, data_pedido, valor_total, status)
VALUES
(1, '2026-10-01', 1200.00, 'Pago'),
(2, '2026-10-02', 500.00, 'Pendente'),
(3, '2026-10-03', 2800.00, 'Pago'),
(1, '2026-10-04', 350.00, 'Cancelado'),
(4, '2026-10-05', 1700.00, 'Pago'),
(5, '2026-10-06', 900.00, 'Pendente'),
(6, '2026-10-07', 2100.00, 'Cancelado'),
(2, '2026-10-08', 1600.00, 'Pago');

SELECT * FROM pedidos;

-- ==========================================
-- CONSULTAS BÁSICAS
-- ==========================================

-- Questão 1
-- Mostrar todos os clientes cadastrados

SELECT *
FROM clientes;


-- Questão 2
-- Mostrar apenas o nome e o preço dos produtos

SELECT nome, preco
FROM produtos;


-- Questão 3
-- Mostrar todos os produtos com preço superior a R$ 500,00

SELECT *
FROM produtos
WHERE preco > 500;


-- Questão 4
-- Mostrar todos os produtos com estoque inferior a 10 unidades

SELECT *
FROM produtos
WHERE estoque < 10;


-- Questão 5
-- Mostrar todos os clientes que moram em João Pessoa

SELECT *
FROM clientes
WHERE cidade = 'João Pessoa';


-- Questão 6
-- Mostrar os pedidos que possuem status Pago

SELECT *
FROM pedidos
WHERE status = 'Pago';


-- ==========================================
-- CONSULTAS COM ORDENAÇÃO E FILTROS
-- ==========================================

-- Questão 7
-- Mostrar todos os produtos do mais caro para o mais barato

SELECT *
FROM produtos
ORDER BY preco DESC;


-- Questão 8
-- Mostrar clientes com idade entre 20 e 35 anos

SELECT *
FROM clientes
WHERE idade BETWEEN 20 AND 35;


-- Questão 9
-- Mostrar produtos cujo nome contenha a letra A

SELECT *
FROM produtos
WHERE nome LIKE '%a%';


-- Questão 10
-- Mostrar pedidos com valor total superior a R$ 1.000,00

SELECT *
FROM pedidos
WHERE valor_total > 1000;


-- ==========================================
-- FUNÇÕES DE AGREGAÇÃO
-- ==========================================

-- Questão 11
-- Mostrar a quantidade total de clientes cadastrados

SELECT COUNT(*) AS quantidade_clientes
FROM clientes;


-- Questão 12
-- Mostrar o preço médio dos produtos

SELECT AVG(preco) AS preco_medio
FROM produtos;


-- Questão 13
-- Mostrar o produto mais caro

SELECT *
FROM produtos
ORDER BY preco DESC
LIMIT 1;


-- Questão 14
-- Mostrar o produto mais barato

SELECT *
FROM produtos
ORDER BY preco ASC
LIMIT 1;


-- Questão 15
-- Mostrar a soma do valor de todos os pedidos com status Pago

SELECT SUM(valor_total) AS total_pedidos_pagos
FROM pedidos
WHERE status = 'Pago';


-- ==========================================
-- AGRUPAMENTO
-- ==========================================

-- Questão 16
-- Mostrar quantos produtos existem em cada categoria

SELECT categoria, COUNT(*) AS quantidade
FROM produtos
GROUP BY categoria;


-- Questão 17
-- Mostrar a quantidade de clientes de cada cidade

SELECT cidade, COUNT(*) AS quantidade_clientes
FROM clientes
GROUP BY cidade;


-- Questão 18
-- Mostrar a quantidade de pedidos existentes para cada status

SELECT status, COUNT(*) AS quantidade_pedidos
FROM pedidos
GROUP BY status;


-- ==========================================
-- RELACIONAMENTO ENTRE TABELAS
-- ==========================================

-- Questão 19
-- Mostrar o nome do cliente junto com os dados de seus pedidos

SELECT
    clientes.nome AS cliente,
    pedidos.id_pedido AS pedido,
    pedidos.data_pedido,
    pedidos.valor_total AS valor,
    pedidos.status
FROM clientes
INNER JOIN pedidos
    ON clientes.id_cliente = pedidos.id_cliente;


-- Questão 20
-- Mostrar apenas pedidos pagos,
-- apresentando nome do cliente, data e valor total

SELECT
    clientes.nome AS cliente,
    pedidos.data_pedido,
    pedidos.valor_total
FROM clientes
INNER JOIN pedidos
    ON clientes.id_cliente = pedidos.id_cliente
WHERE pedidos.status = 'Pago';


-- Questão 21
-- Mostrar clientes que realizaram pedidos
-- com valor superior a R$ 1.500,00

SELECT DISTINCT
    clientes.nome AS cliente
FROM clientes
INNER JOIN pedidos
    ON clientes.id_cliente = pedidos.id_cliente
WHERE pedidos.valor_total > 1500;


-- ==========================================
-- ATUALIZAÇÃO DE DADOS
-- ==========================================

-- Questão 22
-- Aumentar o estoque do Notebook Dell em 10 unidades

UPDATE produtos
SET estoque = estoque + 10
WHERE nome = 'Notebook Dell';

-- Conferência da Questão 22

SELECT *
FROM produtos
WHERE nome = 'Notebook Dell';


-- Questão 23
-- Alterar o preço do Mouse Gamer

UPDATE produtos
SET preco = 200.00
WHERE nome = 'Mouse Gamer';

-- Conferência da Questão 23

SELECT *
FROM produtos
WHERE nome = 'Mouse Gamer';


-- Questão 24
-- Alterar o status do pedido 2 de Pendente para Pago

UPDATE pedidos
SET status = 'Pago'
WHERE id_pedido = 2;

-- Conferência da Questão 24

SELECT *
FROM pedidos
WHERE id_pedido = 2;


-- ==========================================
-- EXCLUSÃO
-- ==========================================

-- Questão 25
-- Cadastrar um cliente adicional apenas para teste

INSERT INTO clientes (nome, email, cidade, idade)
VALUES
('Cliente Teste', 'teste@email.com', 'João Pessoa', 30);


-- Conferir cadastro do cliente

SELECT *
FROM clientes
WHERE email = 'teste@email.com';


-- Excluir o cliente de teste

DELETE FROM clientes
WHERE email = 'teste@email.com';


-- Conferir exclusão

SELECT *
FROM clientes
WHERE email = 'teste@email.com';


-- ==========================================
-- DESAFIO
-- ==========================================

-- Mostrar:
-- nome do cliente;
-- quantidade de pedidos realizados;
-- valor total gasto pelo cliente.

SELECT
    clientes.nome AS cliente,
    COUNT(pedidos.id_pedido) AS quantidade_pedidos,
    COALESCE(SUM(pedidos.valor_total), 0) AS total_gasto
FROM clientes
LEFT JOIN pedidos
    ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.id_cliente, clientes.nome
ORDER BY total_gasto DESC;