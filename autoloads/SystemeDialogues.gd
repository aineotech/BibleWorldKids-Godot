extends Node
# Autoload "SystemeDialogues" — flux de dialogue piloté par signaux.
# UIDialogue se connecte à ces signaux — aucune référence directe.

const _DialogueSO    = preload("res://_Game/Scripts/Monde/DialogueSO.gd")
const _LigneDialogue = preload("res://_Game/Scripts/Monde/LigneDialogue.gd")

signal dialogue_demarre(dialogue: Object)
signal ligne_changee(ligne: Object)
signal dialogue_termine

var dialogue_en_cours: bool = false

var _dialogue_courant = null  # type : DialogueSO
var _indice_ligne:     int   = 0

func lancer_dialogue(dialogue) -> void:
	if dialogue_en_cours or dialogue == null or dialogue.lignes.is_empty():
		return
	_dialogue_courant = dialogue
	_indice_ligne     = 0
	dialogue_en_cours = true
	dialogue_demarre.emit(dialogue)
	ligne_changee.emit(dialogue.lignes[0])

func ligne_suivante() -> void:
	_indice_ligne += 1
	if _indice_ligne >= _dialogue_courant.lignes.size():
		terminer_dialogue()
	else:
		ligne_changee.emit(_dialogue_courant.lignes[_indice_ligne])

func terminer_dialogue() -> void:
	_dialogue_courant = null
	dialogue_en_cours = false
	dialogue_termine.emit()
