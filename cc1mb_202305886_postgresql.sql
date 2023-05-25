--Excluir banco de dados caso já exista.
DROP DATABASE IF EXISTS uvv;

--Excluir usuário caso já exista.
DROP USER IF EXISTS davicarretta;

--Criar usuário com permissões.
CREATE USER davicarretta WITH PASSWORD '5e08486a9f28ed233882abd9d4a5a8b4';
ALTER USER davicarretta CREATEDB;
ALTER USER davicarretta CREATEROLE;

--Criar banco de dados.
CREATE DATABASE uvv
with
owner = davicarretta
template = template0
encoding = "UTF8"
lc_collate = 'pt_BR.UTF-8'
lc_ctype = 'pt_BR.UTF-8'
allow_connections = true;

--Entrar no usuário davicarretta e ao banco de dados uvv. RESOLVEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
\c uvv

--Criar esquema.
CREATE SCHEMA lojas 
AUTHORIZATION davicarretta;

--Definir esquema lojas como o padrão.
SET search_path TO lojas, davicarretta, public;
ALTER USER davicarretta SET search_path TO lojas, davicarretta, public;

--Criar tabela lojas.
CREATE TABLE public.lojas (
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
COMMENT ON TABLE public.lojas IS 'Tabela das lojas cadastradas nas Lojas UVV.';
COMMENT ON COLUMN public.lojas.loja_id IS 'ID''s de cada loja cadastrada.';
COMMENT ON COLUMN public.lojas.nome IS 'Nome de cada loja cadastrada.';
COMMENT ON COLUMN public.lojas.endereco_web IS 'Endereço Web (link on-line) para o site de cada loja cadastrada.';
COMMENT ON COLUMN public.lojas.endereco_fisico IS 'Endereço físico de cada loja cadastrada.';
COMMENT ON COLUMN public.lojas.latitude IS 'Latitude de cada loja cadastrada.';
COMMENT ON COLUMN public.lojas.longitude IS 'Longitude de cada loja cadastrada.';
COMMENT ON COLUMN public.lojas.logo IS 'Logo de cada loja cadastrada.';
COMMENT ON COLUMN public.lojas.logo_mime_type IS 'Tipo de mídia das logos de cada loja cadastrada.';
COMMENT ON COLUMN public.lojas.logo_arquivo IS 'Arquivo das logos de cada loja cadastrada.';
COMMENT ON COLUMN public.lojas.logo_charset IS 'Codificação de caracteres das logos de cada loja cadastrada.';
COMMENT ON COLUMN public.lojas.logo_ultima_atualizacao IS 'Data da última atualização das logos de cada loja cadastrada.';

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_loja_id
    CHECK (loja_id between 1 AND 38);
ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_nome
    CHECK (loja_id IS NOT NULL);

CREATE TABLE public.produtos (
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
COMMENT ON TABLE public.produtos IS 'Tabela dos produtos cadastrados nas Lojas UVV.';
COMMENT ON COLUMN public.produtos.produto_id IS 'ID''s de cada produto cadastrado.';
COMMENT ON COLUMN public.produtos.nome IS 'Nome de cada produto cadastrado.';
COMMENT ON COLUMN public.produtos.preco_unitario IS 'Preço unitário de cada produto cadastrado.';
COMMENT ON COLUMN public.produtos.detalhes IS 'Detalhes de cada produto cadastrado.';
COMMENT ON COLUMN public.produtos.imagem IS 'Imagem de cada produto cadastrado.';
COMMENT ON COLUMN public.produtos.imagem_mime_type IS 'Tipo de mídia das imagens de cada produto cadastrado.';
COMMENT ON COLUMN public.produtos.imagem_arquivo IS 'Arquivo das imagens de cada produto cadastrado.';
COMMENT ON COLUMN public.produtos.imagem_charset IS 'Codificação de caracteres das imagens de cada produto cadastrado.';
COMMENT ON COLUMN public.produtos.imagem_ultima_atualizacao IS 'Data da última atualização das imagens de cada produto cadastrado.';


CREATE TABLE public.estoques (
                estoque_id NUMERIC(38) NOT NULL ,
                loja_id    NUMERIC(38) NOT NULL ,
                produto_id NUMERIC(38) NOT NULL ,
                quantidade NUMERIC(38) NOT NULL ,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE public.estoques IS 'Tabela dos estoques cadastrados nas Lojas UVV.';
COMMENT ON COLUMN public.estoques.loja_id IS 'ID''s de cada loja cadastrada.';
COMMENT ON COLUMN public.estoques.produto_id IS 'ID''s de cada produto cadastrado.';
COMMENT ON COLUMN public.estoques.quantidade IS 'Quantidade de estoque de cada produto em cada loja cadastrada.';

ALTER TABLE estoques 
ADD CONSTRAINT cc_estoques_estoque_id
    CHECK (estoque_id between 1 AND 38);
ALTER TABLE estoques 
ADD CONSTRAINT cc_estoques_loja_id
    CHECK (loja_id between 1 AND 38);
ALTER TABLE estoques
ADD CONSTRAINT cc_estoques_produto_id
    CHECK (produto_id between 1 AND 38);
ALTER TABLE estoques
ADD CONSTRAINT cc_estoques_quantidade
    CHECK (quantidade between 1 AND 38);

CREATE TABLE public.clientes (
                cliente_id NUMERIC(38)  NOT NULL ,
                email      VARCHAR(255) NOT NULL ,
                nome       VARCHAR(255) NOT NULL ,
                telefone1  VARCHAR(20)           ,
                telefone2  VARCHAR(20)           ,
                telefone3  VARCHAR(20)           ,
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE public.clientes IS 'Tabela dos clientes cadastrados nas Lojas UVV.';
COMMENT ON COLUMN public.clientes.cliente_id IS 'ID''s de cada cliente cadastrado.';
COMMENT ON COLUMN public.clientes.email IS 'Email de cada cliente cadastrado.';
COMMENT ON COLUMN public.clientes.nome IS 'Nome de cada cliente cadastrado.';
COMMENT ON COLUMN public.clientes.telefone1 IS 'Telefone 1 de cada cliente cadastrado.';
COMMENT ON COLUMN public.clientes.telefone2 IS 'Telefone 2 de cada cliente cadastrado.';
COMMENT ON COLUMN public.clientes.telefone3 IS 'Telefone 3 de cada cliente cadastrado.';

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_cliente_id
    CHECK (cliente_id between 1 AND 38);
ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_email
    CHECK (email IS NOT NULL);
ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_nome
    CHECK (email IS NOT NULL);

CREATE TABLE public.pedidos (
                pedido_id  NUMERIC  (38) NOT NULL ,
                data_hora  TIMESTAMP     NOT NULL ,
                cliente_id NUMERIC  (38) NOT NULL ,
                status     VARCHAR  (15) NOT NULL ,
                loja_id    NUMERIC  (38) NOT NULL ,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE public.pedidos IS 'Tabela dos pedidos cadastrados nas Lojas UVV.';
COMMENT ON COLUMN public.pedidos.pedido_id IS 'ID''s de cada pedido cadastrado.';
COMMENT ON COLUMN public.pedidos.data_hora IS 'Data e hora de cada pedido cadastrado.';
COMMENT ON COLUMN public.pedidos.cliente_id IS 'ID''s de cada cliente cadastrado.';
COMMENT ON COLUMN public.pedidos.status IS 'Status de cada pedido cadastrado.';
COMMENT ON COLUMN public.pedidos.loja_id IS 'ID''s de cada loja cadastrada.';


CREATE TABLE public.envios (
                envio_id         NUMERIC(38)  NOT NULL ,
                loja_id          NUMERIC(38)  NOT NULL ,
                cliente_id       NUMERIC(38)  NOT NULL ,
                endereco_entrega VARCHAR(512) NOT NULL ,
                status           VARCHAR(15)  NOT NULL ,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);
COMMENT ON TABLE public.envios IS 'Tabela dos envios cadastrados nas Lojas UVV.';
COMMENT ON COLUMN public.envios.envio_id IS 'ID''s de cada envio cadastrado.';
COMMENT ON COLUMN public.envios.loja_id IS 'ID''s de cada loja cadastrada.';
COMMENT ON COLUMN public.envios.cliente_id IS 'ID''s de cada cliente cadastrado.';
COMMENT ON COLUMN public.envios.endereco_entrega IS 'Endereço de entrega de cada envio cadastrado.';
COMMENT ON COLUMN public.envios.status IS 'Status de cada envio cadastrado.';


CREATE TABLE public.pedidos_itens (
                pedido_id       NUMERIC(38)   NOT NULL ,
                produto_id      NUMERIC(38)   NOT NULL ,
                numero_da_linha NUMERIC(38)   NOT NULL ,
                preco_unitario  NUMERIC(10,2) NOT NULL ,
                quantidade      NUMERIC(38)   NOT NULL ,
                envio_id        NUMERIC(38)            ,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON COLUMN public.pedidos_itens.pedido_id IS 'ID''s de cada pedido cadastrado.';
COMMENT ON COLUMN public.pedidos_itens.produto_id IS 'ID''s de cada produto cadastrado.';
COMMENT ON COLUMN public.pedidos_itens.numero_da_linha IS 'Número da linha de cada pedido de itens cadastrado.';
COMMENT ON COLUMN public.pedidos_itens.preco_unitario IS 'Preço unitário de cada produto cadastrado.';
COMMENT ON COLUMN public.pedidos_itens.quantidade IS 'Quantidade de pedidos de cada item cadastrado.';
COMMENT ON COLUMN public.pedidos_itens.envio_id IS 'ID''s de cada envio cadastrado.';


ALTER TABLE public.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES public.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES public.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES public.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES public.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES public.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;