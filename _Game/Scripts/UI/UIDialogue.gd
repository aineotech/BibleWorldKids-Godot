extends Control
# Se connecte aux signaux de SystemeDialogues — aucune référence directe.

@onready var conteneur:  Control        = $Conteneur
@onready var nom_label:  Label          = $Conteneur/NomLocuteur
@onready var texte_label:Label          = $Conteneur/Texte
@onready var portrait:   TextureRect    = $Conteneur/Portrait
@onready var bouton:     Button         = $Conteneur/BoutonSuite

func _ready() -> void:
	conteneur.visible = false
	bouton.pressed.connect(_sur_clic)
	SystemeDialogues.dialogue_demarre.connect(_sur_dialogue_demarre)
	SystemeDialogues.ligne_changee.connect(_sur_ligne_changee)
	SystemeDialogues.dialogue_termine.connect(_sur_dialogue_termine)

func _sur_dialogue_demarre(_dialogue: DialogueSO) -> void:
	conteneur.visible = true

func _sur_ligne_changee(ligne: LigneDialogue) -> void:
	if nom_label:  nom_label.text  = ligne.nom_locuteur
	if texte_label: texte_label.text = ligne.texte
	if portrait:   portrait.texture = ligne.portrait

func _sur_dialogue_termine() -> void:
	conteneur.visible = false

func _sur_clic() -> void:
	SystemeDialogues.ligne_suivante()
