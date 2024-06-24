extends Node2D
class_name PlayerWeapon

var projectile_spawner_component_scene = preload("res://Components/ProjectileSpawnerComponent.tscn")
var player_stats: PlayerStats = preload("res://Resources/PlayerStats.tres")

@onready var weapon: Weapon

@onready var weapon_stats: WeaponStats = weapon.get_itemstats_at_level(weapon.level)
@onready var weapon_cooldown_timer: Timer = $WeaponCooldownTimer

func _ready():
	weapon_cooldown_timer.wait_time = weapon_stats.cooldown * player_stats.cooldown
	weapon_cooldown_timer.start()
	pass
