extends Node

var day_number = 1
enum day_phase { MATIN ,MIDI ,SOIR , NUIT}

var actual_phase  = day_phase.MATIN

var nb_exercice = 0 

var NB_ENDING : int = 10

var ending_unlocked : int = 0

var player_energy : int = 100
var player_morale : int = 70
var player_intelligence : int = 30
var player_stress : int = 0
var player_alcolemy : int = 0

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


func event_producer():
	pass
