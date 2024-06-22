extends Button
class_name LevelUpChoiceUI


@onready var choice_name = %ChoiceName
@onready var choice_description = %ChoiceDescription
#@onready var choice_icon = $Icon
@onready var texture_rect = %TextureRect

var item: Item


signal upgrade_pressed(choice)

func update_choice(choice: Item):
	item = choice
	choice_name.text = choice.name
	texture_rect.texture = choice.texture
	choice_description.text = choice.item_levels[(item.level)+1].item_level_description
	pass

func _ready():
	connect("upgrade_pressed", owner.upgrade_pressed)

func _pressed():
	upgrade_pressed.emit(item)
	pass
