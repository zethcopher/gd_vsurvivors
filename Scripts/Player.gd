extends CharacterBody2D


@export var speed = 100.0

@export var max_hp = 100
@export var hp = max_hp
@export var hp5 = 1.0
@export var xp = 0
@export var max_xp = 100
@export var lvl = 0


@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var healthbar = %Healthbar
@onready var health_regen = $HealthRegen


@onready var player_weapons_slots: Array[Node] = $PlayerWeapons.get_children()
@export var weapon_inventory: Inventory

signal playerdied
signal gained_experience(xp)
signal leveled_up(lvl)


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flipped = false
	
func _ready():
	update_weapons()
	pass

func level_up():
	xp = 0
	lvl += 1
	max_xp = max_xp * 1.5
	leveled_up.emit(lvl, max_xp)
	#print("level: " +str(lvl) + " max_xp: " + str(max_xp))
	
func update_weapons():
	for i in weapon_inventory.items.size():
		if player_weapons_slots[i].get_child_count() == 0:
			#add a new weapon into slot
			var new_weapon = weapon_inventory.items[i].weapon_scene.instantiate()
			new_weapon.weapon = weapon_inventory.items[i]
			player_weapons_slots[i].add_child(new_weapon)
		else:
			player_weapons_slots[i].get_child(0).update()
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
	var regenAmount = hp5/5
	
	if ((hp + regenAmount) <= max_hp):
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
	
	velocity = direction * speed
	
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
		enemy.start_attacking()

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


