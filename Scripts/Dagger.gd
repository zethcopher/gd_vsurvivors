extends Projectile

@export var speed = 400
#var direction = Vector2.RIGHT

@onready var player = get_node("/root/Game/Player")
@onready var marker_2d = $Marker2D


var rotationdegrees = 90
func _ready():
	
	if (player.velocity.length() > 0.0):
		marker_2d.rotation = player.velocity.angle()
		linear_velocity += player.velocity.normalized() * speed
	elif player.flipped == true:
		marker_2d.rotation_degrees = 180
		linear_velocity = (Vector2.LEFT * speed)
	elif player.flipped == false:
		marker_2d.rotation_degrees = 0
		linear_velocity = (Vector2.RIGHT * speed)
	#linear_velocity += direction * speed
	#rotation = direction.angle()

