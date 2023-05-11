extends Node2D
@export var anger_mob: PackedScene
@export var fear_mob: PackedScene
@export var anger_percent: int
@export var fear_percent: int

@onready var brain = get_node("Brain")

# Called when the node enters the scene tree for the first time.
func _ready():
	$mob_spawn_timer.start()
	Global.camera = $Camera2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_mob_spawn_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = PackedScene
	if (randi() % 100 + 1) <= anger_percent:
		mob = anger_mob.instantiate()
	else:
		mob = fear_mob.instantiate()
		
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's position to a random location on the spawn path
	mob.position = mob_spawn_location.position
	
	# Choose the velocity for the mob.
	mob.velocity = mob.global_position.direction_to(brain.global_position)
	print("spawn")
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
