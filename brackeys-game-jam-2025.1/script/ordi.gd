extends Area2D

@onready var sprite = $Sprite2D
@onready var computer_option = $"../HUD/computer_option"

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
	if(player.decrement_gauge(20 , "energy")):
		player.increment_gauge(2 , "intelligence")
		player.increment_gauge(1 , "stress")
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") , "study_no_energy")
		

func work():
	if(player.decrement_gauge(20 , "energy")):
		player.increment_gauge(300 , "money")
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") , "work_no_energy")
		

func school_work():
	pass

func play_game():
	if(player.decrement_gauge(20 , "energy")):
		player.increment_gauge(2 , "moral")
		player.decrement_gauge(5 , "stress")
	else:
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/computer_interaction.dialogue") , "play_game_no_energy")
		



func _on_mouse_entered() -> void:
	sprite.modulate = Color(0.7,0.7,0.7)

func _on_mouse_exited() -> void:
	sprite.modulate = Color(1,1,1) # Replace with function body.
