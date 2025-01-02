extends CharacterBody2D

#Player Movement Variable

@export var speed = 100
@export var gravity = 200
@export var jump_height = -100

var is_attacking = false
var is_climbing = false


func _physics_process(delta):
	#Calulate vertical movement speed(i.e Falling)
	velocity.y += gravity * delta
	
	horizontal_movement()
	move_and_slide()
	
	if !is_attacking:
		player_animations()

func horizontal_movement():
	#If left or right movement key is pressed, return 1 for right, return -1 for left, and 0 for staying still
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#caclulate player movement
	velocity.x = horizontal_input * speed
	
#Animations
func player_animations():
	if Input.is_action_pressed("ui_left") || Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Run")
		$CollisionShape2D.position.x = 6
	
	if Input.is_action_pressed("ui_right") || Input.is_action_just_released("ui_jump"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Run")
		$CollisionShape2D.position.x = -6
	
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("Idle")
	

func _input(event):
	if Input.is_action_pressed("ui_attack"):
		is_attacking = true
		$AnimatedSprite2D.play("Attack")
	
	if Input.is_action_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_height
		$AnimatedSprite2D.play("Jump")
		
	if is_climbing == true:
		if Input.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("Climb")
			gravity = 100
			velocity.y = -200
		else:
			gravity = 200
			is_climbing = false
	

func _on_animated_sprite_2d_animation_finished() -> void:
	is_attacking = false
	is_climbing = false
