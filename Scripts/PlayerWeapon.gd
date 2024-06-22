extends Node2D
class_name PlayerWeapon
var projectile_spawner_component_scene = preload("res://Components/ProjectileSpawnerComponent.tscn")

@export var projectile_scene: PackedScene

@onready var weapon: Weapon
@onready var weapon_stats: WeaponStats = weapon.item_levels[weapon.level]
@onready var weapon_cooldown_timer: Timer = $WeaponCooldownTimer

func _ready():
	weapon_cooldown_timer.wait_time = weapon_stats.cooldown
	weapon_cooldown_timer.start()
	
	#create_projectile_spawners()
	pass

func update():
	#create_projectile_spawners()
	pass

##create projectile spawners
#func create_projectile_spawners():
	#if $ProjectileSpawners.get_children().size() < weapon_stats.projectiles:
		#var new_projectile_spawner = projectile_spawner_component_scene.instantiate()
		#new_projectile_spawner.projectile_scene = projectile_scene
		#new_projectile_spawner.weapon = weapon
		#weapon_cooldown_timer.timeout.connect(new_projectile_spawner.spawn_projectile)
		#add_child(new_projectile_spawner)
	#pass
	#
