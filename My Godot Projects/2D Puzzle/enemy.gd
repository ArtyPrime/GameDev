extends CharacterBody2D

var SPEED = 30.0
var JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	player = get_node("../../PlayerNode/Player")
	var direction = (player.position - self.position).normalized()
	
	if chase == true:
		get_node("AnimatedSprite2D").play("Run")
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * SPEED
		elif direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = true
			velocity.x = direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("Idle")
	
	move_and_slide()
	
func _on_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_detection_body_exited(body):
	get_node("AnimatedSprite2D").play("Idle")
	player = get_node("../../PlayerNode/Player")
	var direction = (player.position - self.position).normalized()
	if body.name == "Player":
		chase = false
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		elif direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = true
		velocity.x = 0
