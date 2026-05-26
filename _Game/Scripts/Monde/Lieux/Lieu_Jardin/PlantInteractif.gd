extends ObjetInteractif

enum EtatPlant { VIDE, PLANTE, ARROSE }

@export var texture_vide:        Texture2D
@export var texture_pousse:      Texture2D
@export var texture_fleur:       Texture2D
@export var objet_graine:        ObjetSO
@export var quete_jardin:        QueteSO
@export var inventaire:          Inventaire
@export var gestionnaire_quetes: GestionnaireQuetes

@onready var _sprite: Sprite2D = $Sprite2D

var _etat: EtatPlant = EtatPlant.VIDE

func _ready() -> void:
	super()
	_appliquer_sprite()

func _interagir() -> void:
	match _etat:
		EtatPlant.VIDE:
			_etat = EtatPlant.PLANTE
			inventaire.ajouter_objet(objet_graine)
			gestionnaire_quetes.valider_etape(quete_jardin)
		EtatPlant.PLANTE:
			_etat = EtatPlant.ARROSE
			gestionnaire_quetes.valider_etape(quete_jardin)
		EtatPlant.ARROSE:
			return
	interaction_declenchee.emit()
	_appliquer_sprite()

func _appliquer_sprite() -> void:
	if _sprite == null: return
	match _etat:
		EtatPlant.PLANTE: _sprite.texture = texture_pousse
		EtatPlant.ARROSE: _sprite.texture = texture_fleur
		_:               _sprite.texture = texture_vide
