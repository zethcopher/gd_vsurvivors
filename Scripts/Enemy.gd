extends CharacterBody2D
class_name Enemy

@export var hp = 10
@export var SPEED = 30
@export var damage = 5

@onready var player = get_node("/root/Game/Player")
@onready var animation_player = $AnimationPlayer
@onready var attack_cooldown_timer = $AttackCooldownTimer
@onready var hitbox = $Hitbox

signal enemy_died

var t = 0.0
var startMoving = true
var playerPos
var in_attack_range = false
var attack_cooldown = false
	
func die():
	enemy_died.emit(self.global_position)
	queue_free()
	
func start_attacking():
	self.in_attack_range = true
	
func stop_attacking():
	self.in_attack_range = false
	

func take_damage(amount: int) -> void:
	hp -= amount
	#print("damage", amount)

func attack(player):
	#print("attack player")
	deal_damage()
	attack_cooldown = true
	attack_cooldown_timer.start()

func deal_damage():	
	player.take_damage(self.damage)
	
func move(delta):
	var direction = global_position.direction_to(player.global_position)
	animation_player.play("walking")
	velocity = direction * SPEED
	move_and_slide()

func _physics_process(delta):
	move(delta)
	if hp <= 0:
		die()
	if in_attack_range and !attack_cooldown:
		attack(player)

func _on_attack_cooldown_timer_timeout():
	attack_cooldown = false
	pass # Replace with function body.
