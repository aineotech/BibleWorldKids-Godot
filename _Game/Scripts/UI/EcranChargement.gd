extends CanvasLayer
# Overlaye toutes les scènes pendant le chargement.
# Le fondu passe par le Control enfant "Panneau" (CanvasLayer n'a pas modulate).

@onready var _panneau:  Control     = $Panneau
@onready var barre:     ProgressBar = $Panneau/Barre
@onready var texte:     Label       = $Panneau/Texte
@export   var conseils: Array[String] = []

func _ready() -> void:
	_panneau.modulate.a = 0.0
	add_to_group(Constantes.GROUP_CHARGEMENT)
	if not conseils.is_empty() and texte:
		texte.text = conseils[randi() % conseils.size()]

func mettre_a_jour_progression(valeur: float) -> void:
	if barre:
		barre.value = clampf(valeur, 0.0, 1.0) * 100.0

func apparaitre(duree: float = Constantes.DUREE_FONDU) -> void:
	await _fonder_vers(1.0, duree)

func disparaitre(duree: float = Constantes.DUREE_FONDU) -> void:
	await _fonder_vers(0.0, duree)

func _fonder_vers(cible: float, duree: float) -> void:
	var tween := create_tween()
	tween.tween_property(_panneau, "modulate:a", cible, duree)
	await tween.finished
