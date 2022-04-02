extends Camera2D

export (float) var default_zoom = 2;
export (float) var focus_zoom = 2.5;
func _ready():
	zoom = Vector2(default_zoom, default_zoom)


func focusOn(target: Vector2):
	$Tween.interpolate_property(self, "global_position", self.global_position, target, 0.3, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "zoom", self.zoom, Vector2(focus_zoom,focus_zoom), 0.3, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	
func unfocus():
	$Tween.interpolate_property(self, "zoom", self.zoom, Vector2(default_zoom,default_zoom), 0.4, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	
