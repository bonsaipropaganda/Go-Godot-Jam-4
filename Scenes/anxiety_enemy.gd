extends Area2D
@export var start_speed : int
@export var victory_multiplier: int

@export var static_path : PackedScene

@onready var brain = get_parent().get_node("Brain")

var velocity = Vector2.ZERO
var mouse_in = false
var dead = false

#ADJUST SPEED ACCORDING TO CARD MULTIPLIER
@onready var speed = start_speed * ((Global.more_speed * Global.speed_multiplier) + 1)

#SIGNAL TO RAISE VICTORY BAR UPON DEATH
signal raise_victory

func _ready():
	$AnimatedSprite2D.animation = str((randi() % 4) + 1)
	$AnimatedSprite2D.play()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#velocity = global_position.direction_to(brain.global_position)
	position += velocity * delta * speed
			
func _on_mouse_entered():
	mouse_in = true;
	get_tree().call_group("brain_collision","take_damage")
	queue_free()
	print("in anxiety")

func _on_mouse_exited():
	mouse_in = false;

func _on_death_finished():
	queue_free()
