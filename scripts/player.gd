extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var CAN_JUMP = false # used to track double jump 
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# Reset ability to jump when on floor
		CAN_JUMP = true
		
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# First jump
			velocity.y = JUMP_VELOCITY
			animated_sprite.play("jump")
		elif CAN_JUMP:
			velocity.y = JUMP_VELOCITY * 1.1
			animated_sprite.play("double")
			CAN_JUMP = false
		
	# get input dir: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play Animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	elif velocity.y < 0: # Moving up
		if CAN_JUMP:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("double")
	else:
		animated_sprite.play("fall")
	# Handle Horizontal Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Move Character
	move_and_slide()
