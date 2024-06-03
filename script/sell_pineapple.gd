extends Node2D

var item = preload("res://items/pineapple.tres")


func _on_interact_area_interact():
	Dialogic.signal_event.connect(_signal_event)
	Dialogic.start("buy_pineapple")


func _signal_event(event:String):
	match event:
		"buy_pineapple":
			InventoryManager.add_item(item)
			queue_free()
		"cancel_buy":
			Dialogic.signal_event.disconnect(_signal_event)
