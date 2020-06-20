extends KinematicBody2D

# Const variables
const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

# Variables
onready var animationPlayer = $AnimationPlayer
var velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# pega o vetor e normaliza para mesmo na diagonal, 
	# ele fique com a mesma distancia
	input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			animationPlayer.play("RunRight")
		elif input_vector.x < 0:
			animationPlayer.play("RunLeft")
		elif input_vector.y > 0:
			animationPlayer.play("RunDown")
		elif input_vector.y < 0:
			animationPlayer.play("RunUp")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		# print(velocity)
	else:
		animationPlayer.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	# print(velocity)
	velocity = move_and_slide(velocity)
