extends Node
# Autoload "GestionnaireInput" — toucher + clavier/souris en fallback.

var direction_mouvement: Vector2 = Vector2.ZERO
var action_principale:   bool    = false
var action_secondaire:   bool    = false

const SEUIL_SWIPE := 20.0
var _touch_origine: Vector2 = Vector2.ZERO
var _touch_actif:   bool    = false

func _process(_delta: float) -> void:
	# Lecture clavier / gamepad (fallback éditeur)
	if not _touch_actif:
		direction_mouvement = Input.get_vector(
			"ui_left", "ui_right", "ui_up", "ui_down")
	# Réinitialiser les one-shot EN FIN de frame (deferred) pour que les
	# scènes puissent lire les valeurs dans leur propre _process() cette frame
	if action_principale:
		set_deferred("action_principale", false)
	if action_secondaire:
		set_deferred("action_secondaire", false)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		_traiter_touch(event as InputEventScreenTouch)
	elif event is InputEventScreenDrag:
		_traiter_drag(event as InputEventScreenDrag)
	elif event.is_action_pressed("action_principale"):
		action_principale = true
	elif event.is_action_pressed("action_secondaire"):
		action_secondaire = true

func _traiter_touch(ev: InputEventScreenTouch) -> void:
	if ev.index != 0:
		return
	if ev.pressed:
		_touch_origine   = ev.position
		_touch_actif     = true
		action_principale = true
	else:
		direction_mouvement = Vector2.ZERO
		_touch_actif = false

func _traiter_drag(ev: InputEventScreenDrag) -> void:
	if not _touch_actif or ev.index != 0:
		return
	var delta := ev.position - _touch_origine
	direction_mouvement = delta.normalized() if delta.length() > SEUIL_SWIPE else Vector2.ZERO
