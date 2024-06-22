extends Node2D
class_name Game

@export var weapon_inventory: Inventory
@export var trinket_inventory: Inventory

var Enemy = preload("res://Scenes/Enemy.tscn")
var Experience = preload("res://Scenes/Experience.tscn")
@onready var player = %Player
@onready var path_2d = %Path2D
@onready var path_follow_2d = %PathFollow2D
@onready var ui = $UI

@export var difficulty = 1

signal updated_inventory

var minutes = 0
var seconds = 0

func _ready():
	updated_inventory.emit()
	pass
	
func spawnEnemy():
	for n in difficulty:
		var enemy = Enemy.instantiate()
		add_child(enemy)
		path_follow_2d.progress_ratio = randf()
		enemy.global_position = path_follow_2d.global_position
		enemy.connect("enemy_died", _on_enemy_died)
	
func spawnExperience(enemyPos):
	var experience = Experience.instantiate()
	experience.global_position = enemyPos
	add_child(experience)
	pass

func pause(paused: bool):
	get_tree().paused = paused

func gameover():
	ui.display_game_over()
	pause(true)
	pass

#func add_weapon(weaponScene):
	#var weapon = weaponScene.instantiate()
	#player.add_child(weapon)
	#pass

func handle_time():
	if seconds < 59:
		seconds += 1
	else:
		minutes += 1
		seconds = 0
	difficulty += 0.05
	ui.update_game_time(minutes,seconds)
	pass

func _on_player_playerdied():
	gameover()
	pass # Replace with function body.

func _on_player_gained_experience(xp):
	ui.update_experience(xp)
	pass # Replace with function body.

func _on_player_leveled_up(lvl,max_exp):
	ui.update_level(lvl,max_exp)
	pause(true)
	ui.show_levelup_choices(true)
	pass # Replace with function body.

func _on_enemy_died(enemyPos):
	spawnExperience(enemyPos)
	pass

func _on_enemy_spawn_timer_timeout():
	spawnEnemy()
	pass # Replace with function body.

func _on_game_timer_timeout():
	handle_time()
	pass # Replace with function body.

func _on_ui_upgrade_chosen(item):
	if item is Weapon:
		weapon_inventory.addItem(item)
		ui.update_inventory_ui(weapon_inventory)
		player.update_weapons()
		#add_weapon(item.weapon_scene)
	elif item is Trinket:
		trinket_inventory.addItem(item)
		ui.update_inventory_ui(trinket_inventory)

	pause(false)
	pass # Replace with function body.
