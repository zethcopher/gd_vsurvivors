extends RigidBody2D
class_name Projectile

const player_stats:PlayerStats = preload("res://Resources/PlayerStats.tres")

@onready var weapon: Weapon


@onready var weapon_stats = weapon.get_itemstats_at_level(weapon.level)
@onready var hitbox: Area2D = %Hitbox
@onready var piercing = weapon_stats.piercing


@onready var total_damage = weapon_stats.damage * player_stats.might

signal projectile_spawned
#
#func _ready():
	#hitbox.connect("body_entered", _on_body_entered)
	
func destroy():
	queue_free()

func _physics_process(delta):
	if piercing == 0:
		destroy()
		
func _on_visible_on_screen_notifier_2d_screen_exited():
	destroy()

func _on_hitbox_body_entered(body):
	total_damage = weapon_stats.damage * player_stats.might
	#print("axe body entered")
	if body.has_method("take_damage") and body is Enemy:
		body.take_damage(total_damage)
		print(total_damage)
		piercing -= 1

