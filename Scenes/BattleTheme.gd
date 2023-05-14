extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.door_level == 3:
		stop()
		$"../FinalBattle".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
