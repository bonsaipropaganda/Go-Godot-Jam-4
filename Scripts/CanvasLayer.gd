extends CanvasLayer

@export var dialog_scene: PackedScene

var current_dialog: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_npc_npc_speech(dialog_array,character_name,character_picture) -> void:
	print("recieved")
	if current_dialog == null:
		current_dialog = dialog_scene.instantiate()
		current_dialog.dialog_array = dialog_array
		current_dialog.character_name = character_name
		current_dialog.scale = Vector2(.7,.7)
		current_dialog.position = Vector2(150,525)
		
		#SET HEADSHOT PICTURE
		var char_picture = character_picture.instantiate()
		char_picture.scale = Vector2(8,8)
		char_picture.position -= Vector2(-80,150)
		char_picture.play()
		current_dialog.add_child(char_picture)
		
		add_child(current_dialog)
		
		print("finished")

func _on_npc_walked_away():
	if current_dialog != null:
		current_dialog.queue_free()
