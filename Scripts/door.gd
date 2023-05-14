extends StaticBody2D

@export var open: bool
@export var door_level: int

var current_level = 0

func _ready():
	if door_level <= Global.door_level:
		open = true

func _process(delta: float) -> void:
	if open == true:
		$AnimatedSprite2D.play("Open")
		$CollisionShape2D.disabled = true
	else: $AnimatedSprite2D.play("Closed")
