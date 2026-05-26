extends Control
# Scène MenuPrincipal — point d'entrée après le boot ou retour de jeu.

@onready var btn_jouer:   Button  = $VBox/BtnJouer
@onready var btn_parent:  Button  = $VBox/BtnParent
@onready var ui_parental: Control = $UIControlParental

func _ready() -> void:
	btn_jouer.pressed.connect(_sur_jouer)
	btn_parent.pressed.connect(_sur_controle_parental)

func _sur_jouer() -> void:
	ChargeurScene.charger_scene(Constantes.SCENE_CARTE)

func _sur_controle_parental() -> void:
	if ui_parental and ui_parental.has_method("ouvrir"):
		ui_parental.ouvrir()
