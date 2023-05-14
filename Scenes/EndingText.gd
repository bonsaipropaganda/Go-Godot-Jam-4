extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(3)
	self.visible = true
	$AnimationPlayer.play("fade in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play("fade out")
