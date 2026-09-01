# Diagramme de Classes — Isolation du Repository

Ce diagramme modélise l'inversion de dépendance entre `OrderService` et la couche de
persistance : le service ne dépend que de l'interface `IOrderRepository`, jamais de
l'implémentation concrète `PostgresOrderRepository`. Cette isolation permet de tester
`OrderService` avec un faux repository (mock/stub), sans jamais démarrer une vraie
base PostgreSQL.

```mermaid
classDiagram
    class IOrderRepository{
        <<interface>>
        +save(order: Order) void
        +findById(id: UUID) Order
    }

    class PostgresOrderRepository {
        +save(order: Order) void
        +findById(id: UUID) Order
    }

    class OrderService {
        -orderRepository: IOrderRepository
    }

    PostgresOrderRepository ..|> IOrderRepository : réalise
    OrderService o-- IOrderRepository : agrège
```
`OrderService` ne connaît et ne référence à aucun moment `PostgresOrderRepository` :
le seul lien entre les deux passe par `IOrderRepository`, ce qui élimine tout
couplage technologique direct et rend le service substituable pour les tests unitaires.