extends Area2D
@export var speed : int
@export var max_health : int
@export var health_height : int
@export var health_loss_speed : int

@onready var health = max_health
@onready var health_bar_size = health/5

@onready var brain = get_parent().get_node("Brain")

@onready var swell_speed = 0.01

var velocity = Vector2.ZERO
var mouse_in = false
var mouse_held = false
var dead = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = str((randi() % 4) + 1)
	$AnimatedSprite2D.play()
	$HealthBar.size = Vector2(health_bar_size,health_height)
	$HealthBar.position -= Vector2(health_bar_size/2,0)
	$HealthBar/RemainingHealth.size = Vector2(health_bar_size,health_height)
	$AnimatedSprite2D/SwellEffect.pause()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = global_position.direction_to(brain.global_position)
	position += velocity * delta * speed
	if mouse_held and not $Death.playing:
		$HealthBar/RemainingHealth.size = Vector2(health_bar_size * (health-health_loss_speed) / max_health,health_height)
		health -= health_loss_speed
		$Damage.play()
		$AnimatedSprite2D/SwellEffect.advance(swell_speed)
		if health <= 0 and not $Death.playing:
			$Damage.stop()
			$Death.play()
			dead = true
			hide()

func _input(event):
	if mouse_in and event is InputEventMouseButton and event.is_pressed():
		mouse_held = true
		print("pressed")
	elif mouse_held and mouse_in and event is InputEventMouseButton and not event.is_pressed():
		print("released")
		mouse_held = false
	

func _on_mouse_entered():
	print("mouse In")
	mouse_in = true;

func _on_mouse_exited():
	mouse_in = false;


func _on_death_finished():
	queue_free()
