class_name PoolObjets extends Node
# Pool générique de PackedScene. Attacher à un Node parent dans la scène.

@export var prefab:         PackedScene
@export var taille_initiale: int  = 10
@export var etendre:         bool = true

var _pool: Array[Node] = []

func _ready() -> void:
	for i in taille_initiale:
		_creer_et_pooler()

func obtenir() -> Node:
	for node in _pool:
		if not node.visible:
			node.visible = true
			return node
	if etendre:
		return _instancier()
	push_warning("[Pool] Pool épuisé pour " + prefab.resource_path)
	return null

func retourner(node: Node) -> void:
	if node == null:
		return
	node.visible = false
	node.get_parent().remove_child(node) if node.get_parent() != self else null
	add_child(node)

func _creer_et_pooler() -> void:
	var node := _instancier()
	node.visible = false
	_pool.append(node)

func _instancier() -> Node:
	var node := prefab.instantiate()
	add_child(node)
	_pool.append(node)
	return node
