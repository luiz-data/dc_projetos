
## Documentação🔧

Cenário:
Rafaela possui vários temas de festas infantis para aluguel.

Ela precisa controlar os aluguéis e para isso quer uma aplicação que permita cadastrar: o nome e o telefone do cliente, o endereço completo da festa, o tema escolhido, a data da festa, a hora de início e término da festa.

Além disso, para alguns clientes antigos, Rafaela oferece descontos. Sendo assim, é preciso saber o valor realmente cobrado num determinado aluguel.

Para cada tema, é preciso controlar: a lista de itens que compõem o tema (ex: castelo, boneca da Cinderela, bruxa etc.), o valor do aluguel e a cor da toalha da mesa que deve ser usada com o tema.

Objetivo: Descrever o cenário em SQL e diagrama.


| **Tabelas** | **Composição** | **Excplicação** |
|-------------------|----------------|-----------|
| `Cliente` | *id_cliente SERIAL PRIMARY KEY* | Cria campo ID auto-incremento como chave primária |
| `Cliente` | *nome VARCHAR(100) NOT NULL* | Campo nome do cliente, obrigatório, até 100 caracteres |
| `Cliente` | *telefone VARCHAR(15) NOT NULL* | Campo telefone do cliente, obrigatório, até 15 caracteres |
| `Cliente` | *endereco_cliente VARCHAR(200) NOT NULL* | Campo endereço do cliente para correspondência, obrigatório, até 200 caracteres |
| | | |
| `Tema` | *id_tema SERIAL PRIMARY KEY* | Cria campo ID auto-incremento como chave primária |
| `Tema` | *nome_tema VARCHAR(50) NOT NULL UNIQUE* | Nome do tema, obrigatório e único (não pode repetir), até 50 caracteres |
| `Tema` | * valor_base NUMERIC(8,2) NOT NULL* |  Valor base do tema, obrigatório, formato decimal (8 dígitos, 2 casas decimais) |
| `Tema` | *cor_toalha VARCHAR(30)* |  Cor da toalha do tema, opcional, até 30 caracteres |
| | | |
| `Item` | * id_item SERIAL PRIMARY KEY* | Cria campo ID auto-incremento como chave primária |
| `Item` | * nome_item VARCHAR(100) NOT NULL* | Nome do item, obrigatório, até 100 caracteres |
| `Item` | * categoria VARCHAR(50)* | Categoria do item (ex: decoração, brinquedo), opcional, até 50 caracteres |
| | | |
| `Festa` | * id_festa SERIAL PRIMARY KEY* | Cria campo ID auto-incremento como chave primária |
| `Festa` | * cliente_id INTEGER NOT NULL* | Referência ao cliente que contratou a festa, obrigatório |
| `Festa` | * tema_id INTEGER NOT NULL* | Referência ao tema escolhido para a festa, obrigatório |
| `Festa` | * endereco_festa VARCHAR(200) NOT NULL* | Local onde a festa será realizada, obrigatório, até 200 caracteres |
| `Festa` | * data_festa DATE NOT NULL* | Data em que a festa acontecerá, obrigatório |
| `Festa` | * hora_inicio TIME NOT NULL* | Horário de início da festa, obrigatório |
| `Festa` | * hora_termino TIME NOT NULL* | Horário de término da festa, obrigatório |
| `Festa` | * valor_original NUMERIC(8,2) NOT NULL* | Valor original do tema, obrigatório, formato decimal |
| `Festa` | * cliente_antigo BOOLEAN DEFAULT FALSE* | Flag indicando se cliente é antigo, padrão falso |
| `Festa` | * percentual_desconto NUMERIC(5,2) DEFAULT 0.00* | Percentual de desconto aplicado, padrão 0% |
| `Festa` | * valor_final NUMERIC(8,2)* | Valor final após aplicar desconto, opcional |
| `Festa` | * CONSTRAINT fk_festa_cliente FOREIGN KEY (cliente_id) REFERENCES CLIENTE(id_cliente)* | Cria relacionamento: cliente_id deve existir na tabela CLIENTE |
| `Festa` | * CONSTRAINT fk_festa_tema FOREIGN KEY (tema_id) REFERENCES TEMA(id_tema)* | Cria relacionamento: tema_id deve existir na tabela TEMA |
| | | |
| `Composição_tema` | * tema_id INTEGER NOT NULL* | Referência ao tema, obrigatório |
| `Composição_tema` | * item_id INTEGER NOT NULL* | Referência ao item, obrigatório |
| `Composição_tema` | * item_id INTEGER NOT NULL* | Referência ao item, obrigatório |
| `Composição_tema` | * quantidade INTEGER NOT NULL DEFAULT 1* | Quantidade do item no tema, obrigatório, padrão 1 |
| `Composição_tema` | * PRIMARY KEY (tema_id, item_id)* | Define chave primária composta (tema_id + item_id)|
| `Composição_tema` | * PRIMARY KEY (tema_id, item_id)* | Define chave primária composta (tema_id + item_id)|
| `Composição_tema` | * CONSTRAINT fk_composicao_tema FOREIGN KEY (tema_id) REFERENCES TEMA(id_tema)* | Cria relacionamento: tema_id deve existir na tabela TEMA|
| `Composição_tema` | * CONSTRAINT fk_composicao_item FOREIGN KEY (item_id) REFERENCES ITEM(id_item)* | Cria relacionamento: item_id deve existir na tabela ITEM|


## Fluxo

Cliente |-< Festa >-| Tema |-< Composição Tema >-| Item 
