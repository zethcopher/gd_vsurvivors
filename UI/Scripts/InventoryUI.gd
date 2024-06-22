extends Control
class_name Inventory_UI


@export var starting_inventory: Inventory
@onready var weapon_inventory_ui = $WeaponInventory
@onready var weapon_inventory_slots: Array[Node] = weapon_inventory_ui.get_children()

@onready var trinket_inventory_ui = $TrinketInventory
@onready var trinket_inventory_slots: Array[Node] = trinket_inventory_ui.get_children()


func update(inventory: Inventory):
	print("inventory size: " + str(inventory.items.size()))
	for i in inventory.items.size():
		if inventory.items[i] != null:
			if inventory.items[i] is Weapon:
				weapon_inventory_slots[i].update(inventory.items[i])
			else:
				trinket_inventory_slots[i].update(inventory.items[i])
	pass
	
func _ready():
	update(starting_inventory)
	pass
