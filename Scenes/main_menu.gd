extends Control

@export var gameplay_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$CanvasLayer/Click.play()
	await get_tree().create_timer(.5).timeout
	get_tree().change_scene_to_packed(gameplay_scene)
