extends KinematicBody2D

# Const variables
const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

# Variables
# usando $ voce consegue ter acesso a todoso os nodes
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
var velocity = Vector2.ZERO # agora é um vector 2 com (0,0)

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# pega o vetor e normaliza para mesmo na diagonal, 
	# ele fique com a mesma distancia
	input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set('parameters/Idle/blend_position', input_vector)
		animationTree.set('parameters/Run/blend_position', input_vector)
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		# print(velocity)
	else:
		animationPlayer.play("IdleRight")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	# print(velocity)
	velocity = move_and_slide(velocity)
