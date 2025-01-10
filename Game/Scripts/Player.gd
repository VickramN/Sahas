extends CharacterBody2D

@export var stats : Stats
#Player Movement Variable

@export var speed = 100
@export var gravity = 200
@export var jump_height = -100


func _ready() -> void:
	#loads default stats
	var default_stats = load("res://resources/mystats.tres")
	
func _physics_process(delta):
	#Calulate vertical movement speed(i.e Falling)
	velocity.y += gravity * delta
	
	horizontal_movement()
	move_and_slide()
	
	if !Global.is_attacking || !Global.is_climbing:
		player_animations()
		
	
func horizontal_movement():
	#If left or right movement key is pressed, return 1 for right, return -1 for left, and 0 for staying still
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#caclulate player movement
	velocity.x = horizontal_input * speed
	
#Animations
func player_animations():
	if Input.is_action_pressed("ui_left") and is_on_floor():
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Run")
		$CollisionShape2D.position.x = 6
	
	if Input.is_action_pressed("ui_right") and is_on_floor():
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Run")
		$CollisionShape2D.position.x = -6
	
	if !Input.is_anything_pressed() and is_on_floor():
		$AnimatedSprite2D.play("Idle")
	

func _input(event):
	if Input.is_action_pressed("ui_attack"):
		Global.is_attacking = true
		$AnimatedSprite2D.play("Attack")
	
	if Input.is_action_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_height
		$AnimatedSprite2D.play("Jump")
		
	if Global.is_climbing == true:
		if Input.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("Climb")
			gravity = 100
			velocity.y = -85
		else:
			gravity = 200
	

func _on_animated_sprite_2d_animation_finished():
	Global.is_attacking = false
	Global.is_climbing = false
