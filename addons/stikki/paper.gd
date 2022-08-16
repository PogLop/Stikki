tool
extends Node2D

var mouse_over = false
var following = false

var speed = Vector2.ZERO
var offset = Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and  event.is_pressed() and mouse_over:
			$things/TextEdit.grab_focus()
		if event.button_index == BUTTON_LEFT and event.is_pressed() and mouse_over:
			following = true
			offset = get_global_mouse_position() - global_position
			$things.scale = Vector2.ONE * 0.9
		elif event.button_index == BUTTON_LEFT and event.is_pressed() and (not mouse_over) and $things/TextEdit.has_focus():
			get_parent().get_parent().trash_focus()
		if not event.is_pressed():
			following = false

	if event is InputEventKey:
		if event.is_pressed() and $things/TextEdit.has_focus():
			if event.scancode == KEY_DELETE:
				print("oky")
				mouse_over = false
				die()

func _physics_process(delta):
	$things.scale = lerp($things.scale, Vector2.ONE, delta * 15)
	$things/Label.text = $things/TextEdit.text
	
	z_index = global_position.y

	if following:
		var target = get_global_mouse_position() - offset
		speed = lerp(speed, (target-global_position) * 10, delta * 20)
	else:
		speed = lerp(speed, Vector2.ZERO, delta * 10)
		
	global_position += speed * delta
	bouncyyyy()
	
	if len($things/Label.text) >= 83:
		get_parent().get_parent().trash_focus()

func bouncyyyy():
	rotation = speed.angle()
	$things.rotation = -rotation
	scale.x = pow(1.1, sqrt(speed.length())/50)
	scale.y = pow(1.1, -sqrt(speed.length())/50)

func die():
	get_parent().get_parent().trash_focus()
	queue_free()

func _on_NinePatchRect_mouse_entered():
#	print("oky")
	mouse_over = true

func _on_NinePatchRect_mouse_exited():
	mouse_over = false
