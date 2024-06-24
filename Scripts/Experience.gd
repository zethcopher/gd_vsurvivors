extends Area2D

@export var xp = 100


signal picked_up(xp)

func _ready():
	#connect signal to gamemanager
	#self.get_parent().connect("picked_up", get_parent()._on_experience_picked_up(xp))
	pass

func destroy():
	queue_free()

func _on_area_entered(area):
	#print("experience entered")
	if area.owner.has_method("gain_experience"):
		area.owner.gain_experience(xp)
		destroy()
		#print("xp picked up")
	pass # Replace with function body.
