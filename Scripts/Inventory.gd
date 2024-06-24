extends Resource
class_name Inventory

@export var items : Array[Item]
@export var inventory_size: int = 6


func addItem(newItem: Item):
	if items.has(newItem):
		return items[items.find(newItem)].item_level_up()
	elif items.size() < inventory_size:
		items.append(newItem)
		return false
	pass
