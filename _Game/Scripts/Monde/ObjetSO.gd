class_name ObjetSO extends Resource

enum Categorie { VETEMENT, ACCESSOIRE, CARTE_BIBLE, DECORATION }

@export var objet_id:           String    = ""
@export var nom_affichage:      String    = ""
@export var icone:              Texture2D
@export var categorie:          Categorie = Categorie.DECORATION
@export var verset_lie:         String    = ""
@export var est_debloquable:    bool      = true
