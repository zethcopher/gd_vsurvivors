extends Resource
class_name Item

@export var texture: Texture2D
@export var name: String = ""
@export var description: String = ""
@export var level: int = 0
@export var item_levels: Array[ItemStats]

func item_level_up():
	if self.level < self.item_levels.size():
		self.level +=1
		emit_changed()
	pass

