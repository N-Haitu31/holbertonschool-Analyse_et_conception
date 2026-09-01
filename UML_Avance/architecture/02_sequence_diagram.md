sequenceDiagram
    participant A as Client
    participant B as API
    participant C as Database
    participant D as MessageQueue
    participant E as Worker
    participant F as Bank

    A->>B: Payer
    B->>C: UPDATE status = PENDING_PAYMENT

    B-)D: ProcessPaymentEvent
    B-->>A: 202 Accepted

    D->>E: consomme ProcessPaymentEvent

    E->>F: vérifier paiement
    F-->>E: résultat

    alt Banque valide
        E->>C: UPDATE status = PAID
    else Banque refuse
        E->>C: UPDATE status = FAILED
    end