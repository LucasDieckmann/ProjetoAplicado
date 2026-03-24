
CREATE TABLE AMOSTRA (
    id_amostra SERIAL PRIMARY KEY,
    codigo_amostra VARCHAR(50),
    experimento VARCHAR(50),
    replica INTEGER
);

CREATE TABLE ABUNDANCIA (
    id_abundancia SERIAL PRIMARY KEY,
    intensidade NUMERIC,
    id_amostra INTEGER,
    FOREIGN KEY (id_amostra) REFERENCES AMOSTRA(id_amostra)
);

CREATE TABLE SINAL_ANALITICO (
    id_sinal_analitico SERIAL PRIMARY KEY,
    rotulo_composto VARCHAR(100),
    razao_mz NUMERIC,
    massa_neutra NUMERIC,
    tempo_retencao NUMERIC,
    largura_pico NUMERIC,
    id_abundancia INTEGER,
    FOREIGN KEY (id_abundancia) REFERENCES ABUNDANCIA(id_abundancia)
);

CREATE TABLE COMPOSTO (
    id_composto SERIAL PRIMARY KEY,
    identificador_composto VARCHAR(100),
    formula_quimica VARCHAR(100),
    descricao TEXT,
    massa_neutra NUMERIC,
    link_referencia TEXT
);

CREATE TABLE CLASSE_QUIMICA (
    id_classe_quimica SERIAL PRIMARY KEY,
    nome_classe VARCHAR(100)
);

-- relacionamento N:N (COMPOSTO x CLASSE_QUIMICA)
CREATE TABLE COMPOSTO_CLASSE (
    id_composto INTEGER,
    id_classe_quimica INTEGER,
    PRIMARY KEY (id_composto, id_classe_quimica),
    FOREIGN KEY (id_composto) REFERENCES COMPOSTO(id_composto),
    FOREIGN KEY (id_classe_quimica) REFERENCES CLASSE_QUIMICA(id_classe_quimica)
);

CREATE TABLE IDENTIFICACAO (
    id_identificacao SERIAL PRIMARY KEY,
    pontuacao_total NUMERIC,
    pontuacao_fragmentacao NUMERIC,
    erro_massa_ppm NUMERIC,
    similaridade_isotopica NUMERIC,
    id_sinal_analitico INTEGER,
    id_composto INTEGER,
    FOREIGN KEY (id_sinal_analitico) REFERENCES SINAL_ANALITICO(id_sinal_analitico),
    FOREIGN KEY (id_composto) REFERENCES COMPOSTO(id_composto)
);

CREATE TABLE ADUTO (
    id_aduto SERIAL PRIMARY KEY,
    tipo_aduto VARCHAR(50)
);

-- relacionamento IDENTIFICACAO x ADUTO
CREATE TABLE IDENTIFICACAO_ADUTO (
    id_identificacao INTEGER,
    id_aduto INTEGER,
    PRIMARY KEY (id_identificacao, id_aduto),
    FOREIGN KEY (id_identificacao) REFERENCES IDENTIFICACAO(id_identificacao),
    FOREIGN KEY (id_aduto) REFERENCES ADUTO(id_aduto)
);