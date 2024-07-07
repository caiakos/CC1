DROP DATABASE FORTES;
CREATE DATABASE IF NOT EXISTS FORTES;
USE FORTES;

CREATE TABLE IF NOT EXISTS Instituicoes (
    idInstituicoes INT,
    CNPJ INT,
    nome VARCHAR(45) NOT NULL,
    comentario VARCHAR(45),
    PRIMARY KEY(idInstituicoes,CNPJ)
);

CREATE TABLE IF NOT EXISTS Enderecos (
    rua VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    numero VARCHAR(45),
    CEP VARCHAR(45) NOT NULL,
    Instituicoes_idInstituicoes INT NOT NULL,
    Instituicoes_CNPJ INT NOT NULL,
    CONSTRAINT End_Ins_idInstituicoes FOREIGN KEY (Instituicoes_idInstituicoes,Instituicoes_CNPJ) REFERENCES Instituicoes(idInstituicoes,CNPJ)
);

CREATE TABLE IF NOT EXISTS Usuarios (
    idUsuarios INT PRIMARY KEY,
    email VARCHAR(45) NOT NULL,
    nome VARCHAR(45)NOT NULL,
    senha VARCHAR(15) NOT NULL,
    Instituicoes_idInstituicoes INT NOT NULL,
    Instituicoes_CNPJ INT NOT NULL,
    CONSTRAINT Usu_Ins_idInstituicoes FOREIGN KEY (Instituicoes_idInstituicoes,Instituicoes_CNPJ) REFERENCES Instituicoes(idInstituicoes,CNPJ)
);

CREATE TABLE IF NOT EXISTS Perfis (
    idProfile INT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    comentarios VARCHAR(400),
    Usuarios_idUsuarios INT NOT NULL,
    CONSTRAINT Per_Usu_idUsuarios FOREIGN KEY (Usuarios_idUsuarios) REFERENCES Usuarios(idUsuarios)
);

CREATE TABLE IF NOT EXISTS Funcionarios (
    idFuncionarios INT PRIMARY KEY,
    CPF INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    funcao VARCHAR(45),
    Usuarios_idUsuarios INT,
    Instituicoes_idInstituicoes INT NOT NULL,
    Instituicoes_CNPJ INT NOT NULL,
    CONSTRAINT Fun_Usu_idUsuarios FOREIGN KEY (Usuarios_idUsuarios) REFERENCES Usuarios(idUsuarios),
    CONSTRAINT Fun_Ins_idInstituicoes FOREIGN KEY (Instituicoes_idInstituicoes,Instituicoes_CNPJ) REFERENCES Instituicoes(idInstituicoes,CNPJ)
);

CREATE TABLE IF NOT EXISTS Arquivos (
    idArquivos INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    pedido VARCHAR(45),
    Instituicoes_idInstituicoes INT NOT NULL,
    Instituicoes_CNPJ INT NOT NULL,
    CONSTRAINT Arq_Ins_idInstituicoes FOREIGN KEY (Instituicoes_idInstituicoes,Instituicoes_CNPJ) REFERENCES Instituicoes(idInstituicoes,CNPJ)
);