extends RigidBody2D
class_name Projectile

@onready var weapon: Weapon
@onready var weapon_stats = weapon.item_levels[weapon.level]
@onready var hitbox: Area2D = %Hitbox
@onready var piercing = weapon_stats.piercing
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
	#print("axe body entered")
	if body.has_method("take_damage") and body is Enemy:
		body.take_damage(weapon_stats.damage)
		piercing -= 1

