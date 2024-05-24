extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_health_bar_health_change(new_health: int):
	text = "%d" % new_health
