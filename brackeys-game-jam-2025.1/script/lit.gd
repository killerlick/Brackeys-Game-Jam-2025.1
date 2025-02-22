extends Area2D

@onready var sprite = $Sprite2D

signal sleeping

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player") # Replace with function body.
	print(player)
	if(player != null):
		pass





func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Le joueur a cliqué sur le lit !")
		sleep()# Replace with function body.


func sleep():
	if(player.player_energy >= 80):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/bed_interaction.dialogue") , "full_energy")
	else:
		
		if(player.player_stress >= 50):
			player.increment_gauge(100 , "energy")
			player.decrement_gauge(20 , "energy")
		elif (player.player_stress >= 80):
			player.increment_gauge(100 , "energy")
			player.decrement_gauge(40 , "energy")
		else:
			player.increment_gauge(100 , "energy")
		Global.day_number += 1
		Global.import_player_stat(player)
		sleeping.emit()




func _on_mouse_entered() -> void:
	sprite.modulate = Color(0.7,0.7,0.7)

func _on_mouse_exited() -> void:
	sprite.modulate = Color(1,1,1)
