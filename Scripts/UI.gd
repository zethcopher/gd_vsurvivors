extends CanvasLayer

@onready var game_over = $GameOver
@onready var xp_bar = $XPBar
@onready var level = %Level
@onready var game_time = $GameTime
@onready var level_up = $LevelUp


var game_time_format = "%02d:%02d"
var game_time_text = ""

signal upgrade_chosen(item)

#signal chose_levelup_upgrade

func update_inventory_ui(inventory: Inventory):
	$Inventory.update(inventory)

func update_game_time(minutes, seconds):	
	game_time_text = game_time_format % [minutes, seconds]
	game_time.text = game_time_text

func display_game_over():
	game_over.visible = true
	pass

func show_levelup_choices(show: bool):
	$LevelUp.visible = show
	$LevelUp.assign_choices()
	pass
	
func upgrade_pressed(item):
	upgrade_chosen.emit(item)
	$LevelUp.visible = false
	pass

func update_level(lvl, max_xp):
	xp_bar.value = 0
	xp_bar.max_value = max_xp
	level.text = str(lvl)
	pass
	
func update_experience(xp):
	#print(xp_bar.value)
	#print(xp)
	xp_bar.value += xp
