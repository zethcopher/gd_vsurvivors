extends Control
class_name LevelUpUI

#@export var upgrade: Array[PackedScene]

@onready var upgrade_choices: UpgradeChoices
#@export var playerInventory: Inventory
#var LevelUpChoiceScene = preload("res://UI/LevelupChoice.tscn")
@onready var v_box_container = $VBoxContainer
@onready var choicesUI: Array[Node] = v_box_container.get_children()
#@onready var remaining_choices:UpgradeChoices = upgrade_choices.duplicate()
#var remaining_choices: Array[Item]

#func assign_choice(remaining_choices):
	#var randomChoice = [upgrade_choices.choicesrandi_range(0,(upgrade_choices.choices.size()-1))]
	#remaining_choices.choices.pop_at(randomChoice)
	#assign_choice(remaining_choices)
	#pass

func assign_choices():
	var remaining_choices = upgrade_choices.duplicate()
	for i in 3:
		var random_index = randi_range(0,(remaining_choices.choices.size()-1))
		var random_choice = remaining_choices.choices[random_index]
		remaining_choices.choices.remove_at(random_index)
		choicesUI[i].update_choice(random_choice)
	pass

