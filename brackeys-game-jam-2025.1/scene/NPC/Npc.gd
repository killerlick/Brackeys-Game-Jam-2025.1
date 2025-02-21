extends Resource

class_name Npc

const MAX_BAR_RELATION : int = 100

var player : Player

@export var npc_name : String
@export var relation_npc_player : float = 0
@export var sprite : Texture


var nb_encounter : int = 0

var occupied : bool
var player_lover : bool


func increment_relation(nb : int):
	relation_npc_player += nb
	if(relation_npc_player > MAX_BAR_RELATION):
		relation_npc_player = MAX_BAR_RELATION

func decrement_relation(nb : int ):
	relation_npc_player -= nb
	if(relation_npc_player < 0):
		relation_npc_player = 0

func set_relation(nb : int):
	relation_npc_player = nb

func display_text():
	pass
