# User Story — Évaluation du risque de paiement
 
## Contexte
 
Une fraude a été détectée, ce qui motive la mise en place d'un contrôle automatique au moment du paiement.
 
## User Story
 
**En tant que** Responsable de la Gouvernance Financière,
**Je veux** que le système évalue automatiquement le niveau de risque de chaque paiement,
**Afin de** bloquer les transactions potentiellement frauduleuses et protéger l'entreprise.
 
## Critères d'acceptation
 
1. Étant donné un paiement dont le montant dépasse 10 000€, un pays de livraison figurant dans le registre des embargos, et un client n'ayant pas le statut VIP, alors la transaction est refusée et le client est notifié du refus de la transaction.
2. Étant donné un paiement dont le montant dépasse 10 000€ et un pays de livraison ne figurant pas dans le registre des embargos, alors la transaction est validée.
3. Étant donné un paiement dont le montant ne dépasse pas 10 000€, alors la transaction est validée sans évaluation du pays de livraison.
4. Étant donné un client ayant le statut VIP, alors la transaction est toujours validée, quel que soit le montant ou le pays de livraison — ce critère prévaut sur les critères 1 à 3.