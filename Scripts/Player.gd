extends CharacterBody2D
@export var speed = 400

@onready var previous_input_direction = Vector2(0,0)

func _ready():
	#SET SAVE DATA FROM COMING BACK FROM BATTLES
	position = Global.player_position


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	#print(input_direction)
	velocity = input_direction * speed
	
	if(velocity.x != 0):
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	if previous_input_direction != input_direction:
		print("new direction")
		match input_direction:
			Vector2(0, 1):
				$AnimatedSprite2D.set_animation("walk_down")
			Vector2(0, -1):
				$AnimatedSprite2D.set_animation("walk_up")
			Vector2(-1, 0):
				$AnimatedSprite2D.set_animation("walk_side")
			Vector2(1, 0):
				$AnimatedSprite2D.set_animation("walk_side")
				
			Vector2(0,0):
				match $AnimatedSprite2D.animation:
					"walk_down":
						$AnimatedSprite2D.set_animation("idle_down")
					"walk_up":
						$AnimatedSprite2D.set_animation("idle_up")
					"walk_side":
						$AnimatedSprite2D.set_animation("idle_side")
						
		$AnimatedSprite2D.play()
	previous_input_direction = input_direction
	
	
func _physics_process(_delta):
	get_input()
	move_and_slide()
