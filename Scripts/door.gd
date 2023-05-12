extends StaticBody2D

@export var open: bool

func _process(delta: float) -> void:
	if open == true:
		$AnimatedSprite2D.play("Open")
		$CollisionShape2D.disabled = true
	else: $AnimatedSprite2D.play("Closed")
