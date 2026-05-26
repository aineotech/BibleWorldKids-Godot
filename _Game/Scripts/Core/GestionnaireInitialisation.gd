extends Node
# Attaché à la scène Boot — coordonne l'init et redirige vers la bonne scène.

@export var delai_min_boot: float = 1.0

func _ready() -> void:
	_demarrer()

func _demarrer() -> void:
	await get_tree().create_timer(delai_min_boot).timeout

	SystemeSauvegarde.charger()

	# Le fichier de sauvegarde est la source de vérité :
	# s'il n'existe pas, c'est vraiment un nouveau joueur.
	if SystemeSauvegarde.donnees_courantes == null:
		SystemeSauvegarde.initialiser_nouveau_joueur(_generer_id())
		ChargeurScene.charger_scene(Constantes.SCENE_CREATEUR)
	else:
		ChargeurScene.charger_scene(Constantes.SCENE_MENU)

static func _generer_id() -> String:
	# ID local anonyme 12 caractères hex
	return "%08x%04x" % [randi(), randi() % 0xFFFF]
