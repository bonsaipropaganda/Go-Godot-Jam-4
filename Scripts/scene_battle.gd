extends Node2D
@export var anger_mob: PackedScene
@export var fear_mob: PackedScene
@export var anger_percent: int
@export var fear_percent: int
@export var anger_rate: int
@export var total_victory_score: int
@export var victory_multiplier: int

@onready var brain = get_node("Brain")
@onready var victory_score = 0

signal killed_enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	$mob_spawn_timer.start()
	Global.camera = $Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if Input.is_action_just_pressed("test_button"):
		print("test button")
		get_tree().change_scene_to_file("res://Scenes/scene_overworld.tscn")


func _on_mob_spawn_timer_timeout():
	
	var mob_to_spawn = ""

	if (randi() % 100 + 1) <= anger_percent:
		mob_to_spawn = "anger_mob"
	else:
		mob_to_spawn = "fear_mob"
	
	match mob_to_spawn:
		"anger_mob": 
			for n in anger_rate:
				if roundi(randf()):
					var mob = PackedScene
					mob = anger_mob.instantiate()
					
					# Choose a random location on Path2D.
					var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
					mob_spawn_location.progress_ratio = randf()
		
					# Set the mob's position to a random location on the spawn path
					mob.position = mob_spawn_location.position
		
					# Choose the velocity for the mob.
					mob.velocity = mob.global_position.direction_to(brain.global_position)
					print("spawn " + mob_to_spawn + " " + str(n))
					
					# Connect the mob's victory signal
					mob.raise_victory.connect(_on_anger_enemy_raise_victory)
					
					# Spawn the mob by adding it to the Main scene.
					add_child(mob)
				else:
					print("fail")
				
		"fear_mob":
			for n in (Global.more_fear + 1):
				var mob = PackedScene
				mob = fear_mob.instantiate()
				
				# Choose a random location on Path2D.
				var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
				mob_spawn_location.progress_ratio = randf()

				# Set the mob's position to a random location on the spawn path
				mob.position = mob_spawn_location.position

				# Choose the velocity for the mob.
				mob.velocity = mob.global_position.direction_to(brain.global_position)
				print("spawn " + mob_to_spawn + " " + str(n))
				
				# Spawn the mob by adding it to the Main scene.
				add_child(mob)

func _on_anger_enemy_raise_victory(vp):
	victory_score += vp
