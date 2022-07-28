extends Area2D
class_name Player
# handles player controls


onready var sprite = $AnimatedSprite


# movement variables
var moveVector: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
const SPEED = 6 * 32


func _input(event):
	moveVector = handleMoveInput()


func _physics_process(delta):
	applyMovement(moveVector, delta)


func handleMoveInput() -> Vector2:
	var moveVector = Vector2.ZERO
	
	if !Globals.usingController:
		var inputVector = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") , \
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
		moveVector = inputVector.normalized()
	else:
		var inputVector = Vector2(Input.get_joy_axis(0, JOY_AXIS_0), Input.get_joy_axis(0, JOY_AXIS_1))
		if inputVector.length() >= Globals.DEADZONE0:
			moveVector = inputVector.normalized()
	
	return moveVector


func applyMovement(moveVector, delta):
	if moveVector != Vector2.ZERO:
		velocity.x = moveVector.x * SPEED
		velocity.y = moveVector.y * SPEED
	else:
		velocity = Vector2.ZERO
	
	position += velocity * delta


func animateSprite():
	pass
