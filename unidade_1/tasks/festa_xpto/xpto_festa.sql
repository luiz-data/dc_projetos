/* Projeto xpto_festa */

/* Cenário
Rafaela possui vários temas de festas infantis para aluguel.
Ela precisa controlar os aluguéis e para isso quer uma aplicação que permita cadastrar: o
nome e o telefone do cliente, o endereço completo da festa, o tema escolhido, a data da
festa, a hora de início e término da festa.
Além disso, para alguns clientes antigos, Rafaela oferece descontos. Sendo assim, é
preciso saber o valor realmente cobrado num determinado aluguel.
Para cada tema, é preciso controlar: a lista de itens que compõem o tema (ex: castelo,
boneca da Cinderela, bruxa etc.), o valor do aluguel e a cor da toalha da mesa que deve
ser usada com o tema.
*/

-- 1. TABELA CLIENTE
CREATE TABLE CLIENTE (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    endereco_cliente VARCHAR(200) NOT NULL
);

-- 2. TABELA TEMA
CREATE TABLE TEMA (
    id_tema SERIAL PRIMARY KEY,
    nome_tema VARCHAR(50) NOT NULL UNIQUE,
    valor_base NUMERIC(8,2) NOT NULL,
    cor_toalha VARCHAR(30)
);

-- 3. TABELA ITEM
CREATE TABLE ITEM (
    id_item SERIAL PRIMARY KEY,
    nome_item VARCHAR(100) NOT NULL,
    categoria VARCHAR(50)
);

-- 4. TABELA FESTA
CREATE TABLE FESTA (
    id_festa SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    tema_id INTEGER NOT NULL,
    endereco_festa VARCHAR(200) NOT NULL,
    data_festa DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_termino TIME NOT NULL,
    valor_original NUMERIC(8,2) NOT NULL,
    cliente_antigo BOOLEAN DEFAULT FALSE,
    percentual_desconto NUMERIC(5,2) DEFAULT 0.00,
    valor_final NUMERIC(8,2),
    
    CONSTRAINT fk_festa_cliente FOREIGN KEY (cliente_id) REFERENCES CLIENTE(id_cliente),
    CONSTRAINT fk_festa_tema FOREIGN KEY (tema_id) REFERENCES TEMA(id_tema)
);

-- 5. TABELA COMPOSICAO_TEMA
CREATE TABLE COMPOSICAO_TEMA (
    tema_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL DEFAULT 1,
    
    PRIMARY KEY (tema_id, item_id),
    CONSTRAINT fk_composicao_tema FOREIGN KEY (tema_id) REFERENCES TEMA(id_tema),
    CONSTRAINT fk_composicao_item FOREIGN KEY (item_id) REFERENCES ITEM(id_item)
);