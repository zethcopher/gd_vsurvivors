extends Resource
class_name Item

@export var texture: Texture2D
@export var name: String = ""

@export var level: int = 1
@export var item_levels: Array[ItemStats]

func item_level_up() -> bool:
	if self.level < self.item_levels.size():
		self.level +=1
		emit_changed()
	return self.level >= self.item_levels.size()

func get_itemstats_at_level(level: int) -> ItemStats:
	return item_levels[level-1]
