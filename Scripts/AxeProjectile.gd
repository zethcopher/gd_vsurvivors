extends Projectile

var randyx
var randiy
@onready var animation_player = $AnimationPlayer


func _ready():
	#super()
	animation_player.play("spin")
	#if n % 2 == 0:
			#
	#else:
		#randyx = randi_range(-60,-40)
	#randyx = randi_range(40,60)
	randiy = randi_range(-150,-300)
	
func _physics_process(delta):
	super(delta)
	position += Vector2(0, randiy) * delta
	
