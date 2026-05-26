extends Node
# Attaché à la scène Boot — coordonne l'init et redirige vers la bonne scène.

@export var delai_min_boot: float = 1.0

func _ready() -> void:
	_demarrer()

func _demarrer() -> void:
	await get_tree().create_timer(delai_min_boot).timeout

	var premier_lancement: bool = not ProjectSettings.has_setting(
		Constantes.PREF_PREMIER_LANCEMENT)

	SystemeSauvegarde.charger()

	if premier_lancement:
		ProjectSettings.set_setting(Constantes.PREF_PREMIER_LANCEMENT, true)
		var id := _generer_id()
		SystemeSauvegarde.initialiser_nouveau_joueur(id)
		ChargeurScene.charger_scene(Constantes.SCENE_CREATEUR)
	else:
		ChargeurScene.charger_scene(Constantes.SCENE_MENU)

static func _generer_id() -> String:
	# ID local anonyme 12 caractères hex
	return "%08x%04x" % [randi(), randi() % 0xFFFF]
