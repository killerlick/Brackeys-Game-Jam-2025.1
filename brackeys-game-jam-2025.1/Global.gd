extends Node

var day_number = 1
enum day_phase { MATIN ,MIDI ,SOIR , NUIT}

var player : Player

var money_palier : Array[int] = [200 , 100 , 200 ,0]
var encountered_rat : bool = false

var actual_phase  = day_phase.MATIN
var nb_assignment :int = 0 
var assignment_finished : bool = false

var NB_ENDING : int = 10
var ending_unlocked : int = 0

var player_energy : int = 100
var player_moral : int = 70
var player_intelligence : int = 30
var player_stress : int = 0
var player_alcolemy : int = 0
var player_money : int = 500

var finish : bool = false
var all_stress_disaster = ["strange_noise_night" , "dad_call" , "strange_noise_night" , "noisy_neighbors"]

func next_phase():
	match actual_phase :
		Global.day_phase.MATIN:
			actual_phase = Global.day_phase.MIDI
		Global.day_phase.MIDI:
			actual_phase = Global.day_phase.SOIR
		Global.day_phase.SOIR:
			actual_phase = Global.day_phase.NUIT
		Global.day_phase.NUIT:
			actual_phase = Global.day_phase.MATIN

func event_manager():
	pass

func money_disaster(player : Player ):
	if(player_money > money_palier[0]):
		print(player_money)
		if(encountered_rat):
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/money_disaster.dialogue") , "start2")
		else:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/money_disaster.dialogue") , "start")
			encountered_rat = true
		await DialogueManager.dialogue_ended
		money_palier.pop_front()

func moral_disaster(player : Player):
	pass

func stress_disaster(player : Player):
	if(day_number < 3 && player.player_stress <= 10 ):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/stress_disaster.dialogue") , "first_night_alone")
	else:
		var disaster_chosen = randi() % all_stress_disaster.size()
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/stress_disaster.dialogue") ,all_stress_disaster.pop_at(disaster_chosen) )
	await DialogueManager.dialogue_ended
  
func main_morning_event() -> bool:
	if(day_number == 5):
		DialogueManager.show_dialogue_balloon(load("res://dialogue/professor_dialogue.dialogue"),"assignement_given")
		await DialogueManager.dialogue_ended
		nb_assignment+=1
		return true
	
	elif(day_number == 7):
		if(assignment_finished):
			DialogueManager.show_dialogue_balloon(load("res://dialogue/professor_dialogue.dialogue") , "assignment_finished")
			await DialogueManager.dialogue_ended
		else:
			DialogueManager.show_dialogue_balloon(load("res://dialogue/professor_dialogue.dialogue") , "assignment_incomplete")
			await DialogueManager.dialogue_ended
		return true
	elif(day_number == 12):
		if(player_stress >= 95 ):
			DialogueManager.show_dialogue_balloon(load("res://dialogue/final_day.dialogue") , "final_exam_stressed")
			await DialogueManager.dialogue_ended
		elif(player_intelligence >= 90 && player_energy != 0):
			DialogueManager.show_dialogue_balloon(load("res://dialogue/final_day.dialogue") , "exam_success")
			await DialogueManager.dialogue_ended
		elif(player_intelligence <= 90 && player_energy != 0):
			DialogueManager.show_dialogue_balloon(load("res://dialogue/final_day.dialogue") , "exam_mid")
			await DialogueManager.dialogue_ended
		elif(player_energy == 0):
			DialogueManager.show_dialogue_balloon(load("res://dialogue/final_day.dialogue") , "exam_missed")
			await DialogueManager.dialogue_ended
		elif(player_moral < 30):
			DialogueManager.show_dialogue_balloon(load("res://dialogue/final_day.dialogue") , "exam_refused")
			await DialogueManager.dialogue_ended
		finish = true
		return true
		
	return false

func import_player_stat(player : Player):
	player_energy = player.player_energy
	player_moral = player.player_moral
	player_intelligence = player.player_intelligence
	player_stress = player.player_stress
	player_alcolemy = player.player_alcolemy
	player_money = player.player_money


func export_player_stat(player : Player):
	player.player_energy = player_energy
	player.player_moral = player_moral
	player.player_intelligence = player_intelligence
	player.player_stress = player_stress
	player.player_alcolemy = player_alcolemy
	player.player_money = player_money
