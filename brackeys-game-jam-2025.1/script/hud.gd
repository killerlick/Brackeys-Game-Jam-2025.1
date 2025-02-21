extends CanvasLayer

@onready var energy_bar =$MarginContainer/GridContainer/Energy/ProgressBar
@onready var moral_bar = $MarginContainer/GridContainer/Moral/ProgressBar
@onready var intelligence_bar = $MarginContainer/GridContainer/Intelligence/ProgressBar
@onready var stress_bar = $MarginContainer/GridContainer/stress/ProgressBar
@onready var money = $MarginContainer/money/Label2

@onready var black_screen = $ColorRect

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black_screen.fade_in()
	player = get_node("../Player") # Replace with function body.
	
	if(player != null):
		print(player)
		set_gauge(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_gauge(player : Player):
	print("setgauge read")
	energy_bar.set_value(player.player_energy)
	moral_bar.set_value(player.player_moral)
	intelligence_bar.set_value(player.player_intelligence)
	stress_bar.set_value(player.player_stress)
	money.text = str(player.player_money)

func show_dialogue():
	pass
