extends Node2D
@export var boss_name: String

@export var anger_mob: PackedScene
@export var fear_mob: PackedScene
@export var anxiety_mob: PackedScene
@export var grief_mob: PackedScene

@export var anger_percent: int
@export var fear_percent: int
@export var anxiety_percent: int
@export var grief_percent: int

@export var anger_rate: int
@export var fear_rate: int
@export var anxiety_rate: int
@export var grief_rate: int

@export var total_victory_score: int
@export var victory_multiplier: int
@export var static_path : PackedScene

@onready var brain = get_node("Brain")
@onready var victory_score = 0

signal killed_enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	#ADD STATIC EFFECT
	var static_effect = static_path.instantiate()
	$Camera2D.add_child(static_effect)
	
	var static_tween = get_tree().create_tween()
	#tween.set_trans(Tween.TRANS_EXPO)
	static_tween.tween_property(static_effect, "scale", Vector2(0.5,0.5), 0.5)
	static_tween.tween_property(static_effect, "modulate:a", 0, 0.2)
	static_tween.tween_callback(static_effect.queue_free)
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($Camera2D, "zoom", Vector2(4,4), 0.5)
	
	var tween2 = get_tree().create_tween()
	tween2.set_trans(Tween.TRANS_ELASTIC)
	tween2.tween_property($Camera2D, "rotation", 0, 0.5)
	
	$mob_spawn_timer.start()
	Global.camera = $Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	pass

func _on_mob_spawn_timer_timeout():
	if not Global.win:
		var mob_to_spawn = ""
		var spawn_percent = (randi() % 100 + 1)
		if  spawn_percent <= anger_percent:
			mob_to_spawn = "anger_mob"
		elif spawn_percent <= fear_percent + anger_percent:
			mob_to_spawn = "fear_mob"
		elif spawn_percent <= anxiety_percent + fear_percent + anger_percent:
			mob_to_spawn = "anxiety_mob"
		else:
			mob_to_spawn = "grief_mob"
			
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
						mob.hide_health_bar()
					else:
						print("fail")
					
			"fear_mob":
				for n in fear_rate:
					if roundi(randf()):
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
						
						# Connect the mob's victory signal
						mob.raise_victory.connect(_on_anger_enemy_raise_victory)
							
						# Spawn the mob by adding it to the Main scene.
						add_child(mob)
						mob.hide_health_bar()
					
			"anxiety_mob":
				for n in anxiety_rate:
					if roundi(randf()):
						var mob = PackedScene
						mob = anxiety_mob.instantiate()
						
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
						#mob.hide_health_bar()
					
			"grief_mob":
				for n in grief_rate:
					if roundi(randf()):
						var mob = PackedScene
						mob = grief_mob.instantiate()
						
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
						#mob.hide_health_bar()
		
func _on_anger_enemy_raise_victory(vp):
	victory_score += vp
	if victory_score >= total_victory_score:
		fade_to_win()

func fade_to_win():
	if not Global.win:
		Global.win = true
		
		match boss_name:
			"Anger": Global.anger_defeated = true
			"Fear": Global.fear_defeated = true
			"Anxiety": 
				Global.anxiety_defeated = true
				get_tree().change_scene_to_file("res://Scenes/ending.tscn")
			"Grief": Global.grief_defeated = true
			
		Global.door_level += 1
		
		get_tree().call_group("card","remove_card_effect")
		$FadeToWin.show()
		$FadeToWin/FadetoWhite.play("fade to white")

func _on_fadeto_white_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")
