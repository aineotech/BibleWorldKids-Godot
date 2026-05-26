extends Area2D
# Change la musique quand le joueur entre dans la zone.

@export var musique_zone: AudioStream
@export var boucle:       bool = true

func _ready() -> void:
	body_entered.connect(_on_corps_entre)

func _on_corps_entre(corps: Node2D) -> void:
	if corps.is_in_group(Constantes.GROUP_JOUEUR):
		GestionnaireAudio.jouer_musique(musique_zone, boucle)
