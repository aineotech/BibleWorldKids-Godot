class_name EtapeQueteSO extends Resource

enum TypeEtape { COLLECTER_OBJET, PARLER_PNJ, ATTEINDRE_ZONE, TERMINER_MINI_JEU }

@export var etape_id:        String    = ""
@export_multiline var description: String = ""
@export var type:            TypeEtape = TypeEtape.COLLECTER_OBJET
@export var cible_id:        String    = ""
@export var quantite_cible:  int       = 1
