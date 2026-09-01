# # Diagramme d'États-Transitions — Commande

Ce diagramme modélise le cycle de vie d'une commande, en garantissant qu'aucune commande
ne peut atteindre l'état `SHIPPED` sans être passée par un paiement validé (`PAID`).

```mermaid
stateDiagram-v2
    [*] --> DRAFT

    DRAFT --> PENDING_PAYMENT : checkout_button_clicked
    PENDING_PAYMENT --> PAID : payment_success
    PENDING_PAYMENT --> FAILED : payment_failed
    FAILED --> PENDING_PAYMENT : retry_payment
    PAID --> SHIPPED : shipment_confirmed

    SHIPPED --> [*]
```

Chaque transition est étiquetée par l'événement métier ou l'action technique qui la déclenche,
pour que l'équipe d'ingénierie puisse tracer une transition jusqu'à son déclencheur réel.