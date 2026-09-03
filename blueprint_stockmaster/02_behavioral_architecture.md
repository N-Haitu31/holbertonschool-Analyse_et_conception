sequenceDiagram
    participant A as Manutentionnaire
    participant B as API
    participant C as Database

    Manutentionnaire->>API: POST /inventory/movements
    API->>Database: SELECT SUM(mouvements) pour cet emplacement
    Database-->>API: stock actuel

    alt Stock suffisant
        API->>Database: INSERT mouvement
        API-->>Manutentionnaire: 201 Created
    else Stock insuffisant
        API-->>Manutentionnaire: 409 Conflict
    end
