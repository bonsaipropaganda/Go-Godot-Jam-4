extends RigidBody2D

signal parent_ready


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_check_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$DialogIndicator.visible = true


func _on_player_check_body_exited(body: Node2D) -> void:
	$DialogIndicator.visible = false
