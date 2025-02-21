extends ColorRect

@onready var day = $Label
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#await animation.animation_finished
	pass

func fade_in():
	day.text =  "day " + str(Global.day_number)
	animation.play("fade_in")
	
func fade_in_without_text():
	animation.play("fade_in_without_text")
	
func fade_out():
	show()
	animation.play("fade_out")

func fade_out_sleeping():
	show()
	animation.play("fade_out_sleep")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print(anim_name)
	if(anim_name == "fade_in" or anim_name == "fade_in_without_text"):
		hide()
	elif(anim_name == "fade_out_sleep"):
		fade_in()
	else:
		fade_in_without_text()
		
