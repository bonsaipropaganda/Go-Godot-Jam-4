extends StaticBody2D
@export var speed = 0.5;

@onready var player = get_parent().get_node("Brain")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = global_position.direction_to(player.global_position) * speed
	move_and_collide(velocity,false,1,false)
