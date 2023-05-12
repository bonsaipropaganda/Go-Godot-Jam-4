extends CanvasLayer

@export var dialog_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_npc_npc_speech(dialog_array,character_name,character_picture) -> void:
	var current_dialog = dialog_scene.instantiate()
	add_child(current_dialog)
	current_dialog.dialog_array = dialog_array
	current_dialog.character_name = character_name
	current_dialog.character_picture = character_picture
	print(current_dialog.dialog_array)
