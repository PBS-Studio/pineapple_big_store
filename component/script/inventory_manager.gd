class_name InventoryManager


static var inventory: Array[Item] = []

static func add_item(itme: Item) -> void:
	inventory.push_back(itme)

static func remove_item(item: Item) -> void:
	inventory.erase(item)

static func remove_item_by_id(id: StringName) -> void:
	for item in inventory:
		if item.id == id:
			inventory.erase(item)

static func has_item(id: StringName) -> bool:
	return inventory.any(func(item: Item): item.id == id)

static func get_item(id: StringName) -> Item:
	for item in inventory:
		if item.id == id:
			return item
	return null
