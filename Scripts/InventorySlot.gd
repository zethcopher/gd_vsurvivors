extends Panel
class_name InventorySlot

#var item: Item

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var item_level_label = $ItemLevelLabel
@onready var item_level = $ItemLevel

func _ready():
	pass
	
func update(item: Item):
	sprite_2d.texture = item.texture
	print(item.texture)
	if item.level > 1:
		item_level_label.visible = true
		item_level.text = str(item.level)
		item_level.visible = true
	#sprite_2d.region_enabled = true
	#sprite_2d.region_rect = item.texture_region
	pass
