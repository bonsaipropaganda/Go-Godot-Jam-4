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
#var hand_size = 4
#Card locations by default in gameplay
@export var card_one_position : Vector2
@export var card_two_position : Vector2
@export var card_three_position : Vector2
@export var card_four_position : Vector2
@onready var hand_positions = [card_one_position, card_two_position, card_three_position, card_four_position]

#CARD PILE ARRAYS
#var deck = []
#var hand = []
#var discard = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.deck == []):
	#ADD CARDS TO DECK
		if more_speed_cards:
			for n in more_speed_cards:
				Global.deck.append("more_speed")
		
		if more_health_cards:
			for n in more_health_cards:
				Global.deck.append("more_health")
				
		if more_anger_cards:
			for n in more_anger_cards:
				Global.deck.append("more_anger")
				
		if more_fear_cards:
			for n in more_fear_cards:
				Global.deck.append("more_fear")
				
		if more_anxiety_cards:
			for n in more_anxiety_cards:
				Global.deck.append("more_anxiety")
				
		if more_grief_cards:
			for n in more_grief_cards:
				Global.deck.append("more_grief")
		
		Global.deck.shuffle()
	
	#ADD CARDS TO HAND
	if Global.deck.size() > 0:
		for n in Global.hand_size:
			if Global.hand.size() < Global.hand_size:
				Global.hand.append(Global.deck.pop_front())
				
	#CREATE CARD NODES TO SCENE
	for n in Global.hand.size():
		var new_card = card_path.instantiate()
		new_card.position = hand_positions[n]
		new_card.card_slot = n
		new_card.value = Global.hand[n]
		new_card.discard_card.connect(_on_card_discard_card)
		add_child(new_card)
		print("Card created:" + new_card.value)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_card_discard_card(card_slot):
	print("It worked!")
	#MOVE CARD FROM HAND TO DISCARD
	Global.discard.append(Global.hand.pop_at(card_slot))
	
	#MOVE NEXT CARD FROM DECK TO HAND
	if Global.deck.size() > 0:
		Global.hand.insert(card_slot,Global.deck.pop_front())
	else: #IF DECK EMPTY - SHUFFLE DISCARD AND PUT IN DECK
		Global.deck = Global.discard
		Global.discard = []
		Global.deck.shuffle()
		Global.hand.insert(card_slot,Global.deck.pop_front())

	#CREATE NEW CARD NODE
	var new_card = card_path.instantiate()
	new_card.position = hand_positions[card_slot]
	new_card.card_slot = card_slot
	new_card.value = Global.hand[card_slot]
	new_card.discard_card.connect(_on_card_discard_card)
	add_child(new_card)
	print("Card created:" + new_card.value)

	#ADD CARDS TO HAND
	if Global.deck.size() > 0:
		for n in Global.hand_size:
			if Global.hand.size() < Global.hand_size:
				Global.hand.append(Global.deck.pop_front())


