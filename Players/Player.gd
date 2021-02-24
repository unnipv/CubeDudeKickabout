extends KinematicBody


var motion = Vector3()
const UP = Vector3(0,1,0)

export var player_id = 1
var can_move = true
var my_spawn

const SPEED = 15

func _ready():
	my_spawn = get_tree().get_root().find_node("Player%sStart" % player_id, true, false)

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	move()
	animate()
	face_forward()

func move():
	var x = Input.get_action_strength("right_%s" % player_id) - Input.get_action_strength("left_%s" % player_id)
	var z = Input.get_action_strength("down_%s" % player_id) - Input.get_action_strength("up_%s" % player_id)
	motion = Vector3(x,0,z)
	if can_move:
		move_and_slide(motion.normalized() * SPEED, UP)
	
func animate():
	if motion.length() > 0 and can_move:
		$AnimationPlayer.play("Arms Cross Walk")
	else:
		$AnimationPlayer.stop()
		
func face_forward():
	if not motion.x == 0 or not motion.z == 0:
		if can_move:
			look_at(Vector3(-motion.x,0,-motion.z)*SPEED,UP)
		
func freeze():
	can_move = false

func reset():
	translation = my_spawn.translation
	can_move = true
