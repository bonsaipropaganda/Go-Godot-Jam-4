extends RigidBody2D

signal npc_speech

# these variables can be set for each instance of the dialog box
@export var dialog_array = []
@export var character_name: String
@export var character_picture: Texture

var player_present := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_present and Input.is_action_just_pressed("ui_accept"):
		npc_speech.emit(dialog_array,character_name,character_picture)


func _on_player_check_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$DialogIndicator.visible = true
		player_present = true


func _on_player_check_body_exited(body: Node2D) -> void:
	$DialogIndicator.visible = false
	player_present = false
