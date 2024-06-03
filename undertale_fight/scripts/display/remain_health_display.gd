extends Label

@onready var player_health_bar=%PlayerHealthBar

func _on_health_bar_health_change(_old_health):
	text = "%d" % player_health_bar.remain_health
