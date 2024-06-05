class_name InteractManager

static var interact_areas: Array[Area2D] = []


static func regist_interact(area: Area2D) -> void:
	interact_areas.push_back(area)


static func unregist_interact(area: Area2D) -> void:
	interact_areas.erase(area)


static func update_indicator(global_position: Vector2) -> void:
	for area in interact_areas:
		area.indicator = false

	var nearest_area: Area2D = get_nearest_interact(global_position)
	if nearest_area != null:
		nearest_area.indicator = true


static func get_nearest_interact(global_position: Vector2) -> Area2D:
	interact_areas.sort_custom(func(a, b): return a.global_position.distance_squared_to(global_position) < b.global_position.distance_squared_to(global_position))
	var nearest_area: Area2D = interact_areas.filter(func(area): return area.active).front()
	return nearest_area


static func interact() -> void:
	var nearest_area: Area2D = interact_areas.filter(func(area): return area.active).front()
	if nearest_area == null:
		return

	nearest_area.indicator = false
	nearest_area.interact.emit()
