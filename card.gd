extends Area2D

var dragging = false
var drag_offset = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to the Area2D signals to themselves
	pass # Replace with function body.

func _input_event(_viewport, event: InputEvent, _shape_idx) -> void:
	# Detects the initial touch on Mobile Screen or the Left Mouse click
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) or event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			drag_offset = get_global_mouse_position() - global_position
			# Bring the card to the front, visually
			z_index = 100
		else:
			dragging = false
			z_index = 0
			
			# ToDo: Stacking Check triggers

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - drag_offset
