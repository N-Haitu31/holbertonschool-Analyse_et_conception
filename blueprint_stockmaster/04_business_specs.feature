Feature: Traçabilité et sécurisation des mouvements d'inventaire
  En tant que Directeur d'entrepôt
  Je veux que le stock disponible ne puisse jamais devenir négatif
  Afin de garantir la fiabilité des niveaux de stock affichés

  Scenario: Une entrée de stock augmente la quantité disponible
    Given un emplacement contenant 20 unités d'un produit
    When un manutentionnaire déclare une entrée de 30 unités pour ce produit
    Then le stock disponible de l'emplacement est de 50 unités

  Scenario Outline: Sortie de stock selon la disponibilité
    Given un emplacement contenant <stock_initial> unités d'un produit
    When un manutentionnaire déclare une sortie de <quantite_sortie> unités
    Then <resultat>

    Examples:
      | stock_initial | quantite_sortie | resultat                                           |
      | 20            | 5               | le stock disponible est de 15 unités               |
      | 20            | 20              | le stock disponible est de 0 unité                 |
      | 20            | 21              | la sortie est refusée car le stock est insuffisant |
      | 20            | 50              | la sortie est refusée car le stock est insuffisant |

