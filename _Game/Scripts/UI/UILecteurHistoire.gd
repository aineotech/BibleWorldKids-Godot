extends Control

signal histoire_terminee

@onready var conteneur:  Control         = $Conteneur
@onready var illus:      TextureRect     = $Conteneur/Illustration
@onready var texte:      Label           = $Conteneur/Texte
@onready var btn_suivant:Button          = $Conteneur/BtnSuivant
@onready var btn_fermer: Button          = $Conteneur/BtnFermer
@onready var audio:      AudioStreamPlayer = $Audio

var _histoire:       HistoireBibliqueSO = null
var _indice_panneau: int                = 0

func _ready() -> void:
	conteneur.visible = false
	btn_suivant.pressed.connect(_panneau_suivant)
	btn_fermer.pressed.connect(_fermer)

func ouvrir(histoire: HistoireBibliqueSO) -> void:
	_histoire      = histoire
	_indice_panneau = 0
	conteneur.visible = true
	_afficher_panneau()

func _afficher_panneau() -> void:
	if _histoire == null or _indice_panneau >= _histoire.panneaux.size():
		_fermer()
		return
	var p: PanneauHistoire = _histoire.panneaux[_indice_panneau]
	if illus: illus.texture  = p.illustration
	if texte: texte.text     = p.texte
	if audio and p.audio_segment:
		audio.stream = p.audio_segment
		audio.play()
	var dernier := _indice_panneau == _histoire.panneaux.size() - 1
	btn_suivant.visible = not dernier
	btn_fermer.visible  = dernier

func _panneau_suivant() -> void:
	_indice_panneau += 1
	_afficher_panneau()

func _fermer() -> void:
	if audio: audio.stop()
	conteneur.visible = false
	histoire_terminee.emit()
