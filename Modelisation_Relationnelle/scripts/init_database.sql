-- Script d'initialisation de la base MegaShop-B2B
-- Auteur : NGUYEN

BEGIN;

-- Décommentez et complétez :
DROP TABLE IF EXISTS ligne_commande, commande, produit, client CASCADE;

CREATE TABLE CLIENT (
id_client UUID PRIMARY KEY DEFAULT gen_random_uuid(),
nom VARCHAR NOT NULL,
contact VARCHAR NOT NULL
);

CREATE TABLE COMMANDE (
id_cmd VARCHAR PRIMARY KEY,
id_client UUID NOT NULL REFERENCES client(id_client) ON DELETE RESTRICT,
date_achat DATE NOT NULL,
statut_cmd VARCHAR NOT NULL,
adr_livraison VARCHAR NOT NULL
);

CREATE TABLE PRODUIT (
code_prod VARCHAR PRIMARY KEY,
designation VARCHAR NOT NULL,
prix_unitaire_ht DECIMAL(10,2) CHECK (prix_unitaire_ht >= 0) NOT NULL
);

CREATE TABLE ligne_commande (
    id_cmd VARCHAR NOT NULL REFERENCES commande(id_cmd) ON DELETE CASCADE,
    code_prod VARCHAR NOT NULL REFERENCES produit(code_prod) ON DELETE RESTRICT,
    qte INTEGER CHECK (qte > 0) NOT NULL,
    prix_unitaire_facture DECIMAL(10,2),
    PRIMARY KEY (id_cmd, code_prod)
);


COMMIT;
