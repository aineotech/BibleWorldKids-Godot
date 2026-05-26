extends Node

@export var id_lieu: String = ""

signal entre_lieu(id: String)
signal sorti_lieu(id: String)

func _ready() -> void:
	GameManager.lancer_jeu()
	entre_lieu.emit(id_lieu)
	# Connecter le bouton retour s'il existe dans UILayer
	var btn := get_node_or_null("UILayer/BtnRetour")
	if btn:
		btn.pressed.connect(retourner_carte)

func _exit_tree() -> void:
	sorti_lieu.emit(id_lieu)

func retourner_carte() -> void:
	SystemeSauvegarde.sauvegarder()
	ChargeurScene.charger_scene(Constantes.SCENE_CARTE)
	GameManager.retourner_menu()
