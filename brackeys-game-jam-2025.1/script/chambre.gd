extends Node2D

@onready var hud = $HUD
@onready var computer_option = $HUD/computer_option
@onready var phone_option = $HUD/phone_option

@onready var ordi = $ordi
@onready var lit = $Lit
@onready var phone = $phone

@onready var criquet = $criquet


var player : Player
var no_money : bool = false
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
	criquet.play()
	var chose_misfortune = randi() % 10
	print(chose_misfortune)
	match chose_misfortune :
		0,1,2,3,8:
			print("money disaster occured")
			if( !Global.money_palier.is_empty()):
				if(Global.player_money > Global.money_palier[0]):
					await Global.money_disaster(player)
					if(no_money):
						return
				

		4,5,6,7:
			if(!Global.all_stress_disaster.is_empty()):
				print("stress disaster")
				await Global.stress_disaster(player)

		_:
			print("tout est chill")
	
	hud.black_screen.fade_in()
	await hud.black_screen.animation.animation_finished
	criquet.stop()
	if(await Global.main_morning_event()):
		if(Global.finish):
			hud.black_screen.end_fade_out()
			await hud.black_screen.animation.animation_finished
			get_tree().change_scene_to_file("res://scene/main_menu.tscn")
			return
		pass
	else:
		DialogueManager.show_dialogue_balloon(load("res://dialogue/waking_up.dialogue") , "start")
		await DialogueManager.dialogue_ended
			
	if(player.player_stress >= 75):
		player.increment_gauge( 50, "energy")
	elif (player.player_stress >= 40):
		player.increment_gauge( 75, "energy")
	else:
		player.increment_gauge(100 , "energy")
	
	if(Global.nb_assignment!= 0 ):
		hud.show_progression_bar()




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


func _on_player_money_game_over() -> void:
	no_money =true
	DialogueManager.show_dialogue_balloon(load("res://dialogue/final_day.dialogue") , "out_of_money")
	await DialogueManager.dialogue_ended
	await DialogueManager.dialogue_ended
	hud.black_screen.end_fade_out()
	await hud.black_screen.animation.animation_finished
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")
