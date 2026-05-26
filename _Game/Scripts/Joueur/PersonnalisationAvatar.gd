class_name PersonnalisationAvatar extends Node2D

@export var couche_corps:       Sprite2D
@export var couche_vetement:    Sprite2D
@export var couche_cheveux:     Sprite2D
@export var couche_accessoire:  Sprite2D
@export var options_carnation:  Array[Texture2D] = []

var _config: Dictionary = {"carnation": 0, "id_cheveux": "", "id_tenue": ""}

func _ready() -> void:
	var donnees = SystemeSauvegarde.donnees_courantes
	if donnees:
		appliquer_config(donnees.config_avatar)

func appliquer_config(config: Dictionary) -> void:
	_config = config.duplicate()
	changer_carnation(config.get("carnation", 0))

func changer_carnation(index: int) -> void:
	if options_carnation.is_empty():
		return
	_config["carnation"] = clampi(index, 0, options_carnation.size() - 1)
	if couche_corps:
		couche_corps.texture = options_carnation[_config["carnation"]]

func appliquer_objet(objet: ObjetSO) -> void:
	if objet == null:
		return
	match objet.categorie:
		ObjetSO.Categorie.VETEMENT:
			_config["id_tenue"] = objet.objet_id
			if couche_vetement:
				couche_vetement.texture = objet.icone
		ObjetSO.Categorie.ACCESSOIRE:
			_config["id_cheveux"] = objet.objet_id
			if couche_cheveux:
				couche_cheveux.texture = objet.icone

func sauvegarder() -> void:
	var donnees = SystemeSauvegarde.donnees_courantes
	if donnees == null:
		return
	donnees.config_avatar = _config.duplicate()
	SystemeSauvegarde.sauvegarder()
