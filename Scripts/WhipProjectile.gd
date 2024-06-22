extends Projectile
@onready var animation_player = $AnimationPlayer

@onready var player = get_node("/root/Game/Player")
@onready var sprite_2d = %Sprite2D
@onready var collision_shape_2d = $CollisionShape2D

@export var distance = 100

func _destroy():
	queue_free()
	pass


func flip():
	
	pass

func _ready():
	#super()
	if (player.velocity.x > 0.0) or player.flipped == false:
		animation_player.play("grow")
	elif (player.velocity.x < 0.0) or player.flipped == true:
		animation_player.play("growLeft")
	

func _on_animation_player_animation_finished(anim_name):
	destroy()
	pass # Replace with function body.


