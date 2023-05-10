extends Node2D
@export var mob_scene: PackedScene

@onready var brain = get_node("Brain")

# Called when the node enters the scene tree for the first time.
func _ready():
	$mob_spawn_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_mob_spawn_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

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
