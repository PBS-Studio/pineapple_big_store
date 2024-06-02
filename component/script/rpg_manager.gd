extends Node

@onready var in_options = SceneManager.create_options(0.3, "squares")
@onready var out_options = SceneManager.create_options(0.3, "squares", 0.1, true)


func change_scene(scene: String):
	var general_options = SceneManager.create_general_options(ProjectSettings["application/boot_splash/bg_color"])
	SceneManager.change_scene(scene, in_options, out_options, general_options)
	
