extends Area2D
@export var start_speed : int
@export var max_health : int
@export var health_height : int


@onready var brain = get_parent().get_node("Brain")

var velocity = Vector2.ZERO
var mouse_in = false
var dead = false

#ADJUST SPEED ACCORDING TO CARD MULTIPLIER
@onready var speed = start_speed * ((Global.more_speed * Global.speed_multiplier) + 1)

#ADJUST HEALTH ACCORDING TO CARD MULTIPLIER
@onready var health = max_health * ((Global.more_health * Global.health_multiplier) + 1)

@onready var health_bar_size = health/5 # ADJUST HEALTH BAR SIZE TO HEALTH AMOUNT

func _ready():
	$AnimatedSprite2D.play()
	max_health = health
	$HealthBar.size = Vector2(health_bar_size,health_height)
	$HealthBar.position -= Vector2(health_bar_size/2,0)
	$HealthBar/RemainingHealth.size = Vector2(health_bar_size,health_height)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = global_position.direction_to(brain.global_position)
	position += velocity * delta * speed

func _input(event):
	if mouse_in and event is InputEventMouseButton and event.pressed and not $Death.playing:
		print(health)
		$HealthBar/RemainingHealth.size = Vector2(health_bar_size * (health-Global.attackDamage) / max_health,health_height)
		print("hit!")
		$Damage.play()
		health -= Global.attackDamage
		print(health)
		if health <= 0:
			$Damage.stop()
			$Death.play()
			#Global.camera.shake(0.1,5,5)
			dead = true
			hide()
			
func _on_mouse_entered():
	mouse_in = true;

func _on_mouse_exited():
	mouse_in = false;

func _on_death_finished():
	queue_free()
