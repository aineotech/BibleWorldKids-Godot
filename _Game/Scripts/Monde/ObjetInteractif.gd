class_name ObjetInteractif extends Area2D
# Base pour tout objet interactif — hériter et implémenter _interagir().

signal interaction_declenchee

@export var indicateur_proximite: Node2D  # nœud "!" affiché en proximité

var _joueur_present: bool = false

func _ready() -> void:
	body_entered.connect(_on_corps_entre)
	body_exited.connect(_on_corps_sorti)
	if indicateur_proximite:
		indicateur_proximite.visible = false

func _process(_delta: float) -> void:
	if _joueur_present \
			and not SystemeDialogues.dialogue_en_cours \
			and GestionnaireInput.action_principale:
		_interagir()

# À surcharger dans les sous-classes.
func _interagir() -> void:
	pass

func _on_corps_entre(corps: Node2D) -> void:
	if not corps.is_in_group(Constantes.GROUP_JOUEUR):
		return
	_joueur_present = true
	if indicateur_proximite:
		indicateur_proximite.visible = true

func _on_corps_sorti(corps: Node2D) -> void:
	if not corps.is_in_group(Constantes.GROUP_JOUEUR):
		return
	_joueur_present = false
	if indicateur_proximite:
		indicateur_proximite.visible = false
