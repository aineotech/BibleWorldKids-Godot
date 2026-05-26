extends Node
# Autoload "GestionnaireQuetes" — suivi de progression des quêtes.

signal quete_demarree(quete: Object)
signal etape_validee(quete: Object, indice: int)
signal quete_terminee(quete: Object)

# quete_id → indice étape courante (-1 = terminée)
var _progression: Dictionary = {}

func _ready() -> void:
	# Se recharger quand la sauvegarde est lue (autoload — init avant Boot)
	SystemeSauvegarde.sauvegarde_chargee.connect(_charger_depuis_sauvegarde)
	_charger_depuis_sauvegarde()

func _charger_depuis_sauvegarde() -> void:
	var donnees = SystemeSauvegarde.donnees_courantes
	if donnees == null:
		return
	for id in donnees.quetes_terminees:
		_progression[id] = -1

func demarrer_quete(quete) -> void:
	if quete == null or _progression.has(quete.quete_id):
		return
	_progression[quete.quete_id] = 0
	quete_demarree.emit(quete)

func valider_etape(quete) -> void:
	if quete == null:
		return
	var etape: int = _progression.get(quete.quete_id, -2)
	if etape < 0:
		return
	var suivante := etape + 1
	if suivante >= quete.etapes.size():
		_terminer_quete(quete)
	else:
		_progression[quete.quete_id] = suivante
		etape_validee.emit(quete, suivante)

func est_terminee(quete_id: String) -> bool:
	return _progression.get(quete_id, -2) == -1

func _terminer_quete(quete) -> void:
	_progression[quete.quete_id] = -1
	var donnees = SystemeSauvegarde.donnees_courantes
	if donnees and not donnees.quetes_terminees.has(quete.quete_id):
		donnees.quetes_terminees.append(quete.quete_id)
		SystemeSauvegarde.sauvegarder()
	if quete.recompense:
		Inventaire.ajouter_objet(quete.recompense)
	quete_terminee.emit(quete)
