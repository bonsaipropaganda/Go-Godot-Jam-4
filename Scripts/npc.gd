extends RigidBody2D

signal parent_ready

# these variables can be set for each instance of the NPC and dialog box
@export var text_speed = 0.05
@export var dialog_array = []
@export var character_name: String
@export var character_picture: Texture


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# basically we're going to set whatever variables were set for the NPC 
	#in the dialog box
	$DialogBox.text_speed = text_speed
	$DialogBox.dialog_array = dialog_array
	$DialogBox.character_name = character_name
	$DialogBox.character_picture = character_picture
	parent_ready.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_check_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$DialogIndicator.visible = true


func _on_player_check_body_exited(body: Node2D) -> void:
	$DialogIndicator.visible = false
