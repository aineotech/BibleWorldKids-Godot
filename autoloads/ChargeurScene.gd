extends Node
# Autoload "ChargeurScene" — chargement avec écran de transition.
# Utilise load() synchrone + await process_frame pour garder le rendu fluide.

signal debut_chargement
signal fin_chargement

var scene_ecran_chargement: PackedScene = null
var _en_chargement: bool = false
var _ecran: Node = null

func _ready() -> void:
	# Préchargement de l'écran de chargement au démarrage
	var packed = load(Constantes.SCENE_CHARGEMENT)
	if packed is PackedScene:
		scene_ecran_chargement = packed

func charger_scene(chemin: String) -> void:
	if _en_chargement:
		return
	_charger_async(chemin)

func _charger_async(chemin: String) -> void:
	_en_chargement = true
	debut_chargement.emit()

	# Afficher l'écran de chargement
	if scene_ecran_chargement:
		_ecran = scene_ecran_chargement.instantiate()
		add_child(_ecran)
		if _ecran.has_method("apparaitre"):
			await _ecran.apparaitre()

	# Laisser un frame au rendu avant le chargement bloquant
	await get_tree().process_frame

	# Chargement synchrone (fiable partout, y compris web editor)
	var packed_scene: PackedScene = load(chemin)

	if packed_scene == null:
		push_error("[ChargeurScene] Echec chargement : " + chemin)
		_nettoyer_ecran()
		_en_chargement = false
		return

	# Durée minimale + fondu de sortie
	if _ecran:
		_ecran.mettre_a_jour_progression(1.0)
		await get_tree().create_timer(Constantes.DUREE_CHARGEMENT_MIN).timeout
		if _ecran.has_method("disparaitre"):
			await _ecran.disparaitre()

	get_tree().change_scene_to_packed(packed_scene)
	_nettoyer_ecran()
	fin_chargement.emit()
	_en_chargement = false

func _nettoyer_ecran() -> void:
	if _ecran:
		_ecran.queue_free()
		_ecran = null
