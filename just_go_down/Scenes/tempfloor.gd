extends Area2D


# Called when the node enters the scene tree for the first time.






func _on_clearbox_body_entered(body):
	if body.is_in_group("wall"):
		queue_free()
	elif body.is_in_group("player"):
		body.velocity.y = -200
		queue_free()






func _on_body_entered(body):
	if body.is_in_group("wall"):
		queue_free()
