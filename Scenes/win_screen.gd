extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fadeoutwhite")
	$WinIntro.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_win_intro_finished():
	$WinContinue.play()


func _on_win_continue_finished():
	$WinContinue.play()
