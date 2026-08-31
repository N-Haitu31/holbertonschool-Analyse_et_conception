# MegaShop-B2B — Règles de gestion (Étape 1 : Audit du Legacy)
 
## 1. Sujets identifiés
 
En lisant `legacy_data.csv` ligne par ligne, trois sujets principaux se dégagent :
 
- **Client**
- **Commande**
- **Produit**
`total_ligne` n'est **pas** un sujet : c'est une donnée calculée (voir piège en fin de document).
 
## 2. Règles de gestion et cardinalités
 
### Règle 1 — Client ↔ Commande
 
> Un client peut passer plusieurs commandes ; une commande est passée par un seul client.
 
Dans le système actuel, un client n'existe dans les données qu'à partir du moment où il a passé au moins une commande : le legacy ne gère aucune fiche "prospect" indépendante d'une commande (`Acme Corp` et `TechNova` n'apparaissent que parce qu'ils ont commandé). Le minimum côté Client est donc 1, pas 0.
 
**Cardinalité :** `Client (1,n) —— (1,1) Commande`
 
- Un client : au moins 1 commande, jusqu'à n (min=1 car pas d'existence sans commande observée dans ce système ; max=n, ex. Acme Corp a `CMD-901` et `CMD-903`).
- Une commande : toujours exactement 1 client, jamais 0, jamais 2.
### Règle 2 — Commande ↔ Produit
 
> Une commande peut contenir plusieurs produits ; un produit peut apparaître dans plusieurs commandes différentes, ou n'avoir jamais été commandé.
 
Exemple dans les données : `CMD-901` contient `P-01` et `P-02` ; `P-01` apparaît à la fois dans `CMD-901` et `CMD-902`.
 
**Cardinalité :** `Commande (1,n) —— (0,n) Produit`
 
- Une commande : au moins 1 produit, jusqu'à n (jamais de commande vide).
- Un produit : 0 produit commandé est possible (produit tout juste ajouté au catalogue, jamais vendu), jusqu'à n commandes.
Cette association porte une information (quantité, prix facturé) qui n'appartient ni exclusivement à Commande, ni exclusivement à Produit, mais au couple des deux — d'où une association porteuse plutôt qu'un attribut simple sur l'une des deux entités.
 
## 3. Règles complémentaires observées sur les attributs
 
- Le nom et le contact identifient un client de façon stable, mais l'adresse de livraison peut varier d'une commande à l'autre (contexte B2B multi-site) : elle doit être rattachée à la Commande, pas au Client.
- La désignation et le prix catalogue d'un produit dépendent uniquement de `code_prod`, jamais de la commande dans laquelle il apparaît.
- Le prix réellement facturé sur une commande doit rester figé au moment de l'achat, indépendamment d'une évolution ultérieure du prix catalogue (une commande livrée ne se recalcule jamais rétroactivement).
- La date d'achat et le statut de la commande dépendent uniquement de `id_cmd`, jamais du produit commandé (constaté sur les deux lignes de `CMD-901`, identiques sur ces deux points).
## 4. Piège évité
 
`total_ligne` n'est pas un sujet ni une règle de gestion : c'est une conséquence calculée (`qte × prix_unitaire`), vérifiée sur les 4 lignes du CSV (250×2=500, 120×4=480, 250×1=250, 45×10=450). Elle est volontairement exclue du modèle relationnel : elle sera recalculée à l'affichage, jamais stockée.