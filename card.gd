extends Area2D

var dragging = false
var drag_offset = Vector2.ZERO
var partner_card = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to the Area2D signals to themselves
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	# pass # Replace with function body.

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
			_handle_drop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - drag_offset

func _on_area_entered(other_area):
	partner_card = other_area

		
func _on_area_exited(other_area):
	partner_card = null

func _handle_drop():
	# if not overlapping_cards.is_empty():
		if partner_card != null:
			var card_width = $ColorRect.size.x
			var gap = 10
			global_position = Vector2(
				partner_card.global_position.x + card_width + gap,
				partner_card.global_position.y
			)
