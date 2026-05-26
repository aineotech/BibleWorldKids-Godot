class_name ControleurAvatar extends CharacterBody2D

@export var vitesse: float = Constantes.VITESSE_AVATAR

@onready var _animateur: AnimationTree = get_node_or_null("AnimationTree") as AnimationTree

func _ready() -> void:
	add_to_group(Constantes.GROUP_JOUEUR)
	if _animateur:
		_animateur.active = true

func _physics_process(_delta: float) -> void:
	var bloque: bool = SystemeDialogues.dialogue_en_cours \
		or GameManager.etat_courant != GameManager.EtatJeu.JEU

	velocity = Vector2.ZERO if bloque \
		else GestionnaireInput.direction_mouvement * vitesse

	move_and_slide()
	_mettre_a_jour_animations()

func _mettre_a_jour_animations() -> void:
	if _animateur == null:
		return
	var v := velocity
	_animateur.set("parameters/vitesse/scale", v.length() / vitesse if vitesse > 0 else 0.0)
	if v.length_squared() > 1.0:
		_animateur.set("parameters/direction/blend_position", v.normalized())
