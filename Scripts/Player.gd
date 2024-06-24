extends CharacterBody2D
class_name Player


#@export var max_hp = 100
@export var xp = 0
@export var max_xp = 100

@export var player_stats: PlayerStats
@onready var hp = player_stats.max_health
#@onready var speed = player_stats.speed

 

var player_weapon_scene = preload("res://Weapons/Weapon.tscn")

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var healthbar = %Healthbar
@onready var health_regen = $HealthRegen


@onready var player_weapons_slots: Array[Node] = $PlayerWeapons.get_children()
var weapon_inventory: Inventory = load("res://Inventory/WeaponInventory.tres")
var trinket_inventory: Inventory = load("res://Inventory/TrinketInventory.tres")

signal playerdied
signal gained_experience(xp)
signal leveled_up(lvl)


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flipped = false
	
func _ready():
	#owner.weapon_inventory = weapon_inventory
	#owner.trinket_inventory = trinket_inventory
	update_weapons()
	pass

func level_up():
	xp = 0
	player_stats.level += 1
	max_xp = max_xp * 1.5
	leveled_up.emit(player_stats.level, max_xp)
	#print("level: " +str(lvl) + " max_xp: " + str(max_xp))
	
func update_weapons():
	for i in weapon_inventory.items.size():
		if player_weapons_slots[i].get_child_count() == 0:
			#add a new weapon into slot
			var new_weapon = player_weapon_scene.instantiate()
			new_weapon.weapon = weapon_inventory.items[i]
			#new_weapon.player_stats = player_stats
			player_weapons_slots[i].add_child(new_weapon)
	pass # Replace with function body.
	
func gain_experience(gained_xp):
	if (gained_xp + xp >= max_xp):
		level_up()
	else:
		xp += gained_xp
		gained_experience.emit(gained_xp)

func die():
	if hp <=0:
		playerdied.emit()
		
func regen():
	var regenAmount = player_stats.recovery
	
	if regenAmount > 0 and (hp + regenAmount) <= player_stats.max_health:
		hp += regenAmount
	else:
		return
	healthbar.value += regenAmount
	
func take_damage(amount: int) -> void:
	hp -= amount
	healthbar.value -= amount


func attack():
	#get_tree().call_group("weapons", "attack")
	pass

func move():
	
	var direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	
	velocity = direction * (player_stats.speed * 75)
	
	if velocity.length() > 0.0:
		#set animation to running
		animation_player.play("running")
	else:
		animation_player.play("idle")
	
	if velocity.x < 0:
		sprite_2d.flip_h = true
		flipped = true
	elif velocity.x > 0:
		sprite_2d.flip_h = false
		flipped = false
		
	move_and_slide()

func _physics_process(delta):
	move()
	die()
	#print(isAttacking)

func _on_hitbox_body_entered(enemy):
	#print("enemy entered hitbox")
	if enemy == null:
		return
	if enemy is Enemy:
		enemy.start_attacking(self)

func _on_hitbox_body_exited(enemy):
	if enemy == null:
		return
	if enemy is Enemy:
		enemy.stop_attacking()

func _on_health_regen_timeout():
	regen()
	pass # Replace with function body.


func _on_interactable_interactable_picked_up():
	
	pass # Replace with function body.

func _on_attack_cooldown_timeout():
	attack()
	pass # Replace with function body.


