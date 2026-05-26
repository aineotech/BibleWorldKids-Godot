extends Node
# Autoload "SystemeSauvegarde" — JSON local + stub Firebase (Phase 2).

signal sauvegarde_chargee

var donnees_courantes: DonneesJoueur = null

func charger() -> void:
	if FileAccess.file_exists(Constantes.FICHIER_SAUVEGARDE):
		var file := FileAccess.open(Constantes.FICHIER_SAUVEGARDE, FileAccess.READ)
		var json := JSON.parse_string(file.get_as_text())
		file.close()
		if json is Dictionary:
			donnees_courantes = DonneesJoueur.depuis_dict(json)
	sauvegarde_chargee.emit()

func sauvegarder() -> void:
	if donnees_courantes == null:
		return
	var file := FileAccess.open(Constantes.FICHIER_SAUVEGARDE, FileAccess.WRITE)
	file.store_string(JSON.stringify(donnees_courantes.vers_dict(), "\t"))
	file.close()
	# Firebase sync : stub — à implémenter avec GodotFirebase en Phase 2

func initialiser_nouveau_joueur(id_joueur: String) -> void:
	donnees_courantes = DonneesJoueur.new()
	donnees_courantes.id_joueur = id_joueur
	sauvegarder()
