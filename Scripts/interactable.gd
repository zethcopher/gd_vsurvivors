extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area_2d = $Area2D
signal interactable_picked_up

func destroy():
	queue_free()

#when player comes into hitbox
func _on_area_2d_area_entered(area):
	interactable_picked_up.emit()
	pass # Replace with function body.
