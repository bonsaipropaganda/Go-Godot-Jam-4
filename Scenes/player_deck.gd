extends Node2D

#CARD PATH
const card_path = preload("res://Scenes/card.tscn")

@export var more_speed_cards : int
@export var more_health_cards : int
@export var more_fear_cards : int
@export var more_anger_cards : int
@export var more_anxiety_cards : int
@export var more_grief_cards : int
#@export var smaller_mouse_cards : int
#@export var bigger_brain_cards : int

#VARIABLES
var hand_size = 4
#Card locations by default in gameplay
@export var card_one_position : Vector2
@export var card_two_position : Vector2
@export var card_three_position : Vector2
@export var card_four_position : Vector2
@onready var hand_positions = [card_one_position, card_two_position, card_three_position, card_four_position]

#CARD PILE ARRAYS
var deck = []
var hand = []
var discard = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#ADD CARDS TO DECK
	for n in more_speed_cards:
		deck.append("more_speed")
	for n in more_health_cards:
		deck.append("more_health")
	for n in more_anger_cards:
		deck.append("more_anger")
	for n in more_fear_cards:
		deck.append("more_fear")
	for n in more_anxiety_cards:
		deck.append("more_anxiety")
	for n in more_grief_cards:
		deck.append("more_grief")
	
	deck.shuffle()
	
	#ADD CARDS TO HAND
	if deck.size() > 0:
		for n in hand_size:
			if hand.size() < hand_size:
				hand.append(deck.pop_front())
				
	#CREATE CARD NODES TO SCENE
	for n in hand.size():
		var new_card = card_path.instantiate()
		new_card.position = hand_positions[n]
		new_card.value = hand[n]
		add_child(new_card)
		print("Card created:" + new_card.value)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
