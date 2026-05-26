class_name Inventaire extends Node

signal inventaire_modifie

func ajouter_objet(objet: ObjetSO) -> bool:
	var donnees = SystemeSauvegarde.donnees_courantes
	if donnees == null or donnees.inventaire.has(objet.objet_id):
		return false
	donnees.inventaire.append(objet.objet_id)
	SystemeSauvegarde.sauvegarder()
	inventaire_modifie.emit()
	return true

func retirer_objet(objet_id: String) -> bool:
	var donnees = SystemeSauvegarde.donnees_courantes
	if donnees == null:
		return false
	var idx: int = donnees.inventaire.find(objet_id)
	if idx < 0:
		return false
	donnees.inventaire.remove_at(idx)
	SystemeSauvegarde.sauvegarder()
	inventaire_modifie.emit()
	return true

func contient(objet_id: String) -> bool:
	var donnees = SystemeSauvegarde.donnees_courantes
	return donnees != null and donnees.inventaire.has(objet_id)

func obtenir_tous() -> Array[String]:
	var donnees = SystemeSauvegarde.donnees_courantes
	if donnees == null:
		return []
	return donnees.inventaire.duplicate()
