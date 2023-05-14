extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_yes_pressed():
	get_tree().call_group("card","remove_card_effect")
	get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)
	


func _on_no_pressed():
	get_tree().call_group("card","remove_card_effect")
	get_tree().change_scene_to_file("res://Scenes/scene_overworld.tscn")
