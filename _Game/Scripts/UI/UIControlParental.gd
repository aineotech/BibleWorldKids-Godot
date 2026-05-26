extends Control

const CLE_PIN    := "parental/pin"
const LONGUEUR   := 4

@onready var panneau:    Control = $Panneau
@onready var affichage:  Label   = $Panneau/Affichage
@onready var message:    Label   = $Panneau/Message

var _saisie:  String = ""
var _creation: bool  = false
var _pin_temp: String = ""
var _cfg := ConfigFile.new()

func _ready() -> void:
	panneau.visible = false
	_cfg.load(Constantes.FICHIER_PREFERENCES)
	_connecter_clavier()

func _connecter_clavier() -> void:
	var grille := panneau.get_node_or_null("ClavierPIN")
	if grille == null:
		return
	for enfant in grille.get_children():
		if enfant is Button:
			match enfant.text:
				"⌫": enfant.pressed.connect(effacer)
				"OK": enfant.pressed.connect(valider)
				_:
					var chiffre := enfant.text
					enfant.pressed.connect(func(): ajouter_chiffre(chiffre))
	var btn_fermer := panneau.get_node_or_null("BtnFermer")
	if btn_fermer:
		btn_fermer.pressed.connect(fermer)

func ouvrir() -> void:
	_saisie  = ""
	_pin_temp = ""
	_creation = not _cfg.has_section_key("parental", "pin")
	message.text   = "Créez un PIN à 4 chiffres" if _creation else "Entrez votre PIN"
	affichage.text = ""
	panneau.visible = true

func fermer() -> void:
	panneau.visible = false

func ajouter_chiffre(c: String) -> void:
	if _saisie.length() >= LONGUEUR: return
	_saisie += c
	affichage.text = "●".repeat(_saisie.length())

func effacer() -> void:
	if _saisie.is_empty(): return
	_saisie = _saisie.left(_saisie.length() - 1)
	affichage.text = "●".repeat(_saisie.length())

func valider() -> void:
	if _saisie.length() < LONGUEUR: return
	if _creation:
		if _pin_temp.is_empty():
			_pin_temp = _saisie; _saisie = ""; affichage.text = ""
			message.text = "Confirmez le PIN"
			return
		if _pin_temp != _saisie:
			message.text = "Les codes ne correspondent pas."
			_saisie = ""; _pin_temp = ""; affichage.text = ""; return
		_cfg.set_value("parental", "pin", _saisie)
		_cfg.save(Constantes.FICHIER_PREFERENCES)
		message.text = "PIN enregistré !"
	else:
		if _cfg.get_value("parental", "pin", "") != _saisie:
			message.text = "Code incorrect."
			_saisie = ""; affichage.text = ""; return
	fermer()
