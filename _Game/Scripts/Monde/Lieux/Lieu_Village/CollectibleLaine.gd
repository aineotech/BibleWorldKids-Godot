extends ObjetInteractif

@export var objet_laine:         ObjetSO
@export var quete_brebis:        QueteSO
@export var inventaire:          Inventaire
@export var gestionnaire_quetes: GestionnaireQuetes

func _interagir() -> void:
	if not inventaire.ajouter_objet(objet_laine):
		return
	interaction_declenchee.emit()
	gestionnaire_quetes.valider_etape(quete_brebis)
	visible = false  # la touffe disparaît une fois ramassée
