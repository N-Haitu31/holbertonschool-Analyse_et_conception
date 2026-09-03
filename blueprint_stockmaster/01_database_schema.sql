DROP TABLE IF EXISTS mouvement_stock, emplacement, produit CASCADE;

CREATE TABLE IF NOT EXISTS produit (
    id_produit UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    designation VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS emplacement (
    id_emplacement UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    libelle VARCHAR NOT NULL,
    id_produit UUID NOT NULL REFERENCES produit(id_produit)
);

CREATE TABLE IF NOT EXISTS mouvement_stock (
    id_mouvement_stock UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_emplacement UUID NOT NULL REFERENCES emplacement(id_emplacement),
    type_mouvement VARCHAR NOT NULL CHECK (type_mouvement IN ('ENTREE', 'SORTIE')),
    quantite INTEGER NOT NULL CHECK (quantite > 0),
    date_mouvement DATE NOT NULL
);
