extends Node

var inventory: Array[Item] = []


func add_item(itme: Item) -> void:
	inventory.push_back(itme)


func remove_item(item: Item) -> void:
	inventory.erase(item)


func remove_item_by_id(id: StringName) -> void:
	for item in inventory:
		if item.id == id:
			inventory.erase(item)


func has_item(id: StringName) -> bool:
	return inventory.any(func(item: Item): item.id == id)


func get_item(id: StringName) -> Item:
	for item in inventory:
		if item.id == id:
			return item
	return null
