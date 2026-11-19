extends Node2D

var elapsed_time: float = 0.0
var duration: float = 0.25
var starting_position: Vector2i
var started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if elapsed_time >= duration:
		queue_free()
	if started:
		elapsed_time += delta
		self.global_position = get_parabel_pos(elapsed_time)
		#move(move_start_pos, move_end_pos, speed*delta)

func create(pos: Vector2i) -> void:
	starting_position = pos
	started = true

func get_parabel_pos(passed_time: float) -> Vector2i:
	const amplifier: int = 100
	var normalized = passed_time - duration*0.5
	var stretch_factor: float = 3
	var f: float = pow(normalized/stretch_factor, 2) * amplifier
	var new_x: int = roundi(starting_position.x + passed_time * amplifier)
	var new_y: int = roundi(starting_position.y + f * amplifier)
	return Vector2i(new_x, new_y)
	
