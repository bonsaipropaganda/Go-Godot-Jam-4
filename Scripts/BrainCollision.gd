extends Area2D

@export var static_path : PackedScene

var lose = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_area_entered(area):
	if(area.is_in_group("enemy")) and not area.dead and not lose:
		take_damage()
		area.queue_free()



func _on_animated_sprite_2d_animation_looped():
	if $"..".animation == "hit":
		$"..".animation = "brain"


func _on_lose_continue_finished():
	$LoseContinue.play()

func take_damage():
	
	if $"../../..".victory_score <= (-1 * $"../../..".total_victory_score):
			
			
		var static_effect = static_path.instantiate()
		$"../../../Camera2D".add_child(static_effect)
		
		$Fade_In.play("fade in lose")
		$LoseSoundINitial.play()
		$LoseSound.play()
		$LoseContinue.play()
		$"../../../TryAgain".visible = true
		print("LOSE!")
		lose = true
		
	$BrainHit.play()
	$"..".animation = "hit"
	# shake(duration, frequency, amplitude):
	Global.camera.shake(0.25,10,5)
	$"../../..".victory_score -= $"../../..".victory_multiplier
