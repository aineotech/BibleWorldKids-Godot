extends ObjetInteractif
# Brebis perdue — ramasser complète une étape de quête.

@export var objet_laine:  ObjetSO
@export var quete_brebis: QueteSO

func _interagir() -> void:
	if not Inventaire.ajouter_objet(objet_laine):
		return
	interaction_declenchee.emit()
	GestionnaireQuetes.valider_etape(quete_brebis)
	visible = false  # la brebis disparaît une fois retrouvée
