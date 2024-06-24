extends Node2D
class_name ProjectileSpawnerComponent

#var projectile_scene : PackedScene

@onready var weapon: Weapon = owner.weapon
const player_stats: PlayerStats = preload("res://Resources/PlayerStats.tres")
#@onready var current_weapon_stats: WeaponStats = weapon.item_levels[weapon.level]
@onready var followsPlayer = weapon.get_itemstats_at_level(weapon.level).follows_player

@onready var total_projectiles: int

func spawn_projectile(amount: int):
	print("amount: " + str(amount))
	if !amount:
		return
	else:
		amount -= 1
		var projectile = weapon.weapon_scene.instantiate()
		projectile.weapon = weapon
		#projectile.player_stats = player_stats
		
		if followsPlayer:
			owner.call_deferred("add_child",projectile)
		else:
			get_tree().current_scene.add_child(projectile)
			
			projectile.global_position = global_position
			
		await get_tree().create_timer(0.3).timeout
		spawn_projectile(amount)


func _on_weapon_cooldown_timer_timeout():
	total_projectiles = weapon.item_levels[weapon.level].projectiles + player_stats.projectiles
	spawn_projectile(total_projectiles)
	pass # Replace with function body.
