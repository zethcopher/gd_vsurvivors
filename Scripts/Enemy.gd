extends CharacterBody2D
class_name Enemy

@export var hp = 10
@export var SPEED = 30
@export var damage = 5

@onready var player = get_node("/root/Game/Player")
@onready var animation_player = $AnimationPlayer
@onready var attack_cooldown_timer = $AttackCooldownTimer
@onready var hitbox = $Hitbox

@onready var in_attack_range: Player = null

signal enemy_died

var t = 0.0
var startMoving = true
var playerPos

var attack_cooldown = false

#func enable_hitboxes():
	#%HitboxShape.disabled = false
#
	#$CollisionShape2D.disabled = false
	#collision_layer = 4
	#collision_mask = 6

func die():
	enemy_died.emit(self.global_position)
	queue_free()
	
func start_attacking(player):
	in_attack_range = player
	
func stop_attacking():
	in_attack_range = null
	
func take_damage(amount: int) -> void:
	hp -= amount
	#print("damage", amount)

func attack():
	#print("attack player")
	deal_damage(in_attack_range)
	attack_cooldown = true
	attack_cooldown_timer.start()

func deal_damage(player):	
	in_attack_range.take_damage(self.damage)
	
func move(delta):
	var direction = global_position.direction_to(player.global_position)
	animation_player.play("walking")
	velocity = direction * SPEED * delta
	move_and_collide(velocity)

func _physics_process(delta):
	move(delta)
	if hp <= 0:
		die()
	if in_attack_range and !attack_cooldown:
		attack()

func _on_attack_cooldown_timer_timeout():
	attack_cooldown = false
	pass # Replace with function body.
