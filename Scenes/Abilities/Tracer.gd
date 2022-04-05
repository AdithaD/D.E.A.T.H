extends Line2D

var timer = 0

var start_pos
var end_pos

var length 
var speed

signal finished

var drawing = false
func _process(delta):
	if drawing:
		if timer < get_duration():
			timer += delta
			clear_points()
			
			for point in get_tracer():
				add_point(point)
		else:
			clear_points()
			drawing = false
			emit_signal('finished')
		
func submit_tracer(start, end, _length, _speed):
	start_pos = start
	end_pos = end
	length = _length
	speed = _speed
	
	start_tracer()

func start_tracer():
	timer = 0
	drawing = true

func get_tracer():
	var start_delta = (end_pos - start_pos).length() - length
	var direction = (end_pos - start_pos).normalized()
	
	var new_start = start_pos + (direction * speed * timer)
	var new_end = new_start + direction * length
	
	return [new_end, new_start]
	
func get_duration():
	return ((end_pos - start_pos).length() - length) / speed
