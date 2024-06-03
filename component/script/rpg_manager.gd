extends Node

@onready var in_options = SceneManager.create_options(0.3, "squares")
@onready var out_options = SceneManager.create_options(0.3, "squares", 0.1, true)
@onready var general_options = SceneManager.create_general_options(ProjectSettings["application/boot_splash/bg_color"])

var list: Dictionary = {}


func change_scene(scene: String):
	mark_scene_enter(SceneManager._current_scene)

	SceneManager.change_scene(scene, in_options, out_options, general_options)


func change_scene_and_tp(scene: String, target: NodePath):
	mark_scene_enter(SceneManager._current_scene)

	var node = SceneManager.create_scene_instance(scene)
	var target_node = node.get_node(target) as Marker2D
	var mihon = get_tree().current_scene.get_node("Mihon") as CharacterBody2D
	
	var camera = mihon.get_node("Camera2D") as Camera2D
	var limit = [-10000000, -10000000, 10000000, 10000000]
	if "limit" in node:
		limit = node.limit
	camera.limit_left = limit[0]
	camera.limit_top = limit[1]
	camera.limit_right = limit[2]
	camera.limit_bottom = limit[3]
	
	mihon.reparent(target_node.get_parent())
	mihon.global_position = target_node.global_position
	SceneManager.change_scene(node, in_options, out_options, general_options)


func is_first_enter() -> bool:
	return not list.has(SceneManager._current_scene)


func mark_scene_enter(scene: String):
	list[scene] = null
