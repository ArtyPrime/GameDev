extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimationPlayer")
var jumpflag

func _physics_process(delta):
	# Add the gravity.
	if is_on_floor():
		jumpflag = 2
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and jumpflag > 0:
		jumpflag -= 1
		velocity.y = JUMP_VELOCITY
		animation.play("Jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	#print(direction)
	if direction == -1:
		get_node("Sprite2D").flip_h = true
	elif direction == 1:
		get_node("Sprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, 100)
		if velocity.y == 0 and is_on_floor():
			animation.play("Idle")
	#if velocity.y == 0:
	#	animation.play("Fall")
	move_and_slide()
	
	if Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_player_death_body_entered(body):
	if body.name == "Enemy":
		Game.playerHP -= 1
		velocity.y = -600
		get_node("Sprite2D").play("Damage")
		await get_node("Sprite2D").animation_finished
		

func _on_player_kill_body_entered(body):
	print("Killing")
	if body.name == "Enemy":
		
		velocity.y = -600
		animation.play("Jump")
		await get_node("Sprite2D").animation_finished
