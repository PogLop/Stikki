extends Control

const sticky = preload("paper.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.doubleclick:
			add_note(get_global_mouse_position())

#add arg. color
func add_note(pos):
	var thing = sticky.instance()
	$notes.add_child(thing)
	thing.position = pos

func trash_focus():
	$Button.grab_focus()
