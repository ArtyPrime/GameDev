extends CharacterBody2D


const SPEED = 200.0

@onready var anim = get_node("AnimationPlayer")

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	var move_direction = Vector2(direction_x,direction_y)
	velocity = move_direction.normalized() * SPEED
	
	
	if move_direction.x < 0 && move_direction.y == 0:
		anim.play("WalkLeft")
	elif move_direction.x > 0 && move_direction.y == 0:
		anim.play("WalkRight")
	elif move_direction.y < 0 && move_direction.x == 0:
		anim.play("WalkUp")
	elif move_direction.y > 0 && move_direction.x == 0:
		anim.play("WalkDown")
	elif move_direction.y < 0 && move_direction.x != 0:
		anim.play("WalkUp")
	elif move_direction.y > 0 && move_direction.x != 0:
		anim.play("WalkDown")
	elif abs(move_direction.y) + abs(move_direction.x) == 0:
		anim.stop(false)
#
	move_and_slide()
