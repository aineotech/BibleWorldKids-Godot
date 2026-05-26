class_name QueteSO extends Resource

@export var quete_id:            String           = ""
@export var titre:               String           = ""
@export_multiline var description: String         = ""
@export var etapes:              Array[EtapeQueteSO] = []
@export var recompense:          ObjetSO
@export var verset_completion:   String           = ""
