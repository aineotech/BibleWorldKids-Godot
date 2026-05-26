extends ObjetInteractif
# Déclencheur de la quête "La brebis perdue" — parler au berger Siméon.

@export var quete:               QueteSO
@export var gestionnaire_quetes: GestionnaireQuetes

func _interagir() -> void:
	interaction_declenchee.emit()
	gestionnaire_quetes.demarrer_quete(quete)
