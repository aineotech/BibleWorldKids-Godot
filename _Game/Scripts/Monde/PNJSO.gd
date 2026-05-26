class_name PNJSO extends Resource

@export var pnj_id:               String          = ""
@export var nom_affichage:         String          = ""
@export var portrait:              Texture2D
@export var dialogue_principal:    DialogueSO
@export var dialogues_alternatifs: Array[DialogueSO] = []
@export var quete:                 QueteSO
