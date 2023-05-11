extends StaticBody2D

@export var open: bool

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		open = true
	if open == true:
		$AnimatedSprite2D.play("Open")
		$CollisionShape2D.disabled = true
	else: $AnimatedSprite2D.play("Closed")
