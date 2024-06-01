/* Projeto de Banco de Dados 2 */
/* Mod_Lógico_Definitivo */
/* Matheus Lopes de Oliveira - CJ3023494 */

CREATE DATABASE escola_v1;

USE DATABASE escola_v1;

CREATE TABLE FUNCIONARIOS (
    id_funcionario INT,
    cpf VARCHAR(11),
    primeiro_nome VARCHAR(50),
    nome_do_meio VARCHAR(50),
    ultimo_nome VARCHAR(50),
    id_departamento INT,
    data_de_nascimento DATE,
    sexo CHAR(1),
    estado_civil VARCHAR(20),
    naturalidade VARCHAR(50),
    naturalizaçao VARCHAR(50),
    rg VARCHAR(20),
    telefone_fixo VARCHAR(15),
    celular VARCHAR(15),
    email VARCHAR(50),
    endereco VARCHAR(100),
    numero VARCHAR(4),
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    cep VARCHAR(10),
    comprovante_de_residencia BLOB,
    declaracao_de_escolaridade BLOB,
    comprovante_de_formacao BLOB,
    titulo_de_eleitor BLOB,
    certificado_militar BLOB,
    curriculo BLOB,
    ficha_medica BLOB,
    conta_bancaria VARCHAR(20),
    salario_bruto DECIMAL(10,2),
    salario_liquido DECIMAL(10,2),
    login varchar(50),
    palavra_chave varchar(50),
    nivel_permissao INT,
    status TINYINT CHECK (status IN (0, 1)),
    data_criacao DATETIME,
    data_atualizacao DATETIME,
    data_exclusao DATETIME,
    PRIMARY KEY (id_funcionario, status, cpf),
    UNIQUE (id_funcionario, login, palavra_chave, cpf),
    FOREIGN KEY (id_departamento)
    REFERENCES DEPARTAMENTOS (id_departamento)
    ON DELETE RESTRICT
);

CREATE TABLE DEPARTAMENTOS (
    id_departamento INT UNIQUE,
    nome VARCHAR(50),
    descricao VARCHAR(200),
    id_funcionario_gestor INT,
    primeiro_nome_gestor VARCHAR(50),
    nome_do_meio_gestor VARCHAR(50),
    ultimo_nome_gestor VARCHAR(50),
    descricao_gestor VARCHAR(200),
    status TINYINT CHECK (status IN (0, 1)),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_alteracao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    PRIMARY KEY (id_departamento, id_funcionario_gestor),
    FOREIGN KEY (id_funcionario_gestor, id_funcionario_exclusao, id_funcionario_ultima_alt, id_funcionario_criador)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario, id_funcionario)
);

CREATE TABLE EVENTOS (
    id_evento INT PRIMARY KEY UNIQUE,
    nome VARCHAR(50),
    descricao VARCHAR(200),
    local VARCHAR(100),
    data_hora_inicio DATETIME,
    data_hora_fim DATETIME,
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_atualizacao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    FOREIGN KEY (id_funcionario_criador, id_funcionario_ultima_alt, id_funcionario_exclusao)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario)
    ON DELETE RESTRICT
);

CREATE TABLE PAGAMENTOS (
    id_pagamento INT PRIMARY KEY UNIQUE,
    id_funcionario INT,
    id_gestor_criador INT,
    descricao VARCHAR(100),
    valor DECIMAL(10,2),
    data_emissao DATETIME,
    status TINYINT CHECK (status IN (0, 1)),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_atualizacao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    FOREIGN KEY (id_funcionario, id_funcionario_criador, id_funcionario_exclusao, id_funcionario_ultima_alt)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario, id_funcionario)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_funcionario, id_funcionario_criador, id_funcionario_exclusao, id_funcionario_ultima_alt)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario, id_funcionario)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_gestor_criador)
    REFERENCES DEPARTAMENTOS (id_funcionario_gestor)
    ON DELETE RESTRICT
);

CREATE TABLE CONTAS_A_PAGAR (
    id_conta_pagar INT PRIMARY KEY UNIQUE,
    descricao VARCHAR(100),
    valor_total DECIMAL(10,2),
    valor_pago DECIMAL(10,2),
    id_forma_pagamento INT,
    juros DECIMAL(10,2),
    multa DECIMAL(10,2),
    tipo_de_conta VARCHAR(50),
    centro_de_custo VARCHAR(50),
    status_da_conta VARCHAR(20),
    documento BLOB,
    codigo_de_barras VARCHAR(50),
    data_emissao DATETIME,
    data_vencimento DATE,
    data_pagamento DATETIME,
    status TINYINT CHECK (status IN (0, 1)),
    id_funcionario_criacao INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_alteracao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    FOREIGN KEY (id_funcionario_exclusao, id_funcionario_ultima_alt, id_funcionario_criacao)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario)
    ON DELETE CASCADE,
    FOREIGN KEY (id_forma_pagamento)
    REFERENCES FORMAS_DE_PAGAMENTO (id_forma_pagamento)
    ON DELETE RESTRICT,
    
);

CREATE TABLE CONTAS_A_RECEBER (
    id_conta_receber INT PRIMARY KEY UNIQUE,
    descricao VARCHAR(100),
    documento BLOB,
    id_forma_pagamento INT,
    parcelas_pagas INT,
    parcelas_restantes INT,
    valor_total DECIMAL(10,2),
    valor_recebido DECIMAL(10,2),
    juros DECIMAL(10,2),
    multa DECIMAL(10,2),
    data_primeiro_pagamento DATETIME,
    data_ultimo_pagamento DATETIME,
    status_da_conta VARCHAR(20),
    status TINYINT CHECK (status IN (0, 1)),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_alteracao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    FOREIGN KEY (id_funcionario_criador, id_funcionario_ultima_alt, id_funcionario_exclusao)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario)
    ON DELETE CASCADE,
    FOREIGN KEY (id_forma_pagamento)
    REFERENCES FORMAS_DE_PAGAMENTO (id_forma_pagamento)
    ON DELETE RESTRICT
);

CREATE TABLE FORMAS_DE_PAGAMENTO (
    id_forma_pagamento INT PRIMARY KEY UNIQUE,
    nome VARCHAR(50),
    tipo_financeiro VARCHAR(50),
    tipo_recebimento VARCHAR(50),
    dias_para_receber INT,
    conta_banco VARCHAR(15),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_atualizacao DATETIME,
    FOREIGN KEY (id_funcionario_ultima_alt, id_funcionario_criador)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario)
);

CREATE TABLE MENSALIDADES (
    id_mensalidade INT PRIMARY KEY,
    id_conta_receber INT,
    id_responsavel INT,
    id_forma_pagamento INT,
    data_transacao DATETIME,
    data_vencimento DATE,
    status TINYINT CHECK (status IN (0, 1)),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_alteracao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    UNIQUE (id_mensalidade, id_conta_receber),
    FOREIGN KEY (id_forma_pagamento)
    REFERENCES FORMAS_DE_PAGAMENTO (id_forma_pagamento)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_conta_receber)
    REFERENCES CONTAS_A_RECEBER (id_conta_receber)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_funcionario_exclusao, id_funcionario_ultima_alt, id_funcionario_criador)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_responsavel)
    REFERENCES RESPONSAVEIS (id_responsavel)
);

CREATE TABLE RESPONSAVEIS (
    id_responsavel INT,
    cpf VARCHAR(11),
    primeiro_nome VARCHAR(50),
    nome_do_meio VARCHAR(50),
    ultimo_nome VARCHAR(50),
    data_de_nascimento DATE,
    sexo CHAR(1),
    estado_civil VARCHAR(50),
    naturalidade VARCHAR(50),
    naturalizacao VARCHAR(50),
    rg VARCHAR(20),
    telefone_fixo VARCHAR(15),
    telefone_celular VARCHAR(15),
    email VARCHAR(100),
    endereco VARCHAR(100),
    numero VARCHAR(4),
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    cep VARCHAR(10),
    comprovante_de_residencia BLOB,
    conta_bancaria VARCHAR(15),
    valor_mensalidade DECIMAL(10,2),
    id_parceiro INT,
    desconto_mensalidade VARCHAR(50),
    observacao VARCHAR(100),
    status TINYINT CHECK (status IN (0, 1)),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_atualizacao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    PRIMARY KEY (id_responsavel, cpf),
    UNIQUE (id_responsavel, cpf),
    FOREIGN KEY (id_parceiro, desconto_mensalidade)
    REFERENCES PARCEIROS (id_parceiro, desconto_mensalidade)
    ON DELETE CASCADE,
    FOREIGN KEY (id_funcionario_criador, id_funcionario_ultima_alt, id_funcionario_exclusao)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario)
);

CREATE TABLE PARCEIROS (
    id_parceiro INT UNIQUE,
    desconto_mensalidade VARCHAR(50),
    nome_fantasia VARCHAR(100),
    cnpj VARCHAR(15),
    cpf VARCHAR(11),
    inscricao_estadual CHAR(9),
    endereco VARCHAR(100),
    numero VARCHAR(4),
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    cep VARCHAR(10),
    observacao VARCHAR(100),
    status TINYINT CHECK (status IN (0, 1)),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_atualizacao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    PRIMARY KEY (id_parceiro, desconto_mensalidade),
    FOREIGN KEY (id_funcionario_criador, id_funcionario_ultima_alt, id_funcionario_exclusao)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario)
);

CREATE TABLE SECRETARIOS (
    id_secretario INT,
    id_funcionario INT,
    primeiro_nome VARCHAR(50),
    ultimo_nome VARCHAR(50),
    status TINYINT CHECK (status IN (0, 1)),
    PRIMARY KEY (id_secretario, id_funcionario),
    UNIQUE (id_secretario, id_funcionario),
    FOREIGN KEY (id_funcionario, status)
    REFERENCES FUNCIONARIOS (id_funcionario, status)
    ON DELETE CASCADE
);

CREATE TABLE ALUNOS (
    matricula VARCHAR(20),
    cpf VARCHAR(11),
    primeiro_nome VARCHAR(50),
    nome_do_meio VARCHAR(50),
    ultimo_nome VARCHAR(50),
    id_turma INT,
    id_curso INT,
    data_de_nascimento DATE,
    sexo CHAR(1),
    naturalidade VARCHAR(50),
    naturalizacao VARCHAR(50),
    rg VARCHAR(20),
    endereco VARCHAR(100),
    numero VARCHAR(4),
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    cep VARCHAR(10),
    comprovante_de_residencia BLOB,
    declaracao_matricula BLOB,
    id_motorista_van INT,
    certidao_de_nascimento DECIMAL(10,2),
    declaracao_de_escolaridade DATETIME,
    declaracao_de_adimplencia DATETIME,
    ficha_medica DATETIME,
    carteira_de_vacina DATETIME,
    observacao VARCHAR(100),
    status TINYINT CHECK (status IN (0, 1)),
    id_secretario_criador INT,
    data_criacao DATETIME,
    id_secretario_ultima_alt INT,
    data_atualizacao DATETIME,
    id_secretario_exclusao INT,
    data_exclusao DATETIME,
    PRIMARY KEY (matricula, cpf),
    UNIQUE (matricula, cpf),
    FOREIGN KEY (id_secretario_criador, id_secretario_criador, id_secretario_exclusao, id_secretario_ultima_alt)
    REFERENCES SECRETARIOS (id_secretario, id_secretario, id_secretario, id_secretario)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_motorista_van)
    REFERENCES MOTORISTAS (id_motorista)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_turma)
    REFERENCES TURMAS (id_turma)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_curso)
    REFERENCES CURSOS (id_curso)
    ON DELETE RESTRICT
);

CREATE TABLE GRAU_PARENTESCO (
    id_grau_parentesco INT PRIMARY KEY UNIQUE,
    id_responsavel INT,
    matricula_aluno VARCHAR(20),
    cpf_aluno VARCHAR(11),
    grau_de_parentesco VARCHAR(50),
    FOREIGN KEY (id_responsavel)
    REFERENCES RESPONSAVEIS (id_responsavel),
    FOREIGN KEY (matricula_aluno, cpf_aluno)
    REFERENCES ALUNOS (matricula, cpf)
);

CREATE TABLE MOTORISTAS (
    id_motorista INT,
    cpf VARCHAR(11),
    placa_van varchar(7),
    primeiro_nome VARCHAR(50),
    nome_do_meio VARCHAR(50),
    ultimo_nome VARCHAR(50),
    rg VARCHAR(20),
    cnh VARCHAR(9),
    telefone_fixo VARCHAR(15),
    telefone_celular VARCHAR(15),
    email VARCHAR(100),
    conta_bancaria VARCHAR(15),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_alteracao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    PRIMARY KEY (id_motorista, cpf),
    UNIQUE (id_motorista, cpf, cnh, conta_bancaria),
    FOREIGN KEY (placa_van)
    REFERENCES VANS_ESCOLARES (placa)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_funcionario_criador, id_funcionario_ultima_alt, id_funcionario_exclusao)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario)
);

CREATE TABLE VANS_ESCOLARES (
    placa varchar(7) PRIMARY KEY,
    renavam BLOB,
    modelo VARCHAR(50),
    capacidade INT,
    valor_aluguel DECIMAL(10,2),
    UNIQUE (renavam, placa)
);

CREATE TABLE SALAS (
    id_sala INT PRIMARY KEY UNIQUE,
    numero INT,
    descricao VARCHAR(100),
    tipo VARCHAR(50),
    corredor INT,
    andar INT,
    observacao VARCHAR(100),
    data_criacao DATETIME,
    data_atualizacao DATETIME
);

CREATE TABLE TURMAS (
    id_turma INT PRIMARY KEY UNIQUE,
    id_serie INT,
    nome VARCHAR(50),
    ano YEAR,
    descricao VARCHAR(100),
    id_sala INT,
    status TINYINT CHECK (status IN (0, 1)),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_atualizacao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    FOREIGN KEY (id_sala)
    REFERENCES SALAS (id_sala)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_serie)
    REFERENCES SERIES (id_serie)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_funcionario_criador, id_funcionario_ultima_alt, id_funcionario_exclusao)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario)
);

CREATE TABLE SERIES (
    id_serie INT PRIMARY KEY UNIQUE,
    id_modalidade INT,
    nome VARCHAR(50),
    descricao VARCHAR(100),
    grade_curricular BLOB,
    status TINYINT CHECK (status IN (0, 1)),
    data_criacao DATETIME,
    data_atualizacao DATETIME,
    data_exclusao DATETIME,
    FOREIGN KEY (id_modalidade)
    REFERENCES MODALIDADES (id_modalidade)
    ON DELETE RESTRICT
);

CREATE TABLE MODALIDADES (
    id_modalidade INT PRIMARY KEY UNIQUE,
    nome VARCHAR(50),
    descricao VARCHAR(100),
    matriz_curricular BLOB,
    projeto_politico_pedagogico BLOB,
    status TINYINT CHECK (status IN (0, 1)),
    data_criacao DATETIME,
    data_atualizacao DATETIME,
    data_exclusao DATETIME
);

CREATE TABLE CURSOS (
    id_curso INT PRIMARY KEY UNIQUE,
    nome VARCHAR(50),
    id_modalidade INT,
    descricao VARCHAR(100),
    data_inicial_periodo DATE,
    data_final_periodo DATE,
    observacao VARCHAR(100),
    status TINYINT CHECK (status IN (0, 1)),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_atualizacao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    FOREIGN KEY (id_modalidade)
    REFERENCES MODALIDADES (id_modalidade)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_funcionario_criador, id_funcionario_ultima_alt, id_funcionario_exclusao)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario)
);

CREATE TABLE LISTAS_DE_PRESENCA (
    id_lista INT,
    id_aula INT,
    id_disciplina INT,
    id_turma INT,
    matricula_aluno VARCHAR(20),
    cpf_aluno VARCHAR(11),
    nome_completo_aluno VARCHAR(50),
    assiduidade VARCHAR(100),
    observacao VARCHAR(100),
    id_professor_responsavel INT,
    data_criacao DATETIME,
    data_alteracao DATETIME,
    PRIMARY KEY (id_aula, id_lista),
    UNIQUE (id_lista, id_aula),
    FOREIGN KEY (id_turma)
    REFERENCES TURMAS (id_turma),
    FOREIGN KEY (id_disciplina)
    REFERENCES DISCIPLINAS (id_disciplina),
    FOREIGN KEY (matricula_aluno, cpf_aluno)
    REFERENCES ALUNOS (matricula, cpf),
    FOREIGN KEY (id_aula)
    REFERENCES AULAS (id_aula),
    FOREIGN KEY (id_professor_responsavel)
    REFERENCES PROFESSORES (id_professor)
);

CREATE TABLE NOTAS_MEDIAS (
    id_media INT PRIMARY KEY UNIQUE,
    id_boletim INT,
    matricula_aluno VARCHAR(20),
    cpf_aluno VARCHAR(11),
    id_disciplina INT,
    nota_avaliacao_1 DECIMAL(4,2),
    nota_trabalho DECIMAL(4,2),
    nota_avaliacao_2 DECIMAL(4,2),
    nota_assiduidade DECIMAL(4,2),
    observacao VARCHAR(100),
    id_professor_criador INT,
    data_criacao DATETIME,
    id_professor_ultima_alt INT,
    data_atualizacao DATETIME,
    FOREIGN KEY (matricula_aluno, cpf_aluno)
    REFERENCES ALUNOS (matricula, cpf)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_disciplina)
    REFERENCES DISCIPLINAS (id_disciplina)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_boletim)
    REFERENCES BOLETINS (id_boletim),
    FOREIGN KEY (id_professor_ultima_alt, id_professor_criador)
    REFERENCES PROFESSORES (id_professor, id_professor)
);

CREATE TABLE PROFESSORES (
    id_funcionario INT,
    id_professor INT,
    primeiro_nome VARCHAR(50),
    ultimo_nome VARCHAR(50),
    status TINYINT CHECK (status IN (0, 1)),
    PRIMARY KEY (id_professor, id_funcionario),
    UNIQUE (id_funcionario, id_professor),
    FOREIGN KEY (id_funcionario, status)
    REFERENCES FUNCIONARIOS (id_funcionario, status)
    ON DELETE CASCADE
);

CREATE TABLE DISCIPLINAS (
    id_disciplina INT PRIMARY KEY UNIQUE,
    id_professor_responsavel INT,
    nome VARCHAR(50),
    id_dia_hora_ministrada INT,
    conteudo_abordado VARCHAR(500),
    observacao VARCHAR(100),
    status TINYINT CHECK (status IN (0, 1)),
    id_funcionario_criador INT,
    data_criacao DATETIME,
    id_funcionario_ultima_alt INT,
    data_atualizacao DATETIME,
    id_funcionario_exclusao INT,
    data_exclusao DATETIME,
    FOREIGN KEY (id_dia_hora_ministrada)
    REFERENCES DIAS_MINISTRADOS (id_dia_hora)
    ON DELETE NO ACTION,
    FOREIGN KEY (id_professor_responsavel)
    REFERENCES PROFESSORES (id_professor)
    ON DELETE RESTRICT,
    FOREIGN KEY (id_funcionario_criador, id_funcionario_ultima_alt, id_funcionario_exclusao)
    REFERENCES FUNCIONARIOS (id_funcionario, id_funcionario, id_funcionario)
);

CREATE TABLE DIAS_MINISTRADOS (
    id_dia_hora INT NOT NULL PRIMARY KEY UNIQUE,
    id_disciplina INT,
    id_turma INT,
    data_hora_aula DATETIME,
    FOREIGN KEY (id_disciplina)
    REFERENCES DISCIPLINAS (id_disciplina),
    FOREIGN KEY (id_turma)
    REFERENCES TURMAS (id_turma)
);

CREATE TABLE BOLETINS (
    id_boletim INT PRIMARY KEY UNIQUE,
    matricula_aluno VARCHAR(20),
    cpf_aluno VARCHAR(11),
    semestre INT,
    data_criacao DATETIME,
    data_atualizacao DATETIME,
    FOREIGN KEY (matricula_aluno, cpf_aluno)
    REFERENCES ALUNOS (matricula, cpf)
);

CREATE TABLE AULAS (
    id_aula INT PRIMARY KEY UNIQUE,
    id_dia_hora INT,
    id_disciplina INT,
    id_turma INT,
    FOREIGN KEY (matricula_aluno, cpf_aluno)
    REFERENCES ALUNOS (matricula, cpf),
    FOREIGN KEY (id_dia_hora)
    REFERENCES DIAS_MINISTRADOS (id_dia_hora),
    FOREIGN KEY (id_disciplina)
    REFERENCES DISCIPLINAS (id_disciplina),
    FOREIGN KEY (id_turma)
    REFERENCES TURMAS (id_turma)
);