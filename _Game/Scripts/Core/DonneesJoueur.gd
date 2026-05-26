class_name DonneesJoueur extends RefCounted
# Modèle de sauvegarde — reflète exactement le JSON sur disque.

var id_joueur:         String         = ""
var config_avatar:     Dictionary     = {"carnation": 0, "id_cheveux": "", "id_tenue": ""}
var lieux_debloques:   Array[String]  = ["village"]
var quetes_terminees:  Array[String]  = []
var inventaire:        Array[String]  = []
var versets_collectes: Array[String]  = []

func vers_dict() -> Dictionary:
	return {
		"id_joueur":         id_joueur,
		"config_avatar":     config_avatar,
		"lieux_debloques":   lieux_debloques,
		"quetes_terminees":  quetes_terminees,
		"inventaire":        inventaire,
		"versets_collectes": versets_collectes,
	}

static func depuis_dict(d: Dictionary) -> DonneesJoueur:
	var obj := DonneesJoueur.new()
	obj.id_joueur        = d.get("id_joueur", "")
	obj.config_avatar    = d.get("config_avatar",
		{"carnation": 0, "id_cheveux": "", "id_tenue": ""})
	obj.lieux_debloques   = _to_str_array(d.get("lieux_debloques",  ["village"]))
	obj.quetes_terminees  = _to_str_array(d.get("quetes_terminees", []))
	obj.inventaire        = _to_str_array(d.get("inventaire",       []))
	obj.versets_collectes = _to_str_array(d.get("versets_collectes",[]))
	return obj

static func _to_str_array(src: Array) -> Array[String]:
	var out: Array[String] = []
	for v in src:
		out.append(str(v))
	return out
