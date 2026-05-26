extends ObjetInteractif

@export var rampe_arche:         Node2D
@export var vitesse_suivi:       float = 100.0
@export var rayon_entree:        float = 32.0
@export var objet_animal:        ObjetSO
@export var quete_arche:         QueteSO
@export var inventaire:          Inventaire
@export var gestionnaire_quetes: GestionnaireQuetes

@onready var _corps: CharacterBody2D = get_parent()

var _suit: bool = false

func _physics_process(_delta: float) -> void:
	if not _suit or rampe_arche == null:
		return
	var dist := global_position.distance_to(rampe_arche.global_position)
	if dist < rayon_entree:
		_entrer_dans_arche()
		return
	var dir := (rampe_arche.global_position - global_position).normalized()
	if _corps is CharacterBody2D:
		_corps.velocity = dir * vitesse_suivi
		_corps.move_and_slide()

func _interagir() -> void:
	_suit = true
	interaction_declenchee.emit()

func _entrer_dans_arche() -> void:
	_suit = false
	if _corps is CharacterBody2D:
		_corps.velocity = Vector2.ZERO
	inventaire.ajouter_objet(objet_animal)
	gestionnaire_quetes.valider_etape(quete_arche)
	get_parent().visible = false
