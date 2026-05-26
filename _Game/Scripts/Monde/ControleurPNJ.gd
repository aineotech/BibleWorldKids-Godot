class_name ControleurPNJ extends ObjetInteractif

@export var donnees_pnj:       PNJSO
@export var points_patrouille: Array[NodePath] = []
@export var vitesse:           float = 80.0
@export var temps_attente:     float = 2.0

@onready var _corps: CharacterBody2D = get_parent()  # le nœud parent doit être CharacterBody2D
@onready var _animateur: AnimationPlayer = get_node_or_null("AnimationPlayer")

var _indice_cible: int   = 0
var _en_attente:   bool  = false
var _waypoints:    Array[Node2D] = []

func _ready() -> void:
	super()
	for chemin in points_patrouille:
		var n := get_node(chemin)
		if n is Node2D:
			_waypoints.append(n)

func _physics_process(delta: float) -> void:
	if _joueur_present or SystemeDialogues.dialogue_en_cours \
			or _waypoints.is_empty() or _en_attente:
		if _corps is CharacterBody2D:
			_corps.velocity = Vector2.ZERO
			_corps.move_and_slide()
		return
	_patrouiller(delta)

func _patrouiller(_delta: float) -> void:
	var cible: Vector2 = _waypoints[_indice_cible].global_position
	var dist: float    = global_position.distance_to(cible)
	if dist < 8.0:
		_attendre_et_avancer()
		return
	var dir := (cible - global_position).normalized()
	if _corps is CharacterBody2D:
		_corps.velocity = dir * vitesse
		_corps.move_and_slide()

func _attendre_et_avancer() -> void:
	_en_attente = true
	await get_tree().create_timer(temps_attente).timeout
	_indice_cible = (_indice_cible + 1) % _waypoints.size()
	_en_attente = false

func _interagir() -> void:
	if donnees_pnj == null:
		return
	interaction_declenchee.emit()
	if donnees_pnj.dialogue_principal:
		SystemeDialogues.lancer_dialogue(donnees_pnj.dialogue_principal)
	if donnees_pnj.quete:
		GestionnaireQuetes.demarrer_quete(donnees_pnj.quete)
