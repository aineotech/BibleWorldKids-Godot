extends Node
# Autoload "GameManager" — machine à états globale.

enum EtatJeu { BOOT, MENU, JEU, PAUSE }

signal etat_change(etat: EtatJeu)

var etat_courant: EtatJeu = EtatJeu.BOOT

func _ready() -> void:
	changer_etat(EtatJeu.BOOT)

func changer_etat(nouvel_etat: EtatJeu) -> void:
	if etat_courant == nouvel_etat:
		return
	etat_courant = nouvel_etat
	etat_change.emit(etat_courant)

func lancer_jeu()      -> void: changer_etat(EtatJeu.JEU)
func mettre_en_pause() -> void: changer_etat(EtatJeu.PAUSE)
func reprendre()       -> void: changer_etat(EtatJeu.JEU)
func retourner_menu()  -> void: changer_etat(EtatJeu.MENU)
