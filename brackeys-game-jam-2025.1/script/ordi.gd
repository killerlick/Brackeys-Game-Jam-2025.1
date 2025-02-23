extends Area2D

@onready var sprite = $Sprite2D
@onready var computer_option = $"../HUD/computer_option"
@onready var progression_bar = $"../HUD/computer_option/background_pc/MarginContainer/HBoxContainer/VBoxContainer/progression"
var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player") # Replace with function body.
	print(player)
	if(player != null):
		pass # Replace with function body.





func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		computer_option.show()

func studying():
	if(player.decrement_gauge(25 , "energy")):
		player.increment_gauge(2 , "intelligence")
		player.increment_gauge(2 , "stress")
		player.decrement_gauge(2 , "moral")
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") , "study_no_energy")
		

func work():
	if(player.decrement_gauge(25 , "energy")):
		player.decrement_gauge(70 , "money")
		player.decrement_gauge(3 , "moral")
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") , "work_no_energy")
		

func school_work():
	if(player.decrement_gauge(25 , "energy")):
		if(Global.nb_assignment < 1):
			player.increment_gauge(25 , "energy")
			DialogueManager.show_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") ,"no_assignment")
		else:
			if(progression_bar.value < 100):
				if(player.player_intelligence <40):
					progression_bar.value += 12
				else:
					progression_bar.value += 20
					
				if(progression_bar.value == 100):
					Global.assignment_finished = true
					DialogueManager.show_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") ,"assignment_finish")
			else:
				DialogueManager.show_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") ,"assignment_full")
				
				
			
	else:
		if(Global.nb_assignment < 1):
			DialogueManager.show_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") ,"no_assignment_no_energy")
		else:
			DialogueManager.show_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") ,"assignment_no_energy")
			
func play_game():
	if(player.decrement_gauge(25 , "energy")):
		player.increment_gauge(2 , "moral")
		player.decrement_gauge(3, "stress")
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") , "play_game_no_energy")
		



func _on_mouse_entered() -> void:
	sprite.modulate = Color(0.7,0.7,0.7)

func _on_mouse_exited() -> void:
	sprite.modulate = Color(1,1,1) # Replace with function body.
