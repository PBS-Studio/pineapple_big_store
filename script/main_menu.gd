extends Node2D

@onready var background = $ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.scroll_offset -= Vector2(1, 1) * 40 * delta
