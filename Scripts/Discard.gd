extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().get_parent().position.y > 0:
		position.y = (position.y * -1) - size.x/2
		
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_discard_delay_timeout():
	show()
