extends CanvasLayer
# Autoload "UINotifications" — bandeaux temporaires au-dessus de tout.

func _ready() -> void:
	layer = 100
	GestionnaireQuetes.quete_terminee.connect(_sur_quete_terminee)

func _sur_quete_terminee(quete) -> void:
	var lignes: Array[String] = ["Quête terminée !  " + quete.titre]
	if quete.verset_completion != "":
		lignes.append("Verset : " + quete.verset_completion)
	if quete.recompense:
		lignes.append("Récompense : " + quete.recompense.nom_affichage)
	_afficher_bandeau("\n".join(lignes), 4.0)

func _afficher_bandeau(texte: String, duree: float) -> void:
	var panneau := Panel.new()
	panneau.position = Vector2(40, 60)
	panneau.size     = Vector2(1000, 140)

	var label := Label.new()
	label.text = texte
	label.position = Vector2(12, 8)
	label.size = Vector2(976, 124)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment   = VERTICAL_ALIGNMENT_CENTER
	label.autowrap_mode = TextServer.AUTOWRAP_WORD

	panneau.add_child(label)
	add_child(panneau)

	await get_tree().create_timer(duree).timeout
	if is_instance_valid(panneau):
		panneau.queue_free()
