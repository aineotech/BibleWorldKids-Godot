extends Node
# Autoload "ChargeurScene" — chargement async avec écran de transition.

signal debut_chargement
signal fin_chargement

var scene_ecran_chargement: PackedScene = null
var _en_chargement: bool = false
var _ecran: Node = null

func _ready() -> void:
	scene_ecran_chargement = load(Constantes.SCENE_CHARGEMENT)

func charger_scene(chemin: String) -> void:
	if _en_chargement:
		return
	_charger_async(chemin)

func _charger_async(chemin: String) -> void:
	_en_chargement = true
	debut_chargement.emit()

	# Afficher l'écran de chargement par-dessus la scène courante
	if scene_ecran_chargement:
		_ecran = scene_ecran_chargement.instantiate()
		add_child(_ecran)
		if _ecran.has_method("apparaitre"):
			await _ecran.apparaitre()

	ResourceLoader.load_threaded_request(chemin)

	while true:
		var progression: Array = []
		var statut := ResourceLoader.load_threaded_get_status(chemin, progression)
		match statut:
			ResourceLoader.THREAD_LOAD_LOADED:
				break
			ResourceLoader.THREAD_LOAD_FAILED:
				push_error("[ChargeurScene] Échec : " + chemin)
				_nettoyer_ecran()
				_en_chargement = false
				return
		if _ecran and progression.size() > 0:
			_ecran.mettre_a_jour_progression(progression[0])
		await get_tree().process_frame

	if _ecran:
		_ecran.mettre_a_jour_progression(1.0)
		await get_tree().create_timer(Constantes.DUREE_CHARGEMENT_MIN).timeout
		if _ecran.has_method("disparaitre"):
			await _ecran.disparaitre()

	var packed_scene = ResourceLoader.load_threaded_get(chemin)
	get_tree().change_scene_to_packed(packed_scene)
	_nettoyer_ecran()
	fin_chargement.emit()
	_en_chargement = false

func _nettoyer_ecran() -> void:
	if _ecran:
		_ecran.queue_free()
		_ecran = null
