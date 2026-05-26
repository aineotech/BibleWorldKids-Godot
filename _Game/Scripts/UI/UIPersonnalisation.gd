extends Control

@export var avatar:           PersonnalisationAvatar
@export var options_cheveux:  Array[ObjetSO] = []
@export var options_tenues:   Array[ObjetSO] = []
@export var nb_carnations:    int = 6

var _carnation:    int = 0
var _idx_cheveux:  int = 0
var _idx_tenue:    int = 0

func _ready() -> void:
	var donnees := SystemeSauvegarde.donnees_courantes
	if donnees == null:
		return
	_carnation   = donnees.config_avatar.get("carnation", 0)
	_idx_cheveux = _trouver_index(options_cheveux, donnees.config_avatar.get("id_cheveux",""))
	_idx_tenue   = _trouver_index(options_tenues,  donnees.config_avatar.get("id_tenue",  ""))

func naviguer_carnation(delta: int) -> void:
	_carnation = posmod(_carnation + delta, nb_carnations)
	avatar.changer_carnation(_carnation)

func naviguer_cheveux(delta: int) -> void:
	if options_cheveux.is_empty(): return
	_idx_cheveux = posmod(_idx_cheveux + delta, options_cheveux.size())
	avatar.appliquer_objet(options_cheveux[_idx_cheveux])

func naviguer_tenue(delta: int) -> void:
	if options_tenues.is_empty(): return
	_idx_tenue = posmod(_idx_tenue + delta, options_tenues.size())
	avatar.appliquer_objet(options_tenues[_idx_tenue])

func confirmer() -> void:
	avatar.sauvegarder()
	ChargeurScene.charger_scene(Constantes.SCENE_CARTE)

func _trouver_index(tableau: Array[ObjetSO], id: String) -> int:
	if id.is_empty(): return 0
	for i in tableau.size():
		if tableau[i].objet_id == id: return i
	return 0
