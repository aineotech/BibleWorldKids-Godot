extends Node
# Overlay FPS + RAM — actif uniquement en debug build.

var _delta_lisse: float = 0.0

func _ready() -> void:
	if not OS.is_debug_build():
		queue_free()

func _process(delta: float) -> void:
	_delta_lisse += (delta - _delta_lisse) * 0.1

func _draw() -> void:
	pass  # Utiliser CanvasLayer + Label dans la scène pour afficher les stats

# Appeler depuis un Label via un timer chaque seconde :
func infos() -> String:
	var fps  := int(1.0 / maxf(_delta_lisse, 0.001))
	var ram  := int(OS.get_static_memory_usage() / (1024 * 1024))
	return "FPS : %d\nRAM : %d Mo" % [fps, ram]
