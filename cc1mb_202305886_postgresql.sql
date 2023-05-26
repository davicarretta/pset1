--Excluir banco de dados caso já exista.
DROP DATABASE IF EXISTS uvv;

--Excluir schema caso já exista.
DROP SCHEMA IF EXISTS lojas CASCADE;

--Excluir usuário caso já exista.
DROP USER IF EXISTS davicarretta;

--Criar usuário com permissões de gerenciar bancos de dados e roles.
CREATE USER davicarretta WITH PASSWORD '5e08486a9f28ed233882abd9d4a5a8b4';
ALTER USER  davicarretta CREATEDB;
ALTER USER  davicarretta CREATEROLE;

--Criar banco de dados.
CREATE DATABASE     uvv
WITH
OWNER             = davicarretta
TEMPLATE          = template0
ENCODING          = "UTF8"
LC_COLLATE        = 'pt_BR.UTF-8'
LC_CTYPE          = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = true;

--Entrar no usuário davicarretta e ao banco de dados uvv.
\connect "host=localhost port=5432 dbname=uvv user=davicarretta password=5e08486a9f28ed233882abd9d4a5a8b4 connect_timeout=1000";

--Criar esquema e permitir acesso do usuário.
CREATE SCHEMA lojas 
AUTHORIZATION davicarretta;

--Definir esquema lojas como o padrão.
SET search_path TO lojas, davicarretta, public;
ALTER USER davicarretta SET search_path TO lojas, davicarretta, public;

--Criar tabela lojas.
CREATE TABLE lojas.lojas (
                loja_id                 NUMERIC(38)  NOT NULL ,
                nome                    VARCHAR(255) NOT NULL ,
                endereco_web            VARCHAR(100)          ,
                endereco_fisico         VARCHAR(512)          ,
                latitude                NUMERIC               ,
                longitude               NUMERIC               ,
                logo                    BYTEA                 ,
                logo_mime_type          VARCHAR(512)          ,
                logo_arquivo            VARCHAR(512)          ,
                logo_charset            VARCHAR(512)          ,
                logo_ultima_atualizacao DATE                  ,
                CONSTRAINT pk_lojas     PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas.lojas IS                          'Tabela das lojas cadastradas nas Lojas UVV.';
COMMENT ON COLUMN lojas.lojas.loja_id IS                 'IDs de cada loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.nome IS                    'Nome de cada loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS            'Endereço Web (link on-line) para o site de cada loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS         'Endereço físico de cada loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.latitude IS                'Latitude de cada loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.longitude IS               'Longitude de cada loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.logo IS                    'Logo de cada loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS          'Tipo de mídia das logos de cada loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS            'Arquivo das logos de cada loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS            'Codificação de caracteres das logos de cada loja cadastrada.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data da última atualização das logos de cada loja cadastrada.';

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_loja_id
    CHECK (loja_id between 1 AND 38);
ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_nome
    CHECK (loja_id IS NOT NULL);

--Criar tabela produtos.
CREATE TABLE lojas.produtos (
                produto_id                NUMERIC(38)   NOT NULL ,
                nome                      VARCHAR(255)  NOT NULL ,
                preco_unitario            NUMERIC(10,2)          ,
                detalhes                  BYTEA                  ,
                imagem                    BYTEA                  ,
                imagem_mime_type          VARCHAR(512)           ,
                imagem_arquivo            VARCHAR(512)           ,
                imagem_charset            VARCHAR(512)           ,
                imagem_ultima_atualizacao DATE                   ,
                CONSTRAINT pk_produtos    PRIMARY KEY (produto_id)
);
COMMENT ON TABLE lojas.produtos IS                            'Tabela dos produtos cadastrados nas Lojas UVV.';
COMMENT ON COLUMN lojas.produtos.produto_id IS                'IDs de cada produto cadastrado.';
COMMENT ON COLUMN lojas.produtos.nome IS                      'Nome de cada produto cadastrado.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS            'Preço unitário de cada produto cadastrado.';
COMMENT ON COLUMN lojas.produtos.detalhes IS                  'Detalhes de cada produto cadastrado.';
COMMENT ON COLUMN lojas.produtos.imagem IS                    'Imagem de cada produto cadastrado.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS          'Tipo de mídia das imagens de cada produto cadastrado.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS            'Arquivo das imagens de cada produto cadastrado.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS            'Codificação de caracteres das imagens de cada produto cadastrado.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Data da última atualização das imagens de cada produto cadastrado.';

--Criar tabela estoques.
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL ,
                loja_id    NUMERIC(38) NOT NULL ,
                produto_id NUMERIC(38) NOT NULL ,
                quantidade NUMERIC(38) NOT NULL ,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS             'Tabela dos estoques cadastrados nas Lojas UVV.';
COMMENT ON COLUMN lojas.estoques.loja_id IS    'IDs de cada loja cadastrada.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'IDs de cada produto cadastrado.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade de estoque de cada produto em cada loja cadastrada.';

ALTER TABLE estoques 
ADD CONSTRAINT cc_estoques_estoque_id
    CHECK (estoque_id > 0 AND < 100000000000000000000000000000000000000);
ALTER TABLE estoques 
ADD CONSTRAINT cc_estoques_loja_id
    CHECK (loja_id > 0 AND < 100000000000000000000000000000000000000);
ALTER TABLE estoques
ADD CONSTRAINT cc_estoques_produto_id
    CHECK (produto_id > 0 AND < 100000000000000000000000000000000000000);
ALTER TABLE estoques
ADD CONSTRAINT cc_estoques_quantidade
    CHECK (quantidade >= 0 AND ROUND(quantidade));

--Criar tabela clientes.
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38)  NOT NULL ,
                email      VARCHAR(255) NOT NULL ,
                nome       VARCHAR(255) NOT NULL ,
                telefone1  VARCHAR(20)           ,
                telefone2  VARCHAR(20)           ,
                telefone3  VARCHAR(20)           ,
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS             'Tabela dos clientes cadastrados nas Lojas UVV.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'IDs de cada cliente cadastrado.';
COMMENT ON COLUMN lojas.clientes.email IS      'Email de cada cliente cadastrado.';
COMMENT ON COLUMN lojas.clientes.nome IS       'Nome de cada cliente cadastrado.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS  'Telefone 1 de cada cliente cadastrado.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS  'Telefone 2 de cada cliente cadastrado.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS  'Telefone 3 de cada cliente cadastrado.';

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_cliente_id
    CHECK (cliente_id BETWEEN > 0 AND < 100000000000000000000000000000000000000);
ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_email
    CHECK (email IS NOT NULL);
ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_nome
    CHECK (email IS NOT NULL);

--Criar tabela pedidos.
CREATE TABLE lojas.pedidos (
                pedido_id  NUMERIC  (38) NOT NULL ,
                data_hora  TIMESTAMP     NOT NULL ,
                cliente_id NUMERIC  (38) NOT NULL ,
                status     VARCHAR  (15) NOT NULL ,
                loja_id    NUMERIC  (38) NOT NULL ,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos IS             'Tabela dos pedidos cadastrados nas Lojas UVV.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS  'IDs de cada pedido cadastrado.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS  'Data e hora de cada pedido cadastrado.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'IDs de cada cliente cadastrado.';
COMMENT ON COLUMN lojas.pedidos.status IS     'Status de cada pedido cadastrado.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS    'IDs de cada loja cadastrada.';

ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_pedidos_id
    CHECK (pedido_id IS NOT NULL AND pedido_id > 0);
ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_data_hora
    CHECK (data_hora IS NOT NULL AND data_hora > 1672531200);
ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_cliente_id
    CHECK (cliente_id IS NOT NULL AND cliente_id > 0);
ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_status
    CHECK (status IS NOT NULL AND status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));
ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_loja_id
    CHECK (loja_id IS NOT NULL AND loja_id > 0);

--Criar tabela envios.
CREATE TABLE lojas.envios (
                envio_id         NUMERIC(38)  NOT NULL ,
                loja_id          NUMERIC(38)  NOT NULL ,
                cliente_id       NUMERIC(38)  NOT NULL ,
                endereco_entrega VARCHAR(512) NOT NULL ,
                status           VARCHAR(15)  NOT NULL ,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envios IS                   'Tabela dos envios cadastrados nas Lojas UVV.';
COMMENT ON COLUMN lojas.envios.envio_id IS         'IDs de cada envio cadastrado.';
COMMENT ON COLUMN lojas.envios.loja_id IS          'IDs de cada loja cadastrada.';
COMMENT ON COLUMN lojas.envios.cliente_id IS       'IDs de cada cliente cadastrado.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço de entrega de cada envio cadastrado.';
COMMENT ON COLUMN lojas.envios.status IS           'Status de cada envio cadastrado.';

--Criar tabelas pedidos_itens.
CREATE TABLE lojas.pedidos_itens (
                pedido_id       NUMERIC(38)   NOT NULL ,
                produto_id      NUMERIC(38)   NOT NULL ,
                numero_da_linha NUMERIC(38)   NOT NULL ,
                preco_unitario  NUMERIC(10,2) NOT NULL ,
                quantidade      NUMERIC(38)   NOT NULL ,
                envio_id        NUMERIC(38)            ,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS       'IDs de cada pedido cadastrado.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS      'IDs de cada produto cadastrado.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Número da linha de cada pedido de itens cadastrado.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS  'Preço unitário de cada produto cadastrado.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS      'Quantidade de pedidos de cada item cadastrado.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS        'IDs de cada envio cadastrado.';

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;