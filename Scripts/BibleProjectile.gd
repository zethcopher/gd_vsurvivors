extends Projectile

@onready var sprite_2d = %Sprite2D
@onready var marker_2d = $Marker2D
@onready var weapon_duration = $WeaponDuration

@export var speed = 0.4
@export var max_area = 50
@export var min_area = 0

@export var duration = 5
var isDestroyed = false

@onready var tween = self.create_tween()
@onready var stopTween = self.create_tween()

func _physics_process(delta):
	pass

func _ready():
	#super()
	weapon_duration.start()
	#weapon_duration.wait_time = duration
	weapon_duration.connect("timeout", self._on_weapon_duration_timeout)
	sprite_2d.position.y = max_area
	sprite_2d.scale = Vector2(0,0)
	tween.set_parallel()
	tween.set_loops(0)
	tween.tween_property(sprite_2d, "scale", Vector2(1,1),1)
	tween.tween_property(self, "rotation",(PI * 2), 2).as_relative()
	tween.tween_property(sprite_2d, "rotation",-(PI * 2), 2).as_relative()
	pass

func destroy():
	weapon_duration.stop()
	tween.stop()
	var stopTween = self.create_tween()
	stopTween.set_parallel()
	stopTween.tween_property(sprite_2d, "scale", Vector2(0,0),1)
	stopTween.tween_property(self, "rotation",(PI*2), 2).as_relative()
	stopTween.tween_property(sprite_2d, "rotation",-(PI * 2), 2).as_relative()
	stopTween.chain().tween_callback(self.queue_free)
	
	pass
	
func _on_weapon_duration_timeout():
	destroy()
	pass # Replace with function body.
