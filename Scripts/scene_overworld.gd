extends Node2D

@export var static_path : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	#DELETE BOSSES IF BEATEN
	if Global.anger_defeated:
		$"Anger Boss".queue_free()
	if Global.grief_defeated:
		$"Grief Boss".queue_free()
	if Global.fear_defeated:
		$"Fear Boss".queue_free()
		
	if Global.grief_defeated and Global.fear_defeated:
		$BackgroundMusic.stop()
		$FinalBackground.play()
	if Global.anxiety_defeated:
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.go_to_battle and Global.last_talked_to != "HoodGuy":
		Global.player_position = $Player.position
		Global.go_to_battle = false
		
		#ADD STATIC EFFECT
		var static_effect = static_path.instantiate()
		$Player/Camera2D.add_child(static_effect)
		
		var static_tween = get_tree().create_tween()
		#tween.set_trans(Tween.TRANS_EXPO)
		static_tween.tween_property(static_effect, "scale", Vector2(0.1,0.1), 0.5)
		
		var tween = get_tree().create_tween()
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property($Player/Camera2D, "zoom", Vector2(10,10), 0.5)
		
		var tween2 = get_tree().create_tween()
		tween2.set_trans(Tween.TRANS_ELASTIC)
		tween2.tween_property($Player/Camera2D, "rotation", 360, 0.5)
		
		$TransitionTimer.start()
		$TransitionMusic.play()
		
	elif Global.last_talked_to == "HoodGuy":
		Global.go_to_battle = false
		$Door4.open = true


func _on_transition_timer_timeout():
	get_tree().change_scene_to_packed(Global.boss_fight)
