extends Button

@export var id_lieu:   String = ""
@export var nom_scene: String = ""
@export var visu_verouille: Node

func _ready() -> void:
	pressed.connect(_sur_clic)
	_actualiser()

func actualiser(lieux_debloques: Array[String]) -> void:
	var debloque := lieux_debloques.has(id_lieu)
	disabled = not debloque
	if visu_verouille:
		visu_verouille.visible = not debloque

func _actualiser() -> void:
	var donnees := SystemeSauvegarde.donnees_courantes
	if donnees == null:
		return
	actualiser(donnees.lieux_debloques)

func _sur_clic() -> void:
	ChargeurScene.charger_scene(nom_scene)
