extends Node2D

@onready var hud = $HUD
@onready var computer_option = $HUD/computer_option
@onready var phone_option = $HUD/phone_option

@onready var ordi = $ordi
@onready var lit = $Lit
@onready var phone = $phone


var player : Player
var phase 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hud.black_screen.fade_in()
	await hud.black_screen.animation.animation_finished
	player = get_node("Player") # Replace with function body.
	Global.player = player
	print(player)
	phase = Global.day_phase.MATIN
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/first_day.dialogue") , "start")


func _on_player_stat_changed() -> void:
	hud.set_gauge(player) # Replace with function body.


func _on_lit_sleeping() -> void:
	hud.black_screen.fade_out_sleeping()
	await hud.black_screen.animation.animation_finished
	var chose_misfortune = randi() % 10
	match chose_misfortune :
		_:
			print("money disaster occured")
			if( !Global.money_palier.is_empty()):
				if(Global.player_money > Global.money_palier[0]):
					await Global.money_disaster(player)
		1 , 2,3:
			if(!Global.all_stress_disaster.is_empty()):
				print("stress disaster")
				await Global.stress_disaster(player)

		_:
			print("tout est chill")
	
	hud.black_screen.fade_in()
	await hud.black_screen.animation.animation_finished



func _on_study_pressed() -> void:
	ordi.studying()
	computer_option.hide()

func _on_work_pressed() -> void:
	ordi.work() # Replace with function body.
	computer_option.hide()

func _on_assignement_pressed() -> void:
	ordi.school_work() # Replace with function body.
	computer_option.hide()


func _on_play_game_pressed() -> void:
	ordi.play_game() # Replace with function body.
	computer_option.hide()


func _on_cancel_pressed() -> void:
	computer_option.hide() # Replace with function body.


func _on_cancel_phone_pressed() -> void:
	phone_option.hide() # Replace with function body.
