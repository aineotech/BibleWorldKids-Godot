extends Node

func _ready() -> void:
	GameManager.retourner_menu()
	_actualiser_boutons()

func _actualiser_boutons() -> void:
	var donnees = SystemeSauvegarde.donnees_courantes
	if donnees == null:
		return
	for bouton in get_tree().get_nodes_in_group("bouton_lieu"):
		if bouton.has_method("actualiser"):
			bouton.actualiser(donnees.lieux_debloques)

func debloquer_lieu(id_lieu: String) -> void:
	var donnees = SystemeSauvegarde.donnees_courantes
	if donnees == null or donnees.lieux_debloques.has(id_lieu):
		return
	donnees.lieux_debloques.append(id_lieu)
	SystemeSauvegarde.sauvegarder()
	_actualiser_boutons()
