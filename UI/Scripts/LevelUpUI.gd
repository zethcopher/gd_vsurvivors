extends Control
class_name LevelUpUI

#@export var upgrade: Array[PackedScene]

@export var upgradeChoices: UpgradeChoices
#@export var playerInventory: Inventory
#var LevelUpChoiceScene = preload("res://UI/LevelupChoice.tscn")
@onready var v_box_container = $VBoxContainer
@onready var choicesUI: Array[Node] = v_box_container.get_children()


func assign_choices():
	for i in 3:
		var randomChoice = randi_range(0,(upgradeChoices.choices.size()-1))
		var choice = upgradeChoices.choices[randomChoice]
		choicesUI[i].update_choice(choice)
		#upgradeChoices.choices.pop_at(randomChoice)
	pass

