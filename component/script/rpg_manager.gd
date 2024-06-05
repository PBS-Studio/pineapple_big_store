extends Node

@onready var in_options = SceneManager.create_options(0.3, "squares")
@onready var out_options = SceneManager.create_options(0.3, "squares", 0.1, true)
@onready var general_options = SceneManager.create_general_options(ProjectSettings["application/boot_splash/bg_color"])

var list: Dictionary = {}


func change_scene(scene: String) -> void:
	mark_scene_enter(SceneManager._current_scene)

	_move_mihon_to_root()

	SceneManager.change_scene(scene, in_options, out_options, general_options)


func change_scene_no_effect(scene: String):
	mark_scene_enter(SceneManager._current_scene)

	_move_mihon_to_root()

	SceneManager.no_effect_change_scene(scene)


func change_scene_and_tp(scene: String, target: NodePath) -> void:
	mark_scene_enter(SceneManager._current_scene)

	var mihon = _get_mihon()
	var node = SceneManager.create_scene_instance(scene)
	_place_camera(mihon)
	SceneManager.change_scene(node, in_options, out_options, general_options)
	_tp_mihon(scene, target, node, mihon)


func _move_mihon_to_root():
	var mihon = _get_mihon()
	if mihon != null:
		mihon.set_process_input(false)
		mihon.visible = false
		mihon.reparent(get_tree().root)
		mihon.get_node("Camera2D").enabled = false


func _get_mihon() -> CharacterBody2D:
	var mihon = get_tree().current_scene.get_node("Mihon") as CharacterBody2D
	if mihon == null:
		mihon = get_tree().root.get_node("Mihon") as CharacterBody2D

	return mihon


func _tp_mihon(scene: String, target: NodePath, node: Node, mihon: CharacterBody2D) -> void:
	var target_node = node.get_node(target) as Marker2D

	mihon.reparent(target_node.get_parent())
	mihon.set_process_input(true)
	mihon.visible = true
	mihon.global_position = target_node.global_position
	mihon.velocity = mihon.velocity.rotated(target_node.rotation)
	mihon.motorcycle_direction += target_node.rotation

	var camera = mihon.get_node("Camera2D") as Camera2D
	camera.enabled = true
	var limit = [ - 10000000, - 10000000, 10000000, 10000000]
	if "limit" in node:
		limit = node.limit
	camera.limit_left = limit[0]
	camera.limit_top = limit[1]
	camera.limit_right = limit[2]
	camera.limit_bottom = limit[3]
	camera.reset_smoothing()


func _place_camera(mihon: CharacterBody2D) -> void:
	var camera = mihon.get_node("Camera2D").duplicate() as Camera2D
	camera.global_position = mihon.global_position
	get_tree().current_scene.add_child(camera)


func is_first_enter() -> bool:
	return not list.has(SceneManager._current_scene)


func enter_count() -> int:
	return list.get(SceneManager._current_scene, 0)


func mark_scene_enter(scene: String) -> void:
	if not list.has(scene):
		list[scene] = 0
	else:
		list[scene] += 1
