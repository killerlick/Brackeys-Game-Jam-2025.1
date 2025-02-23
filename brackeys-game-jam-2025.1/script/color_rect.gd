extends ColorRect

@onready var day = $Label
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func fade_in():
	show()
	day.text =  "day " + str(Global.day_number)
	animation.play("fade_in")
	
	
func fade_in_without_text():
	show()
	animation.play("fade_in_without_text")
	
func fade_out():
	show()
	animation.play("fade_out")

func fade_out_sleeping():
	show()
	animation.play("fade_out_sleep")

func end_fade_out():
	show()
	animation.play("end_fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "fade_in_without_text" or anim_name == "fade_in"):
		hide()
