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
	player = get_node("Player") # Replace with function body.
	Global.player = player
	print(player)
	phase = Global.day_phase.MATIN
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/first_day.dialogue") , "start")


func _on_player_stat_changed() -> void:
	hud.set_gauge(player) # Replace with function body.


func _on_lit_sleeping() -> void:
	hud.black_screen.fade_out_sleeping()
	if( Global.money_palier[0] != null):
		if(Global.player_money > Global.money_palier[0]):
			Global.money_disaster(player)
			Global.export_player_stat(player)

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
