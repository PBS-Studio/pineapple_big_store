extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var score = 0

func _ready():
	velocity.y = 100 
	update_score()

func update_score():
	$Label.text = str(floori(score))

func _physics_process(delta):
	# Add the gravity.
	score += delta
	update_score()
	move_and_slide()


#func _on_burst_timeout():
	#velocity.y += 150
