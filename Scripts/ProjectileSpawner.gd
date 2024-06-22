extends Node2D
class_name ProjectileSpawnerComponent

var projectile_scene : PackedScene

@onready var weapon: Weapon = owner.weapon
@onready var current_weapon_stats: WeaponStats = weapon.item_levels[weapon.level]
@onready var followsPlayer : bool = current_weapon_stats.follows_player
@onready var weapon_cooldown = current_weapon_stats.cooldown

#var remaining_projectiles = 0
#func _ready():
	#owner.weapon_cooldown_timer.connect("timeout", spawn_projectile)
func spawn_projectile(amount: int):
	print("amount: " + str(amount))
	if !amount:
		return
	else:
		amount -= 1
		var projectile = owner.projectile_scene.instantiate()
		projectile.weapon = weapon
		
		if followsPlayer:
			owner.call_deferred("add_child",projectile)
		else:
			get_tree().current_scene.add_child(projectile)
			
			projectile.global_position = global_position
			
		await get_tree().create_timer(0.3).timeout
		spawn_projectile(amount)


func _on_weapon_cooldown_timer_timeout():
	current_weapon_stats = weapon.item_levels[weapon.level]
	spawn_projectile(current_weapon_stats.projectiles)
	pass # Replace with function body.
