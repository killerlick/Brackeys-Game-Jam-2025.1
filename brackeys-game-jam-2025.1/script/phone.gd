extends Area2D

@onready var sprite = $Sprite2D
@onready var phone_option = $"../HUD/phone_option"

var player : Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("../Player") # Replace with function body.
	print(player)
	if(player != null):
		pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Le joueur a cliqué sur le phone !")
		phone_option.show()

func _on_mouse_entered() -> void:
	sprite.modulate = Color(0.7,0.7,0.7)


func _on_mouse_exited() -> void:
	sprite.modulate = Color(1,1,1) 
