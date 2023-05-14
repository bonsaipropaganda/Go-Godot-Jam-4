extends Node2D

var static_path = 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.go_to_battle:
		Global.player_position = $Player.position
		Global.go_to_battle = false
		
		#ADD STATIC EFFECT
		var static_effect = 
		var tween = get_tree().create_tween()
		#tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property($Player/Camera2D, "zoom", Vector2(10,10), 1)
		$TransitionTimer.start()
		$TransitionMusic.play()
		


func _on_transition_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/scene_battle.tscn")
