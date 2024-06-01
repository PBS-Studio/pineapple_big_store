extends Node2D

@onready var background = $ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.scroll_offset -= Vector2(1, 1) * 40 * delta




func _on_button_click():
	var options = SceneManager.create_options(1.0, "squares")
	var general_options = SceneManager.create_general_options(ProjectSettings["application/boot_splash/bg_color"])
	SceneManager.change_scene("pineapple_field", options, options, general_options)
