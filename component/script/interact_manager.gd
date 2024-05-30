class_name InteractManager

static var interact_areas: Array[InteractArea] = []


static func regist_interact(area: InteractArea) -> void:
	interact_areas.push_back(area)


static func unregist_interact(area: InteractArea) -> void:
	interact_areas.erase(area)


static func on_input(player: Node2D) -> void:
	interact_areas.sort_custom(sort_by_distance.bind(player.global_position))
	var nearest_area: InteractArea = interact_areas.filter(func(area): return area.active).front()
	if nearest_area == null:
		return

	nearest_area.interact.emit()


func sort_by_distance(player_position: Vector2, a: InteractArea, b: InteractArea) -> bool:
	return a.global_position.distance_squared_to(player_position) < b.global_position.distance_squared_to(player_position)
