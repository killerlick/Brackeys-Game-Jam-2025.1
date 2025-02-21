extends Node

class_name Player

signal stat_changed

@export var contact : Array[Npc]

var player_name : String = "me"

const MAXBAR : int = 100

var player_energy : int = 100
var player_moral : int = 70
var player_intelligence : int = 30
var player_stress: int = 0
var player_alcolemy : int = 0
var player_health : int = 90

var player_money : int  = 500


func increment_gauge(nb : int , gauge_name : String):
	match gauge_name :
		"energy":
			player_energy+=nb
			if(player_energy>100):
				player_energy = 100
		"moral":
			player_moral+=nb
			if(player_moral>100):
				player_moral = 100
		"intelligence":
			player_intelligence+=nb
			if(player_intelligence>100):
				player_intelligence = 100
		"stress":
			player_stress+=nb
			if(player_stress>100):
				player_stress = 100
		"alcolemy":
			player_alcolemy+=nb
			if(player_alcolemy>100):
				player_alcolemy = 100
		"money":
			player_money+=nb
			
	stat_changed.emit()

func decrement_gauge(nb : int , gauge_name : String)-> bool:
	match gauge_name :
		"energy":
			
			if(player_energy>=nb):
				player_energy-=nb
				print("de" , player_energy)
			else:
				return false
		"moral":
			if(player_moral>=nb):
				player_moral-=nb
			else:
				return false
		"intelligence":
			if(player_intelligence>=nb):
				player_intelligence-=nb
			else:
				return false
		"stress":
			if(player_stress>=nb):
				player_stress-=nb
			else:
				return false
		"alcolemy":
			if(player_alcolemy>=nb):
				player_alcolemy-=nb
			else:
				return false
		"money":
			if(player_money>=nb):
				player_money-=nb
			else:
				return false
	stat_changed.emit()
	return true
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
