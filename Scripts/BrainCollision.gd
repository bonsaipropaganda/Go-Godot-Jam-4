extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_area_entered(area):
	if(area.is_in_group("enemy")) and not area.dead:
		$BrainHit.play()
		$"..".animation = "hit"
		# shake(duration, frequency, amplitude):
		Global.camera.shake(0.25,10,5)
		$"../../..".victory_score -= $"../../..".victory_multiplier
		area.queue_free()



func _on_animated_sprite_2d_animation_looped():
	if $"..".animation == "hit":
		$"..".animation = "brain"
