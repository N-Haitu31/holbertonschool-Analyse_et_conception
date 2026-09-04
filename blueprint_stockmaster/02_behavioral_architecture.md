# Architecture Comportementale — Mouvement de Stock
 
Ce diagramme modélise le traitement d'une création de mouvement de stock (`POST /inventory/movements`) :
l'API vérifie le stock disponible avant de valider ou de rejeter la requête.
 
```mermaid
sequenceDiagram
    participant Manutentionnaire
    participant API
    participant Database
 
    Manutentionnaire->>API: POST /inventory/movements
    API->>Database: SELECT SUM(quantite) WHERE id_emplacement = ...
    Database-->>API: stock actuel
 
    alt Stock suffisant
        API->>Database: INSERT mouvement
        API-->>Manutentionnaire: 201 Created
    else Stock insuffisant
        API-->>Manutentionnaire: 409 Conflict
    end
```
 