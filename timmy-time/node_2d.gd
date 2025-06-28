extends CharacterBody2D

@onready var animations = $AnimationPlayer


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

func _update_animations():
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
		


func _physics_process(delta: float) -> void:
	#if Input.is_action_pressed("E"):
		#animations.play("keytar")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if Input.is_action_pressed("E"):
			animations.play("keytar")
			$AudioStreamPlayer2D.play()
		else:
			animations.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if Input.is_action_pressed("E"):
			animations.play("keytar")
		else:
			animations.play("RESET")
	

	move_and_slide()
	_update_animations()
