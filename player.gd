extends CharacterBody2D

@export var speed = 300

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()

func get_input():
	var move_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = move_direction * speed
