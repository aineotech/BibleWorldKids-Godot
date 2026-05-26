class_name GestionnaireVersets extends Node
# Auto-découverte depuis res://_Game/Resources/Versets/

var _versets: Array[VersetSO] = []

func _ready() -> void:
	_charger_versets()

func _charger_versets() -> void:
	var dir := DirAccess.open("res://_Game/Resources/Versets/")
	if dir == null:
		return
	dir.list_dir_begin()
	var nom := dir.get_next()
	while nom != "":
		if nom.ends_with(".tres") or nom.ends_with(".res"):
			var res := load("res://_Game/Resources/Versets/" + nom)
			if res is VersetSO:
				_versets.append(res)
		nom = dir.get_next()

func verset_aleatoire() -> VersetSO:
	if _versets.is_empty():
		return null
	return _versets[randi() % _versets.size()]

func collecter_verset(verset: VersetSO) -> void:
	if verset == null:
		return
	var donnees = SystemeSauvegarde.donnees_courantes
	if donnees == null or donnees.versets_collectes.has(verset.verset_id):
		return
	donnees.versets_collectes.append(verset.verset_id)
	SystemeSauvegarde.sauvegarder()

func est_collecte(verset_id: String) -> bool:
	var donnees = SystemeSauvegarde.donnees_courantes
	return donnees != null and donnees.versets_collectes.has(verset_id)
