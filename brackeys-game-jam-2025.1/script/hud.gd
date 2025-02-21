extends CanvasLayer

@onready var energy_bar =$MarginContainer/GridContainer/Energy/ProgressBar
@onready var moral_bar = $MarginContainer/GridContainer/Moral/ProgressBar
@onready var intelligence_bar = $MarginContainer/GridContainer/Intelligence/ProgressBar
@onready var stress_bar = $MarginContainer/GridContainer/stress/ProgressBar
@onready var money = $MarginContainer/money/Label2

@onready var phone = $phone_option
@onready var phone_option = $phone_option/PanelContainer/MarginContainer/HBoxContainer
@onready var contact_onglet = $phone_option/PanelContainer/MarginContainer/VBoxContainer

@onready var contact_container = $phone_option/PanelContainer/MarginContainer/VBoxContainer/contact_container


@onready var black_screen = $ColorRect

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black_screen.fade_in()
	player = get_node("../Player") # Replace with function body.
	
	if(player != null):
		print(player)
		set_gauge(player)
		add_contact()



func set_gauge(player : Player):
	print("setgauge read")
	energy_bar.set_value(player.player_energy)
	moral_bar.set_value(player.player_moral)
	intelligence_bar.set_value(player.player_intelligence)
	stress_bar.set_value(player.player_stress)
	money.text = str(player.player_money)

func show_dialogue():
	pass

func add_contact():
	for contact in player.contact:
		var button = Button.new()
		button.text = contact.npc_name
		button.pressed.connect(self._contact_pressed.bind(contact))
		contact_container.add_child(button)


func _contact_pressed(contact : Npc):
	pass



func _on_cancel__contact_container_pressed() -> void:
	contact_onglet.hide()
	phone_option.show()
	


func _on_contact_pressed() -> void:
	phone_option.hide()
	contact_onglet.show() # Replace with function body.
